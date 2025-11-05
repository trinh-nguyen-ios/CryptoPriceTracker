//
//  Utils.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

enum Utils {
    
    static func loadJSON<T: Decodable>(filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("❌ Couldn't find \(filename).json in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("❌ Failed to decode \(filename).json: \(error)")
        }
    }
    
}
