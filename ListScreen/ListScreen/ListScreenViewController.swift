//
//  ListScreenViewController.swift
//  ListScreen
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import EntCore

public protocol ListScreenViewControllerProtocol: UIViewController {
    var presenter: ListScreenPresenterProtocol { get }
    
    // Warning view related funcs
    func showNetworkConnectionWarning()
    func showSearchKeywordWarning()
    func hideWarningTextView()
    func showErrorText(errorText: String)
    
    func reloadCollectionView()
    
}

public class ListScreenViewController: UIViewController, ListScreenViewControllerProtocol {
    public var presenter: ListScreenPresenterProtocol
    
    private let searchBarController: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundImage = UIImage()
        return sb
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: EntConfig.EntityListItemMap.map({ $0.key }))
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    private var collectionView: UICollectionView = {
        let cw = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cw.translatesAutoresizingMaskIntoConstraints = false
        return cw
    }()
    
    private var warningTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = false
        tv.font = UIFont.preferredFont(forTextStyle: .title3)
        tv.textAlignment = .center
        return tv
    }()
    
    init(presenter: ListScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Entity List"
        
        view.backgroundColor = .white
        
        view.addSubview(searchBarController)
        searchBarController.delegate = self
        view.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "EmptyCell")
        collectionView.register(ListCollectionItemView.self, forCellWithReuseIdentifier: "EntityCell")
        view.addSubview(warningTextView)
        
        warningTextView.isHidden = true
        
        NSLayoutConstraint.activate([
            searchBarController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            searchBarController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBarController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            segmentedControl.topAnchor.constraint(equalTo: searchBarController.bottomAnchor, constant: 6),
            segmentedControl.leadingAnchor.constraint(equalTo: searchBarController.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: searchBarController.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            warningTextView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            warningTextView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            warningTextView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 32),
            warningTextView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -32)
        ])
        
        presenter.onViewControllerLoad()
    }
    
    public func showNetworkConnectionWarning() {
        collectionView.reloadData()
        warningTextView.isHidden = false
        warningTextView.text = EntLocalization.networkConnectionWarningText
        warningTextView.textColor = .darkText
    }
    
    public func showSearchKeywordWarning() {
        collectionView.reloadData()
        warningTextView.isHidden = false
        warningTextView.text = EntLocalization.EntityListScreen.pleaseWriteSomethingToSearch
        warningTextView.textColor = .darkText
    }
    
    public func showErrorText(errorText: String) {
        collectionView.reloadData()
        warningTextView.isHidden = false
        warningTextView.text = errorText
        warningTextView.textColor = .systemRed
    }
    
    public func hideWarningTextView() {
        warningTextView.isHidden = true
    }
    
    public func reloadCollectionView() {
        collectionView.reloadData()
        
        if(presenter.getEntityCount() == 0) {
            warningTextView.isHidden = false
            warningTextView.text = EntLocalization.EntityListScreen.noResultsForYourSearch
            warningTextView.textColor = .blue
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let index = EntConfig.EntityListItemMap.index(
            EntConfig.EntityListItemMap.startIndex, offsetBy: sender.selectedSegmentIndex
        )
        
        presenter.onChangeEntityType(
            newType: EntConfig.EntityListItemMap[index].value
        )
    }
    
}

extension ListScreenViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.onSearchBarTextChange(newText: searchText)
    }
    
}

extension ListScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getEntityCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let entity = presenter.getEntity(byIndex: indexPath.item),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EntityCell", for: indexPath) as? ListCollectionItemView else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath)
        }
        
        cell.initWithModel(entity)
        cell.resetArtwork()
        presenter.getEntityArtwork(byIndex: indexPath.item) { image in
            cell.initArtwork(image)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 48) / 2
        let height = width * 16 / 9
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.onTapEntityView(withIndex: indexPath.item)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let itemHeight = ((collectionView.frame.width - 48) / 2) * 16 / 9
        
        let contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX >= (scrollView.contentSize.width - scrollView.bounds.width) - (itemHeight * 2) {
            presenter.onLoadMoreData()
        }
    }
    
}
