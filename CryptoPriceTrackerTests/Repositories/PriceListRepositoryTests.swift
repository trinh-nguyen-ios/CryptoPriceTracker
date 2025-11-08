//
//  PriceListRepositoryTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import Testing
@testable import CryptoPriceTracker
import RxSwift
import RxBlocking
import XCTest

final class PriceListRepositoryTests: XCTestCase {

    var repository: PriceListRepositoryImpl!
    var mockjsonLoader: MockJsonLoader!
    
    override func setUp() {
        super.setUp()
  
        mockjsonLoader = MockJsonLoader()
        repository = PriceListRepositoryImpl(jsonLoader: mockjsonLoader)
    }
    
    func test_repository_return_all_prices() {
        let result = try? repository.fetchAllPrices()
            .toBlocking().first()
        
        XCTAssertEqual(result?.first?.usd, 1000)
        XCTAssertEqual(result?.first?.eur, 800)
        
    }
    
    func test_repository_when_nil_json_return_error() {
        //given
        mockjsonLoader.fullPriceList = nil
        
        // then
        XCTAssertThrowsError (
            try repository.fetchAllPrices()
                .toBlocking().first()
        )
    }

}

class MockJsonLoader: JSONLoader {
    var fullPriceList: AllPricesResponseDTO? = .init(code: "200", data: [.init(id: 1, name: "BTC", price: .init(usd: 1000, eur: 800), tags: ["tag1"])])
    
    func loadJSON<T>(filename: String) -> T? where T : Decodable {
        if filename == "allPrices" {
            return fullPriceList as? T
        } else {
            return nil
        }
    }
    
}
