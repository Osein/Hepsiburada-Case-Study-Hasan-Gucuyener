//
//  EntitiesTests.swift
//  EntitiesTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import Entities
import ListScreen

class EntitiesTests: XCTestCase {
    var appDelegate = AppDelegate()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testHaveKeyWindowAfterInit() {
        let mainAppDelegate = UIApplication.shared.delegate
                
        if let mainAppDelegate = mainAppDelegate {
            if let window = mainAppDelegate.window {
                if let window = window {
                    XCTAssertTrue(window.isKeyWindow)
                }
                else {
                    XCTFail("app delegate window should not be nil")
                }
            } else {
                XCTFail("app delegate window should not be nil")
            }
        }
        else {
            XCTFail("shared application should have a delegate")
        }
    }
    
    func testShouldHaveEntityListAsRootViewController() {
        let mainAppDelegate = UIApplication.shared.delegate
                
        guard let mainAppDelegate = mainAppDelegate, let mainWindow = mainAppDelegate.window else {
            XCTFail("shared application should have a delegate")
            return
        }
        
        if let rootVC = mainWindow?.rootViewController as? UINavigationController {
            let mainVC = rootVC.viewControllers[0] as? ListScreenViewController
            
            XCTAssertNotNil(mainVC, "mainVC must be an entity list view controller")
        } else {
            XCTFail("window must have a rootViewController that is a navigation controller")
        }
    }

}
