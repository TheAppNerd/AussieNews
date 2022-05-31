//
//  HomeScreenTableViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit


class bigHomeCell: DefaultCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "bigCell"
    
    // MARK: - Class Funcs
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        configureButtons()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func layoutUI() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 0.5),
            
            articleDateLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
            articleDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            articleDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            headlineLabel.topAnchor.constraint(equalTo: articleDateLabel.bottomAnchor, constant: padding / 2),
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            headlineLabel.bottomAnchor.constraint(equalTo: articleAuthorLabel.topAnchor, constant: -padding / 2),
            
            articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -padding / 2),
            articleAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            
            saveButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -padding),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            saveButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            saveButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            shareButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            shareButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            shareButton.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
        ])
    }
    
}
