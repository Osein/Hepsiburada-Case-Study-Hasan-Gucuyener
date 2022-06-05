//
//  ListScreenInteractorTests.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen
import EntCore

class ListScreenInteractorTests: XCTestCase {
    var mockNetworkService: MockNetworkService?
    var mockNetworkListener: MockNetworkReachabilityListenerService?
    var mockImageService: MockImageService?
    var ListInteractor: ListScreenInteractorProtocol?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockNetworkService = MockNetworkService()
        mockNetworkListener = MockNetworkReachabilityListenerService()
        mockImageService = MockImageService()
        ListInteractor = ListScreenInteractor(networkListener: mockNetworkListener!, networkService: mockNetworkService!, imageService: mockImageService!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInteractor__callsNetworkServiceOnSearchKeywordChange() {
        // Given
        ListInteractor?.searchEntities(query: "test", entityType: "", page: 1, append: false)
        
        // Then
        XCTAssertTrue(mockNetworkService!.calledRequest, "Interactor should call network service on search parameter change.")
    }
    
    func testInteractor__shouldCallNetworkListenerServiceWhenAskedWithErrorShowingParams() {
        // Given
        mockNetworkListener?.isReachableReturnVal = true
        
        // When
        let response = ListInteractor!.shouldShowNetworkConnectionWarning
        
        // Then
        XCTAssertTrue(mockNetworkListener!.isReachableCalled, "Interactor should call network listener service")
        XCTAssertFalse(response, "When reachable interactor should not tell presenter to show network connection warning")
    }

}
