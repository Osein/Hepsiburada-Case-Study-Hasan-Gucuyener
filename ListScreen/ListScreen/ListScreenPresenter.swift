//
//  ListScreenPresenter.swift
//  ListScreen
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import EntCore
import Moya
import SVProgressHUD

public protocol ListScreenPresenterProtocol: AnyObject {
    var router: ListScreenRouterProtocol { get }
    var interactor: ListScreenInteractorProtocol { get }
    var view: ListScreenViewControllerProtocol? { get set }
    
    func onViewControllerLoad()

    func onSearchBarTextChange(newText: String)
    func onChangeEntityType(newType: String)
    func onLoadMoreData()
    
    func getEntityCount() -> Int
    func getEntity(byIndex: Int) -> EntItunesSearchItem?
    func getEntityArtwork(byIndex: Int, completion: @escaping ((_ image: UIImage) -> Void))
    
    func onTapEntityView(withIndex: Int)
}

public class ListScreenPresenter: NSObject, ListScreenPresenterProtocol {
    public var router: ListScreenRouterProtocol
    public var interactor: ListScreenInteractorProtocol
    public weak var view: ListScreenViewControllerProtocol?
    private var searchText: String = ""
    private var entityType: String = EntConfig.EntityListItemMap.first!.value
    private var page: Int = 1
    private var incrementPage: Bool = false
    
    init(router: ListScreenRouter, interactor: ListScreenInteractor) {
        self.router = router
        self.interactor = interactor
        super.init()
        interactor.onSearchResponse = onSearchResponse
        interactor.onSearchError = onSearchError(_:)
    }
    
    public func onViewControllerLoad() {
        if interactor.shouldShowNetworkConnectionWarning {
            view?.showNetworkConnectionWarning()
            interactor.onNetworkChange = onReachabilityChange(isReachable:)
        } else if interactor.shouldShowSearchKeywordWarning {
            view?.showSearchKeywordWarning()
        }
    }
    
    public func onSearchBarTextChange(newText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        interactor.cancelPreviousRequest()
        searchText = newText
        incrementPage = false
        if searchText.count > 2 {
            perform(#selector(performSearch), with: searchText, afterDelay: 0.5)
        }
    }
    
    public func onChangeEntityType(newType: String) {
        self.entityType = newType
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        interactor.cancelPreviousRequest()
        incrementPage = false
        if searchText.count > 2 {
            perform(#selector(performSearch), with: searchText, afterDelay: 0.5)
        }
    }
    
    public func onLoadMoreData() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        interactor.cancelPreviousRequest()
        incrementPage = true
        if searchText.count > 2 {
            perform(#selector(performSearch), with: searchText, afterDelay: 0.5)
        }
    }
    
    public func getEntityCount() -> Int {
        return interactor.getEntityCount()
    }
    
    public func getEntity(byIndex: Int) -> EntItunesSearchItem? {
        return interactor.getEntity(byIndex: byIndex)
    }
    
    public func getEntityArtwork(byIndex: Int, completion: @escaping ((_ image: UIImage) -> Void)) {
        interactor.getEntityArtwork(byIndex: byIndex, completion: completion)
    }
    
    public func onTapEntityView(withIndex: Int) {
        guard let entity = getEntity(byIndex: withIndex), let nc = view?.navigationController else { return }
        router.pushDetailScreen(withModel: entity, onto: nc)
    }
    
    @objc private func performSearch() {
        SVProgressHUD.show()
        if incrementPage {
            page = page + 1
        }
        interactor.searchEntities(query: searchText, entityType: entityType, page: page, append: incrementPage)
        incrementPage = false
    }
    
    private func onReachabilityChange(isReachable: Bool) {
        if isReachable {
            view?.showNetworkConnectionWarning()
        } else {
            view?.hideWarningTextView()
        }
    }
    
    private func onSearchResponse() {
        SVProgressHUD.dismiss()
        view?.hideWarningTextView()
        view?.reloadCollectionView()
    }
    
    private func onSearchError(_ error: MoyaError) {
        SVProgressHUD.dismiss()
        view?.showErrorText(errorText: error.localizedDescription)
    }
    
}
