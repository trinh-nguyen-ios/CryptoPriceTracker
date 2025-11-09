//
//  PriceListViewControllerTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import XCTest
import RxSwift
@testable import CryptoPriceTracker

final class PriceListViewControllerTests: XCTestCase {
    
    var viewModel: MockPriceListViewModel!
    var viewController: PriceListViewController!
    
    override func setUpWithError() throws {
        viewModel = MockPriceListViewModel(useCase: MockFetchUSDPriceUseCase())
        viewController = PriceListViewController.instantiate(viewModel: viewModel)
        _ = viewController.view
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_load_trigger_show_crypto_list() {
        //given
        viewModel.emitCrypto()
        
        // then
        let result =  viewController.tableView.numberOfRows(inSection: 0) == 1
        XCTAssertEqual(result, true)
    }
    
}


class MockPriceListViewModel: PriceListViewModel {
    var crypto = PublishSubject<[Crypto]>()
    var errorSubject = PublishSubject<String>()
    var loadingSubject = BehaviorSubject<Bool>(value: false)
    
    override func transForm(input: PriceListViewModel.Input) -> PriceListViewModel.Output {
        return Output(cryptoList: crypto.asDriver(onErrorJustReturn: []), error: errorSubject.asDriver(onErrorJustReturn: ""), isLoading: loadingSubject.asDriver(onErrorJustReturn: false))
    }
    
    func emitCrypto() {
        crypto.onNext([.init(id: 1, name: "BTC", usd: 1000, eur: nil, tags: ["Tag1"])])
    }
}
