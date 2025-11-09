//
//  WatchedListRepository.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation
import RxSwift

protocol WatchedListRepository {
    func fetchWatchedList() -> Observable<[Crypto]>
    func addToWatchedList(crypto: Crypto) -> Observable<Void>
    func removeFromWatchedList(crypto: Crypto) -> Observable<Void>
}
