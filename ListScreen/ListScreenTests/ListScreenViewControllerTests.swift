//
//  ListScreenViewControllerTests.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen

class ListScreenViewControllerTests: XCTestCase {
    var mockPresenter: ListScreenMockPresenter?
    var viewController: ListScreenViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockPresenter = ListScreenMockPresenter(router: ListScreenMockRouter(), interactor: ListScreenMockInteractor())
        viewController = ListScreenViewController(presenter: mockPresenter!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewController__callsPresenterOnLoad() {
        // When
        viewController?.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockPresenter!.calledOnViewControllerLoad, "View controller should notify presenter that its loaded.")
    }
    
    func testViewController__callsPresenterGetEntityCount() {
        // When
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let _ = viewController?.collectionView(cv, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertTrue(mockPresenter!.calledGetEntityCount, "View controller should call presenter for entity count.")
    }
    
    func testViewController__callsPresenterGetEntity() {
        // When
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        let _ = viewController?.collectionView(cv, cellForItemAt: IndexPath(item: 0, section: 0))
        
        // Then
        XCTAssertTrue(mockPresenter!.calledGetEntity, "View controller should call presenter for entity.")
    }

}
