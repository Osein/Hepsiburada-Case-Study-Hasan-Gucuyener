//
//  ListScreenMockViewController.swift
//  ListScreenTests
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import XCTest
@testable import ListScreen
import EntCore

class ListScreenMockViewController: UIViewController, ListScreenViewControllerProtocol {
    var presenter: ListScreenPresenterProtocol
    
    init(presenter: ListScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showNetworkConnectionWarning() {
        
    }
    
    func showSearchKeywordWarning() {
        
    }
    
    func hideWarningTextView() {
        
    }
    
    func showErrorText(errorText: String) {
        
    }
    
    func reloadCollectionView() {
        
    }
    
    
}
