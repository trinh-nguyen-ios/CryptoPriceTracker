//
//  RemoveWatchedListUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation
import RxSwift

protocol RemoveWatchedListUseCaseType {
    func execute(crypto: Crypto) -> Observable<Void>
}

class RemoveWatchedListUseCase: RemoveWatchedListUseCaseType {
    let repository: WatchedListRepository
    
    init(repository: WatchedListRepository) {
        self.repository = repository
    }
    
    func execute(crypto: Crypto) -> Observable<Void> {
        repository.removeFromWatchedList(crypto: crypto)
    }
}
