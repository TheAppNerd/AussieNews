//
//  UIButton + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/4/2022.
//

import UIKit

extension UIButton {
    
    enum buttonPurpose {
        case readArticle
        case search
        case bookmark
        case recent
        case save
        case share
        
    }
    
    func setButtonPurpose(_ purpose: buttonPurpose) {
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .label
        setTitleColor(.label, for: .normal)
        
        switch purpose {
        case .readArticle:
            backgroundColor = .systemBlue
            setImage(UIImage(systemName: "chevron.up"), for: .normal)
            setTitle("Read Article", for: .normal)
        case .search:
            backgroundColor = .systemBlue
            setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        case .bookmark:
            setTitleColor(.secondaryLabel, for: .normal)
        case .recent:
            setTitleColor(.secondaryLabel, for: .normal)
            setTitle("Recently Viewed", for: .normal)
        case .save:
            tintColor = .secondaryLabel
            setImage(UIImage(systemName: "bookmark"), for: .normal)
        case .share:
            tintColor = .secondaryLabel
            setImage(UIImage(systemName: "ellipsis"), for: .normal)
        }
    }
    
}
