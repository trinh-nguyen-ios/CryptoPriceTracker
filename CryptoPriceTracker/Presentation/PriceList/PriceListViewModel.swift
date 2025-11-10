//
//  PriceListViewModel.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol PriceListViewModelType {
    func transForm(input: PriceListViewModel.Input) -> PriceListViewModel.Output
}

class PriceListViewModel: PriceListViewModelType {
    struct Input {
        let searchTrigger: Observable<String>
        let toggleWatchedList: Observable<Crypto>
        let tapCell: Observable<Crypto>
    }
    
    struct Output {
        let cryptoList: Driver<[PriceListModel]>
        let error: Driver<String>
        let isLoading: Driver<Bool>
    }
    let coordinator: PriceListCoordinatorType

    let searchUseCase: SearchCryptoUseCaseType
    let addWatchedListUseCase: AddWatchedListUseCaseType
    let removeWatchListUseCase: RemoveWatchedListUseCaseType
    let fetchWatchedListUseCase: FetchWatchedListUseCaseType
    let disposeBag = DisposeBag()
    
    init(coordinator: PriceListCoordinatorType, searchUseCase: SearchCryptoUseCaseType, addWatchedListUseCase: AddWatchedListUseCaseType, removeWatchListUseCase: RemoveWatchedListUseCaseType, fetchWatchedListUseCase: FetchWatchedListUseCaseType) {
        self.coordinator = coordinator
        self.searchUseCase = searchUseCase
        self.addWatchedListUseCase = addWatchedListUseCase
        self.removeWatchListUseCase = removeWatchListUseCase
        self.fetchWatchedListUseCase = fetchWatchedListUseCase
    }
    
    func transForm(input: Input) -> Output {
        let errorSubject = BehaviorSubject<String>(value: "")
        let loadingSubject = PublishSubject<Bool>()
        
        
        let cryptoList = input.searchTrigger
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Crypto]>  in
                loadingSubject.onNext(true)
                return self.searchUseCase.execute(query: query)
                    .do(onNext: {_ in
                        loadingSubject.onNext(false)
                    }, onError: { error in
                        loadingSubject.onNext(false)
                        errorSubject.onNext(error.localizedDescription)
                    })
                    .catchAndReturn([])
            }
        
        let watchedList = BehaviorRelay<[Crypto]>(value: [])
        
        fetchWatchedListUseCase.execute()
            .observe(on: MainScheduler.instance)
            .bind(to: watchedList)
            .disposed(by: disposeBag)
        
        let combined = Observable.combineLatest(cryptoList, watchedList)
            .map { all, watched in
                all.map { crypto in
                    PriceListModel(crypto: crypto, isWatchedList: watched.contains(where: {$0.id == crypto.id}))
                }
            }
        
        input.toggleWatchedList
            .withLatestFrom(watchedList) { toggle, watched in
                (toggle, watched)
            }
            .flatMapLatest { [weak self] toggle, watchedList -> Observable<[Crypto]> in
                guard let self else { return .empty() }
                
                if watchedList.contains(where: { $0.id == toggle.id }) {
                    return self.removeWatchListUseCase.execute(crypto: toggle)
                        .flatMap{ self.fetchWatchedListUseCase.execute() }
                } else {
                    return self.addWatchedListUseCase.execute(crypto: toggle)
                        .flatMap{ self.fetchWatchedListUseCase.execute() }
                }
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { cryptoList in
                watchedList.accept(cryptoList)
            })
            .disposed(by: disposeBag)
        
        input.tapCell
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.navigateTo(screen: .priceListDetail)
            })
            .disposed(by: disposeBag)
        
        
        return Output(cryptoList: combined.asDriver(onErrorJustReturn: []),
                      error: errorSubject.asDriver(onErrorJustReturn: ""),
                      isLoading: loadingSubject.asDriver(onErrorJustReturn: false)
        )
    }
}
