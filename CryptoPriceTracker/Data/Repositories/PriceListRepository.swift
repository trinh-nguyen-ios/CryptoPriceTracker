//
//  PriceListRepository.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import Foundation
import RxSwift

class PriceListRepositoryImpl: CryptoRepository {
    let jsonLoader: JSONLoader
    
    init(jsonLoader: JSONLoader = BundleJSONLoader()) {
        self.jsonLoader = jsonLoader
    }
    
    func fetchAllPrices() -> Observable<[Crypto]> {
        guard let allPriceList: AllPricesResponseDTO = jsonLoader.loadJSON(filename: "allPrices") else {
            return Observable.error(NSError(domain: "Can't load json", code: -1) as Error)
        }
        return Observable.just(allPriceList.data.map { $0.toDomain() })
    }
    
    func fetchUsdPrices() -> Observable<[Crypto]> {
        guard let allPriceList: UsdPricesResponseDTO = jsonLoader.loadJSON(filename: "usdPrices") else {
            return Observable.error(NSError(domain: "Can't load json", code: -1) as Error)
        }
        return Observable.just(allPriceList.data.map { $0.toDomain() })
    }
}
