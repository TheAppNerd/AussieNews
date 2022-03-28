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
    
    func set(topic: String) {
        collectionImageView.image = UIImage(named: topic)
        collectionLabel.text = topic
    }
    
    
    private func configure() {
        collectionImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubviews(collectionImageView)
        collectionImageView.layer.cornerRadius = 10
        collectionImageView.layer.masksToBounds = true
        collectionImageView.addSubview(collectionLabel)
        collectionImageView.contentMode = .scaleAspectFill
        
        collectionLabel.textAlignment = .center
        collectionLabel.layer.cornerRadius = 10
        collectionLabel.layer.masksToBounds = true
        collectionLabel.textColor = .white
        collectionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        collectionLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.orange.cgColor
       
    }
    
    private func layoutUI() {
        
        NSLayoutConstraint.activate([
        collectionImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        collectionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        collectionImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //collectionImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
        //collectionImageView.widthAnchor.constraint(equalTo: collectionImageView.heightAnchor),
        collectionImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
        //collectionLabel.topAnchor.constraint(equalTo: collectionImageView.bottomAnchor),
        collectionLabel.leadingAnchor.constraint(equalTo: collectionImageView.leadingAnchor),
        collectionLabel.trailingAnchor.constraint(equalTo: collectionImageView.trailingAnchor),
        collectionLabel.bottomAnchor.constraint(equalTo: collectionImageView.bottomAnchor),
        collectionLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    
    
}
