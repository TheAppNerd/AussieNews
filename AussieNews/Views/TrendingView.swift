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
    let articleLabel         = CustomLabel(.label)
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
        
        newsImage.contentMode = .scaleToFill
        
        headlineLabel.textAlignment = .center
        headlineLabel.textColor = .label
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        articleLabel.textAlignment = .left
        articleDateLabel.textAlignment = .left
        articleAuthorLabel.textAlignment = .left
    
    }
    
    private func layoutUI() {
        self.addSubviews(newsImage, headlineLabel, articleLabel, articleDateLabel, articleAuthorLabel)
        
            let padding: CGFloat = 10
            
            NSLayoutConstraint.activate([
        
                newsImage.topAnchor.constraint(equalTo: self.topAnchor),
                newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                newsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
                
                headlineLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: padding / 2),
                headlineLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                headlineLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                headlineLabel.heightAnchor.constraint(equalToConstant: 50),
                
                articleLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding ),
                articleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                articleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                articleLabel.bottomAnchor.constraint(equalTo: articleDateLabel.topAnchor, constant: -padding),
              
                articleDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
                articleDateLabel.heightAnchor.constraint(equalToConstant: 50),
                articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding / 2),
                articleDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
                articleDateLabel.widthAnchor.constraint(equalToConstant: 100),
               
                articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding / 2),
                articleAuthorLabel.heightAnchor.constraint(equalToConstant: 50),
                articleAuthorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                articleAuthorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
        
        
    }
    
    func set(_ article: Article) {
        self.newsImage.downloadImage(from: article.media ?? "")
        self.headlineLabel.text = article.title
        self.articleLabel.text = article.excerpt
        self.articleDateLabel.text = article.published_date
        self.articleAuthorLabel.text = article.rights
        self.layoutIfNeeded()
        
    }
}
