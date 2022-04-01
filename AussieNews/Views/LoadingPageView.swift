//
//  LoadingPageVC.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

class LoadingPageView: UIView {
    
    let iconImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = .systemBackground
        iconImage.image = UIImage(named: "AussieNewsIcon")
        self.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutUI() {
        self.addSubview(iconImage)
        
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor)
        ])
    }
    
    
}
