//
//  Layout.swift
//  AussieNews
//
//  Created by Alexander Thompson on 21/3/2022.
//

import UIKit

enum layout {
    
    ///Flow layout for collectionView. Uses CGfloat calculations to add proper spacing no matter how many items are in the collection view.
    static func collectionViewLayout(in view: UIView, items: CGFloat) -> UICollectionViewFlowLayout {
        
        let width                  = view.bounds.width
        let padding: CGFloat       = 10
        let edges: CGFloat         = 10
        let availableWidth         = width - (padding * 2) - (edges * 2)
        let itemWidth              = availableWidth / items
        
        let flowLayout             = UICollectionViewFlowLayout()
        flowLayout.itemSize        = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
}
