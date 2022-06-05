//
//  EntImageServiceUrlCache.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public class EntImageServiceUrlCache: EntImageServiceCacheProtocol {
    private let fileCapacity: Int
    private let memoryCapacity: Int
    
    private let urlCache: URLCache
    
    public init(fileCapacity: Int, memoryCapacity: Int) {
        self.fileCapacity = fileCapacity
        self.memoryCapacity = memoryCapacity

        if #available(iOS 13, *) {
            self.urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: fileCapacity, directory: nil)
        } else {
            self.urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: fileCapacity, diskPath: nil)
        }
    }
    
    public func hasCache(for url: URL) -> Bool {
        return urlCache.cachedResponse(for: URLRequest(url: url)) != nil
    }
    
    public func storeData(_ cachedUrlResponse: CachedURLResponse, forUrl: URL) {
        urlCache.storeCachedResponse(cachedUrlResponse, for: URLRequest(url: forUrl))
    }
    
    public func getCache(for url: URL) -> Data? {
        guard let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)) else { return nil }
        return cachedResponse.data
    }
    
}
