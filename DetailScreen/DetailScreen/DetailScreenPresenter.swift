//
//  DetailScreenPresenter.swift
//  DetailScreen
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public protocol DetailScreenPresenterProtocol: AnyObject {
    var router: DetailScreenRouterProtocol { get }
    var interactor: DetailScreenInteractorProtocol { get }
    var view: DetailScreenViewControllerProtocol? { get set }
    
    func onViewControllerLoad()
    
}

public class DetailScreenPresenter: NSObject, DetailScreenPresenterProtocol {
    public weak var view: DetailScreenViewControllerProtocol?
    public var router: DetailScreenRouterProtocol
    public var interactor: DetailScreenInteractorProtocol
    
    init(router: DetailScreenRouterProtocol, interactor: DetailScreenInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    public func onViewControllerLoad() {
        guard let entity = interactor.getEntity() else { return }
        view?.initWithModel(entity)
        interactor.getEntityArtwork {[weak self] image in
            self?.view?.setEntityArtwork(image)
        }
    }
    
}
