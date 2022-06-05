//
//  EntImageServiceTests.swift
//  EntCoreTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import EntCore

class EntImageServiceTests: XCTestCase {
    let mockCache = EntMockImageCache()
    var imageService: EntImageService?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imageService = EntImageService(cache: mockCache)
        mockCache.shouldCacheAnswerAsItemExists = false
        mockCache.getCacheCalled = false
        mockCache.storeDataCalled = false
        mockCache.hasCacheCalled = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testImageService__checksForExistingCachedImage() throws {
        // Given
        mockCache.shouldCacheAnswerAsItemExists = true
        let exp = expectation(description: "Image waiter")
        
        // When
        imageService?.getImage(imageURL: URL(string: "https://via.placeholder.com/140x100")!) { result in
            defer { exp.fulfill() }
            
            switch result {
            case .success(let image):
                break
            case .failure(let error):
                break
            }
        }
        wait(for: [exp], timeout: 3)
        
        // Then
        XCTAssertTrue(
            mockCache.hasCacheCalled,
            "Image service should call hasCache on cache before downloading an image"
        )
        
        XCTAssertTrue(
            mockCache.getCacheCalled,
            "Image service should call getCache when cache tells it that it has cached response"
        )
    }
    
}
