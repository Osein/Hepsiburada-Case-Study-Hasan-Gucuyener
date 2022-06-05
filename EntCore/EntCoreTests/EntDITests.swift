//
//  EntDITests.swift
//  EntCoreTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import EntCore

class EntCoreTests: XCTestCase {
    let diContainer = EntDependencyContainer()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDependencyContainer__havingDefaultImageService() throws {
        XCTAssertNotNil(
            diContainer.container.resolve(EntImageServiceProtocol.self),
            "DI should contain at least one default image service"
        )
    }
    
    func testDependencyContainer__havingDefaultNetworkService() throws {
        XCTAssertNotNil(
            diContainer.container.resolve(EntNetworkServiceProtocol.self),
            "DI should contain at least one default network service"
        )
    }
    
    func testDependencyContainer__havingDefaultNetworkReachabilityListenerService() throws {
        XCTAssertNotNil(
            diContainer.container.resolve(EntNetworkReachabilityListenerProtocol.self),
            "DI should contain at least one default network reachability listener service"
        )
    }

}
