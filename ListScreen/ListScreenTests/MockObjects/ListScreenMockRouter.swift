//
//  ListScreenMockRouter.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen
import EntCore

class ListScreenMockRouter: ListScreenRouterProtocol {
    var pushDetailScreenCalled = false
    
    func pushDetailScreen(withModel: EntItunesSearchItem, onto: UINavigationController) {
        pushDetailScreenCalled = true
    }
    
}
