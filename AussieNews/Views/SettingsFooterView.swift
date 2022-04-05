//
//  SettingsFooterView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 5/4/2022.
//

import UIKit

class SettingsFooterView: UIView {
    
    let iconImage = CustomImageView(frame: .zero)
    let appNerdImage = CustomImageView(frame: .zero)
    let footerLabel = CustomLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        iconImage.image = UIImage(named: "aussieNewsIcon")
        appNerdImage.image = UIImage(named: "appNerdIcon")
        footerLabel.textAlignment = .center
        footerLabel.text = """
Aussie News
App made with 🤍 by
Alex Thompson
"""
    }
    
    private func layoutUI() {
        self.addSubviews(iconImage, appNerdImage, footerLabel)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            iconImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),
            
            footerLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: padding),
            footerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            footerLabel.widthAnchor.constraint(equalTo: iconImage.widthAnchor, multiplier: 2.0),
            footerLabel.heightAnchor.constraint(equalTo: iconImage.heightAnchor),
            
            appNerdImage.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: padding),
            appNerdImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appNerdImage.widthAnchor.constraint(equalTo: iconImage.widthAnchor),
            appNerdImage.heightAnchor.constraint(equalTo: appNerdImage.widthAnchor)
                                                 
        ])
    }
    
}
