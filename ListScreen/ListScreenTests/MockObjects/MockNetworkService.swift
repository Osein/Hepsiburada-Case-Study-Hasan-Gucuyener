//
//  MockNetworkService.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen
import EntCore
import Moya

class MockCancellable: Cancellable {
    var isCancelled: Bool = false
    
    func cancel() {
        isCancelled = true
    }
}

class MockNetworkService: EntNetworkServiceProtocol {
    var calledRequest = false
    
    
    func request(endpoint: EntEndpointGroup, completion: @escaping ((Result<Response, MoyaError>) -> Void)) -> Cancellable {
        calledRequest = true
        return MockCancellable()
    }
    
    func request<T>(endpoint: EntEndpointGroup, completion: @escaping ((Result<T, MoyaError>) -> Void)) -> Cancellable where T : Decodable, T : Encodable {
        calledRequest = true
        return MockCancellable()
    }
    
}
