//
//  EntConfig.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public class EntConfig {
    
    public static let ImageCacheFileCapacity = 512 * 1024 * 1024;
    public static let ImageCacheMemoryCapacity = 512 * 1024 * 1024;
    
    public static let EntityListItemMap: KeyValuePairs = [
        "Movies": "movie",
        "Music": "music",
        "Apps": "software",
        "Books": "ebook"
    ]
    
}
