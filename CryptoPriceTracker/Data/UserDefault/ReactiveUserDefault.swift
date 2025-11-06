//
//  ReactiveUserDefault.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 6/11/25.
//

import Foundation
import RxSwift
import RxCocoa

class ReactiveUserDefault<T: Codable> {
    let key: String
    let userDefault: UserDefaults
    let relay: BehaviorRelay<T?>
    
    init(key: String, userDefault: UserDefaults = .standard, relay: BehaviorRelay<T?>) {
        self.key = key
        self.userDefault = userDefault
        self.relay = relay
    }
    
    func save(_ value: T?) {
        guard let value = value else {
            userDefault.removeObject(forKey: key)
            relay.accept(nil)
            return
        }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(value) {
            userDefault.set(data, forKey: key)
            relay.accept(value)
        }
        
    }
    
    func clear() {
        userDefault.removeObject(forKey: key)
    }
    
    static func load<U: Decodable>(type: U.Type, key: String, userDefault: UserDefaults) -> U? {
        if let data = userDefault.value(forKey: key) as? Data {
            let object = try? JSONDecoder().decode(type.self, from: data)
            return object
        }
        
        return nil
    }
}
