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
        do {
            let data = try encoder.encode(value)
            DispatchQueue.main.async {
                self.userDefault.set(data, forKey: self.key)
                UserDefaults.standard.synchronize()
                self.relay.accept(value)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func clear() {
        userDefault.removeObject(forKey: key)
    }
    
    func load() -> T? {
        if let data = userDefault.value(forKey: key) as? Data {
            let object = try? JSONDecoder().decode(T.self, from: data)
            return object
        }
        
        return nil
    }
    
    static func load<U: Decodable>(type: U.Type, key: String, userDefault: UserDefaults) -> U? {
        if let data = userDefault.value(forKey: key) as? Data {
            let object = try? JSONDecoder().decode(type.self, from: data)
            return object
        }
        
        return nil
    }
}
