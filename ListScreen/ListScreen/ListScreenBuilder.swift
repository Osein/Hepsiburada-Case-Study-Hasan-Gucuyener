//
//  ListScreenBuilder.swift
//  ListScreen
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import UIKit
import EntCore

public class ListScreenBuilder {
    
    public static func buildNC() -> UINavigationController {
        let router = ListScreenRouter()
        let interactor = ListScreenInteractor(
            networkListener: EntDependencyContainer.getDefaultNetworkListener(),
            networkService: EntDependencyContainer.getDefaultNetworkingService(),
            imageService: EntDependencyContainer.getImageService()
        )
        let presenter = ListScreenPresenter(router: router, interactor: interactor)
        let view = ListScreenViewController(presenter: presenter)
        presenter.view = view
        let ListNC = UINavigationController(rootViewController: view)
        return ListNC
    }
    
}
