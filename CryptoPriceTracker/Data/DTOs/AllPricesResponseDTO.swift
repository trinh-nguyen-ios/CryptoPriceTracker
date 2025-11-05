//
//  AllPricesResponseDTO.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

struct AllPricesResponseDTO: Codable {
    let code: String
    let data: [AllPriceCryptoDTO]
}

struct AllPriceCryptoDTO: Codable {
    let id: Int
    let name: String
    let price: PriceDTO
    let tags: [String]
}

struct PriceDTO: Codable {
    let usd: Double
    let eur: Double
}
