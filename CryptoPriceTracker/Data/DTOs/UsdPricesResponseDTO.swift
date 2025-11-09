//
//  UsdPricesResponseDTO.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

struct UsdPricesResponseDTO: Codable {
    let code: String
    let data: [UsdCryptoDTO]
}

struct UsdCryptoDTO: Codable {
    let id: Int
    let name: String
    let usd: Double
    let tags: [String]
}

struct UsdPricesResponse {
    
}
