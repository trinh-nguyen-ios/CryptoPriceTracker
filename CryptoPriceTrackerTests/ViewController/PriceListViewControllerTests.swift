//
//  PriceListViewControllerTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 8/11/25.
//

import XCTest
import RxSwift
import RxCocoa

@testable import CryptoPriceTracker

final class PriceListViewControllerTests: XCTestCase {
    
    var viewModel: MockPriceListViewModel!
    var viewController: PriceListViewController!
    
    override func setUpWithError() throws {
        viewModel = MockPriceListViewModel()
        viewController = PriceListViewController.instantiate(viewModel: viewModel)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_load_trigger_show_crypto_list() {
        //given
        _ = viewController.view
        
        // then
        let result =  viewController.tableView.numberOfRows(inSection: 0) == 1
        XCTAssertEqual(result, true)
    }
    
}


class MockPriceListViewModel: PriceListViewModelType {
    var didCallTransform: Bool = false
    
    func transForm(input: PriceListViewModel.Input) -> PriceListViewModel.Output {
        didCallTransform = true
        let cryptoList: [PriceListModel] = [.init(crypto: .init(id: 1, name: "BTC", usd: 1000, eur: 800, tags: ["tag1"]), isWatchedList: false)]
        return PriceListViewModel.Output(cryptoList: Driver.just(cryptoList), error: Driver.empty(), isLoading:  Driver.empty())
    }
}
