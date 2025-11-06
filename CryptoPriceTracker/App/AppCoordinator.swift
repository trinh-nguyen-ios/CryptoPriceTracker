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
        let storyboard = UIStoryboard(name: "PriceList", bundle: nil)
        
        let viewController = storyboard.instantiateInitialViewController() as? PriceListViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
