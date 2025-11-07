//
//  FetchPriceListUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 7/11/25.
//

import Foundation
import RxSwift

protocol FetchPriceListUseCaseType {
    func excute() -> Observable<[Crypto]>
}

class FetchPriceListUseCase: FetchPriceListUseCaseType {
    let userDefault: UserDefaults
    let bundleJSONLoader: BundleJSONLoader
    
    init(userDefault: UserDefaults = .standard, bundleJSONLoader: BundleJSONLoader = BundleJSONLoader()) {
        self.userDefault = userDefault
        self.bundleJSONLoader = bundleJSONLoader
    }
    
    func excute() -> Observable<[Crypto]> {
        Observable.create { [weak self] observer in
            guard let self else {
            observer.onError(NSError(domain: "Unknow error", code: -2))
               return Disposables.create()
            }
            if let cryptoList =  ReactiveUserDefault<[UsdCryptoDTO]>.load(type: [UsdCryptoDTO].self, key: "usePrice", userDefault: self.userDefault) {
                observer.onNext(cryptoList.map { $0.toDomain()})
                observer.onCompleted()
            } else {
                guard let data: UsdPricesResponseDTO = self.bundleJSONLoader.loadJSON(filename: "usdPrices") else {
                    observer.onError(NSError(domain: "Can't load json", code: -1))
                   return Disposables.create()
                }
                observer.onNext(data.data.map { $0.toDomain() })
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
