//
//  MockNetworkReachabilityListenerService.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen
import EntCore
import Reachability

class MockNetworkReachabilityListenerService: EntNetworkReachabilityListenerProtocol {
    var isReachableCalled = false
    var onReachableCalled = false
    
    var isReachableReturnVal = false
    
    func isReachable() -> Bool {
        isReachableCalled = true
        return isReachableReturnVal
    }
    
    func onReachable(_ callback: @escaping ((Reachability) -> Void)) {
        onReachableCalled = true
    }
    
}
