//
//  CryptoEntityTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import Testing
import RxSwift
import XCTest

@testable import CryptoPriceTracker

final class CryptoEntityTests: XCTestCase {
    
    let jsonLoader = BundleJSONLoader()

    func test_toDomain_returnExpectedValue() {
        // given
        let stubble: UsdPricesResponseDTO? = jsonLoader.loadJSON(filename: "usdPrices")
        let btc = stubble?.data.first(where: {$0.name == "BTC"})
        
        // when
        let model = btc?.toDomain()
        
        // then
        XCTAssertEqual(model?.name, "BTC")
        XCTAssertEqual(model?.usd, 88047.57)
        XCTAssertEqual(model?.tags, ["withdrawal", "deposit"])
    }
}
