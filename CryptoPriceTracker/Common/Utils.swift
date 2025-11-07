//
//  Utils.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

protocol JSONLoader {
    func loadJSON<T: Decodable>(filename: String) -> T?
}

class BundleJSONLoader: JSONLoader {
    func loadJSON<T: Decodable>(filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
