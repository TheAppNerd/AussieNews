//
//  HomeScreenTableViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "HomeScreenCell"
    
    let newsImage          = UIImageView()
    let topicLabel         = CustomLabel(.secondaryLabel)
    let headlineLabel      = CustomLabel(.label)
    let articleDateLabel   = CustomLabel(.systemGray3)
    let articleAuthorLabel = CustomLabel(.systemGray3)
    //button 1
    //button 2

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        contentView.addSubviews(newsImage, topicLabel, headlineLabel, articleDateLabel, articleAuthorLabel)
        contentView.isUserInteractionEnabled = true
        
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.layer.cornerRadius = 10
        newsImage.image = UIImage(systemName: "folder")
        topicLabel.text = "Entertainment"
        headlineLabel.text = "Something happened which was very interestimg but I wont tell you about it"
        articleDateLabel.text = "1 hour ago"
        articleAuthorLabel.text = "CNN"
    }
    
    
    func set() {
        
        
    }
    
    private func layoutUI() {
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
        
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            topicLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
            topicLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            topicLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            topicLabel.heightAnchor.constraint(equalToConstant: padding * 2),
            
            headlineLabel.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: padding / 2),
            headlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            headlineLabel.heightAnchor.constraint(equalToConstant: 50),

            articleDateLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding / 2),
            articleDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            articleDateLabel.widthAnchor.constraint(equalToConstant: 100),

            articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding / 2),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            articleAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
     ])
    }
}
