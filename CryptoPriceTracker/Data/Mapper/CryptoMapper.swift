//
//  CryptoMapper.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 5/11/25.
//

import Foundation

extension UsdCryptoDTO {
    func toDomain() -> Crypto {
        Crypto(
            id: id,
            name: name,
            usd: usd,
            eur: nil, // not provided
            tags: tags
        )
    }
}

extension AllPriceCryptoDTO {
    func toDomain() -> Crypto {
        Crypto(
            id: id,
            name: name,
            usd: price.usd,
            eur: price.eur,
            tags: tags
        )
    }
}
