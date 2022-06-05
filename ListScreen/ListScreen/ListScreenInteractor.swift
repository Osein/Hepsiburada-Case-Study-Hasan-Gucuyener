//
//  ListScreenInteractor.swift
//  ListScreen
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import EntCore
import Reachability
import Moya

public protocol ListScreenInteractorProtocol: AnyObject {
    var shouldShowNetworkConnectionWarning: Bool { get }
    var shouldShowSearchKeywordWarning: Bool { get }
    var onNetworkChange: ((_ reachable: Bool) -> Void)? { get set }
    
    func searchEntities(query: String, entityType: String, page: Int, append: Bool)
    var onSearchResponse: (() -> Void)? { get set }
    var onSearchError: ((_ error: MoyaError) -> Void)? { get set }
    func cancelPreviousRequest()
    
    func getEntityCount() -> Int
    func getEntity(byIndex: Int) -> EntItunesSearchItem?
    func getEntityArtwork(byIndex: Int, completion: @escaping ((_ image: UIImage) -> Void))
}

public class ListScreenInteractor: ListScreenInteractorProtocol {
    let networkListener: EntNetworkReachabilityListenerProtocol
    let networkService: EntNetworkServiceProtocol
    let imageService: EntImageServiceProtocol
    var previousRequest: Cancellable?
    var entities: [EntItunesSearchItem] = []
    
    public var shouldShowNetworkConnectionWarning: Bool {
        return !networkListener.isReachable()
    }
    
    public var shouldShowSearchKeywordWarning: Bool {
        return true
    }
    
    public var onNetworkChange: ((_ reachable: Bool) -> Void)?
    public var onSearchResponse: (() -> Void)?
    public var onSearchError: ((_ error: MoyaError) -> Void)?
        
    init(networkListener: EntNetworkReachabilityListenerProtocol, networkService: EntNetworkServiceProtocol, imageService: EntImageServiceProtocol) {
        self.networkListener = networkListener
        self.networkService = networkService
        self.imageService = imageService
        
        networkListener.onReachable(onNetworkStatusChange(status:))
    }
    
    public func cancelPreviousRequest() {
        previousRequest?.cancel()
    }
    
    public func searchEntities(query: String, entityType: String, page: Int = 1, append: Bool = false) {
        previousRequest = networkService.request(endpoint: .search(query: query, entityType: entityType, page: page)) {[weak self] (result: Result<EntItunesSearchResponseModel, MoyaError>) in
            switch result {
            case .success(let result):
                if(append) {
                    self?.entities.append(contentsOf: result.results)
                } else {
                    self?.entities = result.results
                }
                self?.onSearchResponse?()
                break
            case .failure(let error):
                self?.onSearchError?(error)
                break
            }
        }
    }
    
    public func getEntityCount() -> Int {
        return entities.count
    }
    
    public func getEntity(byIndex: Int) -> EntItunesSearchItem? {
        return byIndex >= entities.count ? nil : entities[byIndex]
    }
    
    public func getEntityArtwork(byIndex: Int, completion: @escaping ((_ image: UIImage) -> Void)) {
        guard let entity = getEntity(byIndex: byIndex), let artworkUrl = URL(string: entity.artworkUrl100) else { return }
        
        imageService.getImage(imageURL: artworkUrl) { result in
            switch result {
            case .success(let image):
                completion(image)
                break
            case .failure(let error):
                NSLog("Error when loading entity artwork. Error: %@", error.localizedDescription)
            }
        }
    }
    
    private func onNetworkStatusChange(status: Reachability) {
        onNetworkChange?(status.connection != .unavailable)
    }

}
