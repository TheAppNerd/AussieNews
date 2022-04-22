//
//  TrendingProgressView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/4/2022.
//

import UIKit

class TrendingProgressView: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        progressViewStyle   = .bar
        backgroundColor     = .systemGray3
        progressTintColor   = .systemBlue
        layer.cornerRadius  = 5
        layer.masksToBounds = true
    }
}
