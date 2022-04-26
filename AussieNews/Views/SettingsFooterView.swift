//
//  SettingsFooterView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 5/4/2022.
//

import UIKit

class SettingsFooterView: UIView {
    
    //MARK: - Properties
    
    let appNerdImage = CustomImageView(frame: .zero)
    let footerLabel  = CustomLabel()
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func configure() {
        appNerdImage.image = settings.iconImage
        footerLabel.textAlignment = .center
        footerLabel.textColor = .darkGray
        footerLabel.text = settings.footerText
    }
    
    
    private func layoutUI() {
        self.addSubviews(appNerdImage, footerLabel)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            footerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding * 5),
            footerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            footerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            footerLabel.heightAnchor.constraint(equalTo: footerLabel.heightAnchor),
            
            appNerdImage.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: padding),
            appNerdImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            appNerdImage.widthAnchor.constraint(equalTo: footerLabel.widthAnchor, multiplier: 0.5),
            appNerdImage.heightAnchor.constraint(equalTo: appNerdImage.widthAnchor)
        ])
    }
    
}
