//
//  EntItunesSearchResponseModel.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public struct EntItunesSearchResponseModel: Codable {
    public let resultCount: Int
    public let results: [EntItunesSearchItem]
    
}
