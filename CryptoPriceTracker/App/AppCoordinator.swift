//
//  AppCoordinator.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 6/11/25.
//

import UIKit

protocol AppCoordinatorType {
    func start()
    func navigateTo(screen: AppScreen)
}

enum AppScreen {
    case priceList
}

class AppCoordinator: AppCoordinatorType {
    let window: UIWindow
    let appDIContainer: AppDIContainer
    let navigation: UINavigationController
    
    init(window: UIWindow, appDIContainer: AppDIContainer, navigation: UINavigationController) {
        self.window = window
        self.appDIContainer = appDIContainer
        self.navigation = navigation
    }
    
    func start() {
        navigateTo(screen: .priceList)
    }
    
    func navigateTo(screen: AppScreen) {
        switch screen {
        case .priceList:
            let priceListDIContainer = appDIContainer.createPriceListDIContainer()
            let coordinator = priceListDIContainer.createPriceListCoordinator(window: window, navigation: navigation)
            coordinator.start()
        }
    }
}
