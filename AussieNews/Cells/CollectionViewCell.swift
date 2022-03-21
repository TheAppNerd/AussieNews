//
//  CollectionViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    let collectionImageView = UIImageView()
    let collectionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        
    }
    
    
    private func configure() {
    
    }
    
    private func layoutUI() {
        
    }
    
    
    
}
