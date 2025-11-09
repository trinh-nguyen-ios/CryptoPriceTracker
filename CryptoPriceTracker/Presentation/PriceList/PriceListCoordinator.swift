//
//  PriceListCoordinator.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import UIKit

protocol PriceListCoordinatorType {
    func start()
    func navigateTo(screen: PriceListScreen)
}

enum PriceListScreen {
    case priceListDetail
}

class PriceListCoordinator: PriceListCoordinatorType {
    let window: UIWindow
    let dependencies: PriceListDIContainer
    
    init(window: UIWindow, dependencies: PriceListDIContainer) {
        self.window = window
        self.dependencies = dependencies
    }
    
    func start() {
        guard let viewController = dependencies.createPriceListViewController(coordinator: self) else { return }
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
    
    func navigateTo(screen: PriceListScreen) {
        switch screen {
        case .priceListDetail:
            let viewController = PriceDetailViewController.init()
            window.rootViewController = UINavigationController(rootViewController: viewController)
            window.makeKeyAndVisible()
        }
    }
}
