//
//  CryptoRepository.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation
import RxSwift

protocol CryptoPriceRepository {
    func fetchUsdPrices() -> Observable<[Crypto]>
    func fetchAllPrices() -> Observable<[Crypto]>
}
