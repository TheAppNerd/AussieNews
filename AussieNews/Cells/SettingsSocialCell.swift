//
//  SettingsCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 5/4/2022.
//

import UIKit

class SettingsSocialCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier = "SettingsSocialCell"
    let imageArray             = socialMedia.socialImageArray
    let textArray              = socialMedia.socialTextArray
    let settingsImageView      = CustomImageView(frame: .zero)
    let settingsLabel          = CustomLabel()
    
    
    //MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(image: String, text: String) {
        settingsImageView.image = UIImage(named: image)
        settingsLabel.text      = text
    }
    
    
    private func configure() {
        self.backgroundColor          = .systemBackground
        settingsLabel.textAlignment   = .left
        settingsImageView.contentMode = .scaleAspectFit
    }
    
    
    private func layoutUI() {
        contentView.addSubviews(settingsImageView, settingsLabel)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            settingsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            settingsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding * 2),
            settingsImageView.trailingAnchor.constraint(equalTo: settingsLabel.leadingAnchor, constant: -padding),
            settingsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            settingsImageView.widthAnchor.constraint(equalTo: settingsImageView.heightAnchor),
            
            settingsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            settingsLabel.leadingAnchor.constraint(equalTo: settingsImageView.trailingAnchor, constant: padding),
            settingsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            settingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
}
