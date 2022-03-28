//
//  TrendingView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingView: UIView {
    //use matching names across all cells and views
    let newsImage          = CustomImageView(frame: .zero)
    let headlineLabel      = CustomLabel(.label)
    let topicLabel         = CustomLabel(.secondaryLabel)
    let articleDateLabel   = CustomLabel(.secondaryLabel)
    let articleAuthorLabel = CustomLabel(.secondaryLabel)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = .secondarySystemBackground
        
        newsImage.contentMode = .scaleAspectFill
        
        headlineLabel.numberOfLines = 0
        headlineLabel.textAlignment = .center
        headlineLabel.textColor = .label
        headlineLabel.layer.cornerRadius = 10
        headlineLabel.layer.masksToBounds = true
        
        topicLabel.textAlignment = .left
        
        articleDateLabel.textAlignment = .left
        
        articleAuthorLabel.textAlignment = .left
    
        
       
        
        
    }
    
    private func layoutUI() {
        self.addSubviews(newsImage, headlineLabel, topicLabel, articleDateLabel, articleAuthorLabel)
        
            let padding: CGFloat = 10
            
            NSLayoutConstraint.activate([
        
                newsImage.topAnchor.constraint(equalTo: self.topAnchor),
                newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                newsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
                
                headlineLabel.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: padding / 2),
                headlineLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                headlineLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                headlineLabel.heightAnchor.constraint(equalToConstant: 50),
                
                topicLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
                topicLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                topicLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                topicLabel.heightAnchor.constraint(equalToConstant: padding * 2),
              
                articleDateLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
                articleDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding / 2),
                articleDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                articleDateLabel.widthAnchor.constraint(equalToConstant: 100),

                articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
                articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding / 2),
                articleAuthorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                articleAuthorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
        
        
    }
    
    func set(_ article: Article) {
        self.newsImage.downloadImage(from: article.media ?? "")
        self.headlineLabel.text = article.title
        self.articleDateLabel.text = article.published_date
        self.articleAuthorLabel.text = article.author
        self.layoutIfNeeded()
        
    }
}
