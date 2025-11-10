//
//  PriceListUseCaseTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import Testing
import RxSwift
import XCTest
import RxBlocking

@testable import CryptoPriceTracker

final class FetchUSDPriceListUseCaseTests: XCTestCase {
    
    var repository: CryptoRepository?
    var useCase: FetchUSDPriceListUseCaseType?
    
    override func setUp() {
        super.setUp()
        repository = MockCryptoRepository()
        useCase = FetchUSDPriceListUseCase(repository: repository!)
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_usecase_excute_return_listPrices() {
        // given
        guard let repo = repository as? MockCryptoRepository else { return }
        repo.usdPrices = [  Crypto(id: 1, name: "BTC", usd: 1000, eur: nil, tags: ["tag1"]),
                            Crypto(id: 2, name: "ETH", usd: 2000, eur: nil, tags: ["tag2"])]
        //when
        let result = try? useCase?.execute().toBlocking().first()
        
        //then
        XCTAssertEqual(result?.first?.name, "BTC")
    }

}

class MockCryptoRepository: CryptoRepository {
    let jsonLoader = BundleJSONLoader()
    var usdPrices: [Crypto] = []
    var allPrices: [Crypto] = []
    
    func fetchUsdPrices() -> Observable<[Crypto]> {
        return Observable.just(usdPrices)
    }
    
    func fetchAllPrices() -> Observable<[Crypto]> {
        return Observable.just(allPrices)
    }
}
