//
//  MockImageService.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import XCTest
@testable import ListScreen
import EntCore

class MockImageService: EntImageServiceProtocol {
    var getCacheCalled = false
    var getImageCalled = false
    
    func getImage(imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        getImageCalled = true
    }
    
}
