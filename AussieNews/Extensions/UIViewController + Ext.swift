//
//  UIViewController + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 28/3/2022.
//

import UIKit

extension UIViewController {
    
    enum saveStatus {
        case saving
        case removing
        case copied
    }
    
    ///Creates a toast label which can display one of 3 messages depending on where it is called.
    func saveLabel(_ status: saveStatus) {
        
        let saveView    = UIView()
        let imageView   = CustomImageView(frame: .zero)
        let mainLabel   = CustomLabel(.label)
        let secondLabel = CustomLabel(.secondaryLabel)
        
        saveView.translatesAutoresizingMaskIntoConstraints = false
        saveView.backgroundColor              = .secondarySystemBackground
        saveView.layer.cornerRadius           = 10
        saveView.layer.masksToBounds          = true
        
        mainLabel.font                        = UIFont.boldSystemFont(ofSize: 16)
        mainLabel.textAlignment               = .left
        mainLabel.adjustsFontSizeToFitWidth   = true
        
        secondLabel.textAlignment             = .left
        secondLabel.adjustsFontSizeToFitWidth = true
        
        imageView.tintColor                   = color.aussieGreen
        
        switch status {
        case .saving: imageView.image = images.bookMarkFill
            mainLabel.text = saveLabelText.saveMain
            secondLabel.text = saveLabelText.saveSecond
        case .removing: imageView.image = images.bookmark
            mainLabel.text = saveLabelText.removingMain
            secondLabel.text = saveLabelText.removingSecond
        case .copied: imageView.image = images.link
            mainLabel.text = saveLabelText.copiedMain
            secondLabel.text = saveLabelText.copiedSecond
        }
        
        self.view.addSubview(saveView)
        saveView.addSubviews(imageView, mainLabel, secondLabel)
        
        NSLayoutConstraint.activate([
            saveView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            saveView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            saveView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            saveView.heightAnchor.constraint(equalToConstant: 60),
            
            imageView.centerYAnchor.constraint(equalTo: saveView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: saveView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: saveView.heightAnchor, multiplier: 0.7),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            mainLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            mainLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            mainLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5),
            mainLabel.trailingAnchor.constraint(equalTo: saveView.trailingAnchor),
            
            secondLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            secondLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            secondLabel.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.5),
            secondLabel.trailingAnchor.constraint(equalTo: saveView.trailingAnchor)
        ])
        
        self.view.addSubview(saveView)
        self.view.bringSubviewToFront(saveView)
        
        UIView.animate(withDuration: 4.0, delay: 0.0, options: .curveEaseIn) {
            saveView.alpha = 0.0
        } completion: { _ in
            saveView.removeFromSuperview()
        }
    }
    
}

