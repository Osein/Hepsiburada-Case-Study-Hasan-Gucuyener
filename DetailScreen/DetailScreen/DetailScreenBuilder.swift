//
//  DetailScreenBuilder.swift
//  DetailScreen
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import EntCore

public class DetailScreenBuilder {
    
    public static func buildVC(entity: EntItunesSearchItem) -> UIViewController {
        let router = DetailScreenRouter()
        let interactor = DetailScreenInteractor(
            imageService: EntDependencyContainer.getImageService(),
            entity: entity
        )
        let presenter = DetailScreenPresenter(router: router, interactor: interactor)
        let view = DetailScreenViewController(presenter: presenter)
        presenter.view = view
        return view
    }
    
}
