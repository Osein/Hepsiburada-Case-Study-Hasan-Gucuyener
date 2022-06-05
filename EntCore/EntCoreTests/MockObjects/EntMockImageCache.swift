//
//  EntMockImageCache.swift
//  EntCoreTests
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
@testable import EntCore

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

class EntMockImageCache: EntImageServiceCacheProtocol {
    var hasCacheCalled = false
    var storeDataCalled = false
    var getCacheCalled = false
    
    var shouldCacheAnswerAsItemExists = false
    
    func hasCache(for url: URL) -> Bool {
        hasCacheCalled = true
        
        return shouldCacheAnswerAsItemExists
    }
    
    func storeData(_ cachedUrlResponse: CachedURLResponse, forUrl: URL) {
        storeDataCalled = true
    }
    
    func getCache(for url: URL) -> Data? {
        getCacheCalled = true
        
        return shouldCacheAnswerAsItemExists ? UIImage(color: .blue)!.jpegData(compressionQuality: 0.5) : nil
    }
    
}
