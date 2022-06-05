//
//  EntImageService.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit

public class EntImageService: EntImageServiceProtocol {
    private var cache: EntImageServiceCacheProtocol
    
    public init(cache: EntImageServiceCacheProtocol) {
        self.cache = cache
    }
    
    public func getImage(imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        if (self.cache.hasCache(for: imageURL)) {
            return self.loadImageFromCache(imageURL: imageURL, completion: completion)
        } else {
            return self.downloadImage(imageURL: imageURL, completion: completion)
        }
    }
    
    private func downloadImage(imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        DispatchQueue.global().async {
            let dataTask = URLSession.shared.dataTask(with: imageURL) {data, response, _ in
                if let data = data {
                    let cachedData = CachedURLResponse(response: response!, data: data)
                    self.cache.storeData(cachedData, forUrl: imageURL)
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    private func loadImageFromCache(imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = self.cache.getCache(for: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }
    }
    
    public func getCache() -> EntImageServiceCacheProtocol {
        return cache
    }
    
}
