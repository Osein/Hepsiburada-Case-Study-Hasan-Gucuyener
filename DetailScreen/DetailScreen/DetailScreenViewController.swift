//
//  DetailScreenViewController.swift
//  DetailScreen
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import EntCore
import EntCore

public protocol DetailScreenViewControllerProtocol: UIViewController {
    var presenter: DetailScreenPresenterProtocol { get }
    
    func initWithModel(_ model: EntItunesSearchItem)
    func setEntityArtwork(_ image: UIImage)
}

public class DetailScreenViewController: UIViewController, DetailScreenViewControllerProtocol {
    public var presenter: DetailScreenPresenterProtocol
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        tv.numberOfLines = 0
        tv.textColor = .black
        return tv
    }()
    
    let priceTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        tv.numberOfLines = 0
        tv.textColor = .black
        return tv
    }()
    
    let releaseDateTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        tv.numberOfLines = 0
        tv.textColor = .black
        return tv
    }()
    
    init(presenter: DetailScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        presenter.onViewControllerLoad()
    }
    
    private func initViews() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameTextView)
        scrollView.addSubview(priceTextView)
        scrollView.addSubview(releaseDateTextView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            nameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            priceTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 16),
            priceTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            releaseDateTextView.topAnchor.constraint(equalTo: priceTextView.bottomAnchor, constant: 16),
            releaseDateTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            releaseDateTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            releaseDateTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])
    }
    
    public func setEntityArtwork(_ image: UIImage) {
        imageView.image = image
    }
    
    public func initWithModel(_ model: EntItunesSearchItem) {
        nameTextView.text = model.collectionName ?? model.trackName
        priceTextView.text = model.getFormattedPrice()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        releaseDateTextView.text = "\(dateFormatter.string(from: model.releaseDate))"
    }
    
}
