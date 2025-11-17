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
        let loadTrigger: Observable<String>
    }
    
    struct Output {
        let cryptoList: Driver<[PriceListModel]>
        let error: Driver<String>
        let isLoading: Driver<Bool>
    }
    
    let coordinator: PriceListCoordinatorType
    let fetchUSDPriceListUseCase: FetchUSDPriceListUseCaseType
    let disposeBag = DisposeBag()
    
    init(coordinator: PriceListCoordinatorType, fetchUSDPriceListUseCase: FetchUSDPriceListUseCaseType) {
        self.coordinator = coordinator
        self.fetchUSDPriceListUseCase = fetchUSDPriceListUseCase
    }
    
    func transForm(input: Input) -> Output {
        let errorSubject = BehaviorSubject<String>(value: "")
        let loadingSubject = PublishSubject<Bool>()
        
        
        let cryptoList = input.loadTrigger
            .flatMapLatest { [weak self] query -> Observable<[Crypto]>  in
                guard let self else { return .empty() }
                loadingSubject.onNext(true)
                return self.fetchUSDPriceListUseCase.execute()
                    .do(onNext: {_ in
                        loadingSubject.onNext(false)
                    }, onError: { error in
                        loadingSubject.onNext(false)
                        errorSubject.onNext(error.localizedDescription)
                    })
                    .catchAndReturn([])
            }
            .map { all in
                all.map { crypto in
                    PriceListModel(crypto: crypto)
                }
            }
        
        return Output(cryptoList: cryptoList.asDriver(onErrorJustReturn: []),
                      error: errorSubject.asDriver(onErrorJustReturn: ""),
                      isLoading: loadingSubject.asDriver(onErrorJustReturn: false)
        )
    }
}
