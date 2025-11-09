//
//  SearchCryptoUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation
import RxSwift

protocol SearchCryptoUseCaseType {
    func execute(query: String) -> Observable<[Crypto]>
}

class SearchCryptoUseCase: SearchCryptoUseCaseType {
    let repository: CryptoRepository
    
    init(repository: CryptoRepository) {
        self.repository = repository
    }
    
    func execute(query: String) -> Observable<[Crypto]> {
        repository.fetchUsdPrices().map {
            $0.filter({
                if query.isEmpty {
                    return true
                }
                return $0.name.contains(query)
            })
        }
    }
}
