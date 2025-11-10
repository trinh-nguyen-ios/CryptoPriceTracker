//
//  FetchPriceListUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 7/11/25.
//

import Foundation
import RxSwift

protocol FetchUSDPriceListUseCaseType {
    func execute() -> Observable<[Crypto]>
}

class FetchUSDPriceListUseCase: FetchUSDPriceListUseCaseType {
    let repository: CryptoPriceRepository
    
    init(repository: CryptoPriceRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<[Crypto]> {
        return repository.fetchUsdPrices()
    }
}
