//
//  TrendingButtonView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 24/3/2022.
//

import UIKit

class TrendingButtonView: UIView {
    
    let openURLButton = CustomButton()
    let saveButton = CustomButton()
    let shareButton = CustomButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        self.backgroundColor = .darkGray
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        
        openURLButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        openURLButton.setTitle(" Read", for: .normal)
        openURLButton.backgroundColor = .systemBlue
        openURLButton.tintColor = .white
        
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        saveButton.backgroundColor = .systemOrange
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.backgroundColor = .systemPurple
        
        
    }
    
    
    private func layoutUI() {
        addSubviews(openURLButton, saveButton, shareButton)
        
        NSLayoutConstraint.activate([
            openURLButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            openURLButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            openURLButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            openURLButton.widthAnchor.constraint(equalTo: openURLButton.heightAnchor, multiplier: 2.0),
            
            saveButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            saveButton.leadingAnchor.constraint(equalTo: openURLButton.trailingAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            saveButton.heightAnchor.constraint(equalTo: openURLButton.heightAnchor),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor),
            
            shareButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 10),
            shareButton.heightAnchor.constraint(equalTo: openURLButton.heightAnchor),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor),
            shareButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -60)
        ])
        
    }
    
}
