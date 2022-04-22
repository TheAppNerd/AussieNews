//
//  HomeScreenTableViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

class bigHomeCell: DefaultCell {
    
    static let reuseIdentifier = "bigCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureButtons()
        layoutUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func layoutUI() {
        
        let padding: CGFloat = 10
        

        NSLayoutConstraint.activate([
        
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 0.5),
            
            headlineLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            headlineLabel.heightAnchor.constraint(equalToConstant: 50),

            articleDateLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding / 2),
            articleDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            articleDateLabel.widthAnchor.constraint(equalToConstant: 100),

            articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding / 2),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -padding),
            articleAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            
            saveButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -padding),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 0.6),
            
            shareButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            shareButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: padding),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            shareButton.widthAnchor.constraint(equalTo: shareButton.heightAnchor, multiplier: 0.6)
     ])
        
        
    }
    
}
