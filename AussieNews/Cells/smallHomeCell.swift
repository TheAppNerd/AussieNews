//
//  smallHomeCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

class smallHomeCell: DefaultCell {

    static let reuseIdentifier = "smallCell"
    
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
                topicLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                topicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                topicLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor),
                topicLabel.heightAnchor.constraint(equalToConstant: padding * 2),
                
                headlineLabel.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: padding),
                headlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                headlineLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -padding * 2),
                headlineLabel.bottomAnchor.constraint(equalTo: articleDateLabel.topAnchor, constant: -padding),
                
                articleDateLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding),
                articleDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding),
                articleDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
                articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding),
                articleAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                articleAuthorLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -padding),
                articleAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
                
                newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
                newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                newsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
                newsImage.widthAnchor.constraint(equalTo: newsImage.heightAnchor),
                
                saveButton.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
                saveButton.leadingAnchor.constraint(equalTo: newsImage.leadingAnchor),
                saveButton.trailingAnchor.constraint(equalTo: optionsButton.leadingAnchor, constant: padding / 2),
                saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
                
                optionsButton.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
                optionsButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: padding / 2),
                optionsButton.trailingAnchor.constraint(equalTo: newsImage.trailingAnchor),
                optionsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
            ])
            
        
    }
    

}
