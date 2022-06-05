//
//  ListScreenMockPresenter.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import XCTest
@testable import ListScreen
import EntCore

class ListScreenMockPresenter: ListScreenPresenterProtocol {
    var router: ListScreenRouterProtocol
    var interactor: ListScreenInteractorProtocol
    var view: ListScreenViewControllerProtocol?
    
    var calledOnViewControllerLoad = false
    var calledGetEntityCount = false
    var calledGetEntity = false
    var calledGetEntityArtwork = false
    var calledOnTapEntity = false
    var calledLoadMoreData = false
    var calledSearchBarTextChange = false
    var calledChangeEntityType = false
    
    init(router: ListScreenRouterProtocol, interactor: ListScreenInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func onViewControllerLoad() {
        calledOnViewControllerLoad = true
    }
    
    func onSearchBarTextChange(newText: String) {
        calledSearchBarTextChange = true
    }
    
    func onChangeEntityType(newType: String) {
        calledChangeEntityType = true
    }
    
    func onLoadMoreData() {
        calledLoadMoreData = true
    }
    
    func getEntityCount() -> Int {
        calledGetEntityCount = true
        return 0
    }
    
    func getEntity(byIndex: Int) -> EntItunesSearchItem? {
        calledGetEntity = true
        return nil
    }
    
    func getEntityArtwork(byIndex: Int, completion: @escaping ((UIImage) -> Void)) {
        calledGetEntityArtwork = true
    }
    
    func onTapEntityView(withIndex: Int) {
        calledOnTapEntity = true
    }
    
}
