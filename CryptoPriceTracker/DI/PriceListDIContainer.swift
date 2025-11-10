//
//  PriceListDIContainer.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import UIKit

protocol PriceListDIContainerType {
    func createPriceListViewController(coordinator: PriceListCoordinatorType) -> PriceListViewController?
}

class PriceListDIContainer: PriceListDIContainerType {
    static let shared = PriceListDIContainer()
    
    init() {}
    
    func createUserDefault() -> ReactiveUserDefault<[Crypto]> {
        return ReactiveUserDefault(key: "usdPricesWatchedList", relay: .init(value: nil))
    }
    
    func createPriceListViewController(coordinator: PriceListCoordinatorType) -> PriceListViewController? {
        PriceListViewController.instantiate(viewModel: createPriceListViewModel(coordinator: coordinator))
    }
    
    func createPriceListViewModel(coordinator: PriceListCoordinatorType) -> PriceListViewModel {
        PriceListViewModel(coordinator: coordinator, fetchUSDPriceListUseCase: createFetchUSDCryptoUseCase())
    }
    
    func createFetchUSDCryptoUseCase() -> FetchUSDPriceListUseCaseType {
        FetchUSDPriceListUseCase(repository: createPriceListRepository())
    }
    
    
    func createPriceListRepository() -> CryptoPriceRepository {
        CryptoPriceRepositoryImpl(jsonLoader: BundleJSONLoader())
    }
    
    func createPriceListCoordinator(window: UIWindow, navigation: UINavigationController) -> PriceListCoordinator {
        PriceListCoordinator(window: window, dependencies: self, navigation: navigation)
    }
}
