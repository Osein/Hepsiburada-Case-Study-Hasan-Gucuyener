//
//  EntEndpointGroup.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import Moya

public enum EntEndpointGroup {
    case search(query: String, entityType: String, page: Int = 1)
}

extension EntEndpointGroup: EntEndpointGroupProtocol {
    public var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    public var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return [:]
    }
    
    public var parameters: [String: String]? {
        switch self {
        case .search(let query, let entityType, let page):
            return ["term": query, "media": entityType, "limit": "20", "offset": "\((page - 1) * 20)"]
        }
    }
    
    
}
