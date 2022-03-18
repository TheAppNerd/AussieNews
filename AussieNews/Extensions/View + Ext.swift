//
//  View + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
