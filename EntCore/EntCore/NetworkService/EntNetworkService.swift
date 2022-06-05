//
//  EntNetworkService.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import Moya

public class EntNetworkService: EntNetworkServiceProtocol {
    let moyaProvider: MoyaProvider<EntEndpointGroup>
    
    public init(plugins: [PluginType]) {
        self.moyaProvider = MoyaProvider<EntEndpointGroup>(plugins: plugins)
    }
    
    public func request(endpoint: EntEndpointGroup, completion: @escaping ((Result<Moya.Response, MoyaError>) -> Void)) -> Cancellable {
        return moyaProvider.request(endpoint) { result in
            completion(result)
        }
    }
    
    public func request<T: Codable>(endpoint: EntEndpointGroup, completion: @escaping ((Result<T, MoyaError>) -> Void)) -> Cancellable {
        return request(endpoint: endpoint) { result in
            switch(result) {
            case .success(let response):
                let jsonDecoder = JSONDecoder()
                do {
                    completion(.success(try jsonDecoder.decode(T.self, from: response.data)))
                } catch {
                    completion(.failure(MoyaError.underlying(error, response)))
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
}
