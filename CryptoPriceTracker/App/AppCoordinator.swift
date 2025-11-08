//
//  AppCoordinator.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 6/11/25.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        toPriceList()
    }
    
    func toPriceList() {
        let viewModel = PriceListViewModel(useCase: FetchUSDPriceListUseCase(repository: PriceListRepositoryImpl()))
        
        guard let viewController = PriceListViewController.instantiate(viewModel: viewModel) else { return }
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}
