//
//  EntImageServiceProtocol.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit

public protocol EntImageServiceProtocol {
    
    func getImage(imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void))
    
}
