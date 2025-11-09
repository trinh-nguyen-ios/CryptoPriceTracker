//
//  CryptoAllPrices.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

struct Crypto: Codable {
    let id: Int
    let name: String
    let usd: Double
    let eur: Double?
    let tags: [String]
}
