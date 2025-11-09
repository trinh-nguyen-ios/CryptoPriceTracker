//
//  AddWatchedListUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation
import RxSwift

protocol AddWatchedListUseCaseType {
    func execute(crypto: Crypto) -> Observable<Void>
}

class AddWatchedListUseCase: AddWatchedListUseCaseType {
    let repository: WatchedListRepository
    
    init(repository: WatchedListRepository) {
        self.repository = repository
    }
    
    func execute(crypto: Crypto) -> Observable<Void> {
        repository.addToWatchedList(crypto: crypto)
    }
}
