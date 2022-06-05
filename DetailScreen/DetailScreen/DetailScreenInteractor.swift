//
//  DetailScreenInteractor.swift
//  DetailScreen
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import EntCore

public protocol DetailScreenInteractorProtocol: AnyObject {
    func getEntity() -> EntItunesSearchItem?
    func getEntityArtwork(completion: @escaping ((_ image: UIImage) -> Void))
}

public class DetailScreenInteractor: DetailScreenInteractorProtocol {
    let imageService: EntImageServiceProtocol
    let entity: EntItunesSearchItem
    
    init(imageService: EntImageServiceProtocol, entity: EntItunesSearchItem) {
        self.imageService = imageService
        self.entity = entity
    }
    
    public func getEntity() -> EntItunesSearchItem? {
        return entity
    }
    
    public func getEntityArtwork(completion: @escaping ((UIImage) -> Void)) {
        guard let imageUrl = URL(string: entity.artworkUrl100) else { return }
        
        imageService.getImage(imageURL: imageUrl) { result in
            switch result {
            case .success(let image):
                completion(image)
                break
            case .failure(let error):
                NSLog("Error when loading entity artwork. Error: %@", error.localizedDescription)
            }
        }
    }
    
    
}
