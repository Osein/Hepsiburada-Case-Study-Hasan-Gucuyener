//
//  ListScreenMockInteractor.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen
import EntCore
import Moya

class ListScreenMockInteractor: ListScreenInteractorProtocol {
    var shouldShowNetworkConnectionWarning: Bool = false
    var shouldShowSearchKeywordWarning: Bool = false
    var onNetworkChange: ((Bool) -> Void)?
    
    func searchEntities(query: String, entityType: String, page: Int, append: Bool) {
        
    }
    
    var onSearchResponse: (() -> Void)?
    
    var onSearchError: ((MoyaError) -> Void)?
    
    func cancelPreviousRequest() {
        
    }
    
    func getEntityCount() -> Int {
        return 0
    }
    
    func getEntity(byIndex: Int) -> EntItunesSearchItem? {
        return nil
    }
    
    func getEntityArtwork(byIndex: Int, completion: @escaping ((UIImage) -> Void)) {
        
    }
    
}
