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

enum PriceListScreen {}

class PriceListCoordinator: PriceListCoordinatorType {
    let window: UIWindow
    let dependencies: PriceListDIContainerType
    let navigation: UINavigationController
    
    init(window: UIWindow, dependencies: PriceListDIContainerType, navigation: UINavigationController) {
        self.window = window
        self.dependencies = dependencies
        self.navigation = navigation
    }
    
    func start() {
        guard let viewController = dependencies.createPriceListViewController(coordinator: self) else { return }
        navigation.viewControllers = [viewController]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
    func navigateTo(screen: PriceListScreen) {}
}
