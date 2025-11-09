//
//  WatchedListRepositoryImpl.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation
import RxSwift

class WatchedListRepositoryImpl: WatchedListRepository {
    let userDefault: ReactiveUserDefault<[Crypto]>
    
    init(userDefault: ReactiveUserDefault<[Crypto]>) {
        self.userDefault = userDefault
    }
    
    func addToWatchedList(crypto: Crypto) -> Observable<Void> {
        Observable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            
            var list: [Crypto] = userDefault.load() ?? []
            list.append(crypto)
            userDefault.save(list)
            completable.onNext(())
            return Disposables.create()
        }
        
    }
    
    func removeFromWatchedList(crypto: Crypto) -> Observable<Void> {
        Observable.create { [weak self] completable in
            guard let self else { return Disposables.create() }
            var list: [Crypto] = userDefault.load() ?? []
            list.removeAll(where: {$0.id == crypto.id})
            userDefault.save(list)
            completable.onNext(())

            return Disposables.create()
        }
    }
    
    func fetchWatchedList() -> Observable<[Crypto]> {
        Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            DispatchQueue.main.async {
                let watchedList = self.userDefault.load() ?? []
                observer.onNext(watchedList)
            }
            return Disposables.create()
        }
    }
}
