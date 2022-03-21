//
//  CollectionViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionViewCell"
    
    let collectionImageView = UIImageView()
    let collectionLabel = CustomLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        
    }
    
    
    private func configure() {
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(collectionImageView, collectionLabel)
        collectionImageView.image = UIImage(systemName: "circle")
        collectionLabel.text = "circle"
        collectionLabel.textAlignment = .center
        
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.orange.cgColor
       
    }
    
    private func layoutUI() {
        
        NSLayoutConstraint.activate([
        collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        collectionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
        collectionImageView.widthAnchor.constraint(equalTo: collectionImageView.heightAnchor),
        collectionImageView.bottomAnchor.constraint(equalTo: collectionLabel.topAnchor),
        
        collectionLabel.topAnchor.constraint(equalTo: collectionImageView.bottomAnchor),
        collectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        collectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        collectionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    
    
}
