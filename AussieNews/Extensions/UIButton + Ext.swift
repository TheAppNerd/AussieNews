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
    
    ///Func created to simplify style of all the buttons used throughout the app.
    func setButtonPurpose(_ purpose: buttonPurpose) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        tintColor          = .label
        setTitleColor(.label, for: .normal)
        
        switch purpose {
        case .readArticle:
            backgroundColor = color.aussieGreen
            setImage(UIImage(systemName: "chevron.up"), for: .normal)
            setTitle("Read Article", for: .normal)
        case .search:
            backgroundColor = color.aussieGreen
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
