//
//  EntDI.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Swinject
import Moya

public class EntDependencyContainer {
    let container = Container()
    
    public static let shared = EntDependencyContainer()
    
    init() {
        container.register(EntImageServiceProtocol.self) { r in
            EntImageService(cache: EntImageServiceUrlCache(
                fileCapacity: EntConfig.ImageCacheFileCapacity,
                memoryCapacity: EntConfig.ImageCacheMemoryCapacity
            ))
        }.inObjectScope(.container)
        
        container.register(EntNetworkServiceProtocol.self) { _ in
            EntNetworkService(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
        }.inObjectScope(.container)
        
        container.register(EntNetworkReachabilityListenerProtocol.self) { _ in
            EntNetworkReachabilityListener()
        }.inObjectScope(.container)
    }
    
    public static func getImageService() -> EntImageServiceProtocol {
        return shared.container.resolve(EntImageServiceProtocol.self)!
    }
    
    public static func getDefaultNetworkListener() -> EntNetworkReachabilityListenerProtocol {
        return shared.container.resolve(EntNetworkReachabilityListenerProtocol.self)!
    }
    
    public static func getDefaultNetworkingService() -> EntNetworkServiceProtocol {
        return shared.container.resolve(EntNetworkServiceProtocol.self)!
    }
    
}
