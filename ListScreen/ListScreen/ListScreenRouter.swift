//
//  ListScreenRouter.swift
//  ListScreen
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation
import EntCore
import UIKit
import DetailScreen

public protocol ListScreenRouterProtocol {
    func pushDetailScreen(withModel: EntItunesSearchItem, onto: UINavigationController)
}

public class ListScreenRouter: ListScreenRouterProtocol {
    
    public func pushDetailScreen(withModel: EntItunesSearchItem, onto nc: UINavigationController) {
        let detailVC = DetailScreenBuilder.buildVC(entity: withModel)
        nc.pushViewController(detailVC, animated: true)
    }
    
}
