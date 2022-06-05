//
//  EntNetworkServiceProtocol.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import Moya

public protocol EntNetworkServiceProtocol {
    
    func request(endpoint: EntEndpointGroup, completion: @escaping ((Result<Moya.Response, MoyaError>) -> Void)) -> Cancellable
    
    func request<T: Codable>(endpoint: EntEndpointGroup, completion: @escaping ((Result<T, MoyaError>) -> Void)) -> Cancellable
    
}
