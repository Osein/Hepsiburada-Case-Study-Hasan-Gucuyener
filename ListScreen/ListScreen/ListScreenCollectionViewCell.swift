//
//  ListScreenCollectionViewCell.swift
//  ListScreen
//
//  Created by Hasolas on 5.06.2022.
//

import UIKit
import EntCore

class ListCollectionItemView: UICollectionViewCell {
    private var gradient: CAGradientLayer?
    
    let infoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        tv.numberOfLines = 0
        tv.textColor = .white
        return tv
    }()
    
    let priceTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        tv.numberOfLines = 0
        tv.textColor = .white
        return tv
    }()
    
    let releaseDateTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.preferredFont(forTextStyle: .body).withSize(14)
        tv.numberOfLines = 0
        tv.textColor = .white
        return tv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(infoContainerView)
        infoContainerView.addSubview(nameTextView)
        infoContainerView.addSubview(priceTextView)
        infoContainerView.addSubview(releaseDateTextView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            infoContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            infoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameTextView.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 32),
            nameTextView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 8),
            nameTextView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -8),
            
            priceTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 4),
            priceTextView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 8),
            priceTextView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -8),
            
            releaseDateTextView.topAnchor.constraint(equalTo: priceTextView.bottomAnchor, constant: 4),
            releaseDateTextView.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 8),
            releaseDateTextView.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -8),
            releaseDateTextView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initWithModel(_ model: EntItunesSearchItem) {
        nameTextView.text = model.collectionName ?? model.trackName
        priceTextView.text = model.getFormattedPrice()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        releaseDateTextView.text = "\(dateFormatter.string(from: model.releaseDate))"
        
        infoContainerView.setNeedsLayout()
        infoContainerView.layoutIfNeeded()
    }
    
    public func resetArtwork() {
        imageView.image = UIImage()
    }
    
    public func initArtwork(_ image: UIImage) {
        imageView.image = image
    }
    
    private static func createGradientLayer(for view: UIView) -> CAGradientLayer {
        let color = UIColor.black
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [color.withAlphaComponent(0.8090), color.withAlphaComponent(0.9708).cgColor]
        gradientLayer.locations = nil
        return gradientLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if let gradient = gradient {
            gradient.frame = infoContainerView.bounds
        } else {
            gradient = ListCollectionItemView.createGradientLayer(for: infoContainerView)
            infoContainerView.layer.insertSublayer(gradient!, at: 0)
            gradient?.frame = infoContainerView.bounds
        }
    }
    
}
