//
//  EntDI.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Swinject
import Moya

public class TrackyDependencyContainer {
    let container = Container()
    
    public static let shared = TrackyDependencyContainer()
    
    init() {
        container.register(EntImageServiceProtocol.self) { r in
            EntImageService(cache: EntImageServiceUrlCache(
                fileCapacity: EntConfig.ImageCacheFileCapacity,
                memoryCapacity: EntConfig.ImageCacheMemoryCapacity
            ))
        }.inObjectScope(.container)
    }
    
    public static func getImageService() -> EntImageServiceProtocol {
        return shared.container.resolve(EntImageServiceProtocol.self)!
    }
    
}
