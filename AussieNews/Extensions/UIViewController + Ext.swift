//
//  UIViewController + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 28/3/2022.
//

import UIKit

extension UIViewController {

    ///Sets any previously saved Dark Mode status from UserDefaults.
    func selectCurrentDarkMode() {
        let defaults = UserDefaults.standard
        var mode     = traitCollection.userInterfaceStyle

        switch defaults.object(forKey: DarkMode.key) as? String {
        case DarkMode.device: mode = UIScreen.main.traitCollection.userInterfaceStyle
        case DarkMode.light:  mode = UIUserInterfaceStyle.light
        case DarkMode.dark:   mode = UIUserInterfaceStyle.dark
        case nil:             mode = UIScreen.main.traitCollection.userInterfaceStyle
        default:              mode = UIScreen.main.traitCollection.userInterfaceStyle
        }
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = mode
        }
    }


    enum saveStatus {
        case saving
        case removing
        case copied
    }

    // TODO: - create seperate view for this func.
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
        
        imageView.tintColor                   = Color.aussieGreen
        
        switch status {
        case .saving: imageView.image = Images.bookMarkFill
            mainLabel.text = SaveLabelText.saveMain
            secondLabel.text = SaveLabelText.saveSecond
        case .removing: imageView.image = Images.bookmark
            mainLabel.text = SaveLabelText.removingMain
            secondLabel.text = SaveLabelText.removingSecond
        case .copied: imageView.image = Images.link
            mainLabel.text = SaveLabelText.copiedMain
            secondLabel.text = SaveLabelText.copiedSecond
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) {
                saveView.alpha = 0.0
            } completion: { _ in
                saveView.removeFromSuperview()
            }
        }

    }
    
}

