//
//  UIButton + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/4/2022.
//

import UIKit

extension UIButton {
    
    enum buttonPurpose {
        case search
        case bookmark
        case recent
        case save
        case share
    }
    
    /// Func created to simplify style of all the buttons used throughout the app.
    func setButtonPurpose(_ purpose: buttonPurpose) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        tintColor          = .label
        setTitleColor(.label, for: .normal)
        
        switch purpose {
        case .search:
            backgroundColor = Color.aussieGreen
            setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        case .bookmark:
            setTitleColor(.secondaryLabel, for: .normal)
        case .recent:
            setTitleColor(.secondaryLabel, for: .normal)
            setTitle("Recently Viewed", for: .normal)
        case .save:
            tintColor = Color.aussieGreen
            setImage(UIImage(systemName: "bookmark"), for: .normal)
        case .share:
            tintColor = Color.aussieGreen
            setImage(UIImage(systemName: "ellipsis"), for: .normal)
        }
    }
    
}
