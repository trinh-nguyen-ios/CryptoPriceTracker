//
//  PriceListCoordinatorTests.swift
//  CryptoPriceTrackerTests
//
//  Created by Nguyen The Trinh on 10/11/25.
//

import Foundation
@testable import CryptoPriceTracker
import XCTest
import RxSwift

class PriceListCoordinatorTests: XCTestCase {
    
    var coordinator: PriceListCoordinatorType!
    var mockDI: MockPriceListDIContainer!
    var navigation: UINavigationController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        navigation = UINavigationController()
        mockDI = MockPriceListDIContainer()
        coordinator = PriceListCoordinator(window: window, dependencies: mockDI, navigation: navigation)
    }
    
    func test_start_show_price_list_viewController() {
        // given
        coordinator.start()
        
        //then
        XCTAssertEqual(mockDI.didCreatePriceList, true)
    }
    
    func test_navigate_to_price_detail() {
        //
        coordinator.navigateTo(screen: .priceListDetail)
        
        //then
        XCTAssertEqual(mockDI.didCreatePriceDetail, true)
    }
    
}

class MockPriceListDIContainer: PriceListDIContainerType {
    var didCreatePriceList: Bool = false
    var didCreatePriceDetail: Bool = false
    
    var priceDetail: PriceDetailViewController?
    var priceList: PriceListViewController?
    
    func createPriceDetailViewController() -> PriceDetailViewController? {
        didCreatePriceDetail = true
        return priceDetail
    }
    
    func createPriceListViewController(coordinator: any PriceListCoordinatorType) -> PriceListViewController? {
        didCreatePriceList = true
        return priceList
    }
}
