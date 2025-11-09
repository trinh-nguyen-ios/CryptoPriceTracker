//
//  FetchWatchedListUseCase.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation
import RxSwift
protocol FetchWatchedListUseCaseType {
    func execute() -> Observable<[Crypto]>
}

class FetchWatchedListUseCase: FetchWatchedListUseCaseType {
    let repository: WatchedListRepository
    
    init(repository: WatchedListRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<[Crypto]> {
        repository.fetchWatchedList()
    }
}
