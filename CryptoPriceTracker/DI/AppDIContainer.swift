//
//  AppDIContainer.swift
//  CryptoPriceTracker
//
//  Created by Nguyen The Trinh on 9/11/25.
//

import Foundation


class AppDIContainer {
    static let shared = AppDIContainer()
    
    init() {}
    
    func createPriceListDIContainer() -> PriceListDIContainer {
        PriceListDIContainer.shared
    }
}
