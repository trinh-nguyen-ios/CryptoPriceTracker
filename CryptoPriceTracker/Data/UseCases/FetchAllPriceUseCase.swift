//
//  FetchAllPriceUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import Foundation
import RxSwift

protocol FetchAllPriceUseCaseType {
    func execute() -> Observable<[Crypto]>
}

class FetchAllPriceUseCase: FetchAllPriceUseCaseType {
    let repository: CryptoRepository
    
    init(repository: CryptoRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<[Crypto]> {
        repository.fetchAllPrices()
    }
}
