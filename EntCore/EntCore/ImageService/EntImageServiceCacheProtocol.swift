//
//  EntImageServiceCacheProtocol.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public protocol EntImageServiceCacheProtocol {
    func hasCache(for url: URL) -> Bool
    func storeData(_ cachedUrlResponse: CachedURLResponse, forUrl: URL)
    func getCache(for url: URL) -> Data?
}
