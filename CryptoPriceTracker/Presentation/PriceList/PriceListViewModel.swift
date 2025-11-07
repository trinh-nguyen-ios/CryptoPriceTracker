//
//  PriceListViewModel.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation
import RxSwift
import RxCocoa

class PriceListViewModel {
    struct Input {
        let loadTrigger: Observable<Void>
    }
    
    struct Output {
        let cryptoList: Driver<[Crypto]>
        let error: Driver<String>
        let isLoading: Driver<Bool>
    }
    
    let useCase: FetchPriceListUseCaseType
    
    init(useCase: FetchPriceListUseCaseType) {
        self.useCase = useCase
    }
    
    func transForm(input: Input) -> Output {
        let errorSubject = BehaviorSubject<String>(value: "")
        let loadingSubject = PublishSubject<Bool>()
        
        
        let cryptoList = input.loadTrigger
            .flatMapLatest { query -> Observable<[Crypto]>  in
                loadingSubject.onNext(true)
                return self.useCase.excute()
                    .do(onNext: {_ in
                        loadingSubject.onNext(false)
                    }, onError: { error in
                        loadingSubject.onNext(false)
                        errorSubject.onNext(error.localizedDescription)
                    })
                    .catchAndReturn([])
            }
        
        return Output(cryptoList: cryptoList.asDriver(onErrorJustReturn: []),
                      error: errorSubject.asDriver(onErrorJustReturn: ""),
                      isLoading: loadingSubject.asDriver(onErrorJustReturn: false)
        )
    }
}
