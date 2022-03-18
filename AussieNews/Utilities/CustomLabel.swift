//
//  CustomImageView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit


class CustomLabel: UILabel {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ textColor: UIColor) {
        self.textColor = textColor
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
    }
    
}
