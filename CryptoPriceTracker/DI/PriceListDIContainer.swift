//
//  PriceListDIContainer.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import UIKit

protocol PriceListDIContainerType {
    func createPriceListViewController(coordinator: PriceListCoordinatorType) -> PriceListViewController?
    func createPriceDetailViewController() -> PriceDetailViewController?
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
        PriceListViewModel(coordinator: coordinator, searchUseCase: createSearchCryptoUseCase(), addWatchedListUseCase: createAddWatchedListUseCase(), removeWatchListUseCase: createRemoveWatchedListUseCase(), fetchWatchedListUseCase: createFetchWatchedListUseCase())
    }
    
    func createSearchCryptoUseCase() -> SearchCryptoUseCaseType {
        SearchCryptoUseCase(repository: createPriceListRepository())
    }
    
    func createAddWatchedListUseCase() -> AddWatchedListUseCaseType {
        AddWatchedListUseCase(repository: createWatchListRepository())
    }
    
    func createFetchWatchedListUseCase() -> FetchWatchedListUseCaseType {
        FetchWatchedListUseCase(repository: createWatchListRepository())
    }
    
    func createRemoveWatchedListUseCase() -> RemoveWatchedListUseCaseType {
        RemoveWatchedListUseCase(repository: createWatchListRepository())
    }
    
    func createPriceListRepository() -> PriceListRepositoryImpl {
        PriceListRepositoryImpl(jsonLoader: BundleJSONLoader())
    }
    
    func createWatchListRepository() -> WatchedListRepository {
        WatchedListRepositoryImpl(userDefault: createUserDefault())
    }
    
    func createPriceDetailViewController() -> PriceDetailViewController? {
        PriceDetailViewController.init()
    }
    
    func createPriceListCoordinator(window: UIWindow, navigation: UINavigationController) -> PriceListCoordinator {
        PriceListCoordinator(window: window, dependencies: self, navigation: navigation)
    }
}
