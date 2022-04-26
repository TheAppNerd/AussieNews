//
//  TrendingView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 23/3/2022.
//

import UIKit

class TrendingView: UIView {
    
    //MARK: - Properties

    let newsImage          = CustomImageView(frame: .zero)
    let headlineLabel      = CustomLabel(.label)
    let articleLabel       = CustomLabel(.label)
    let articleDateLabel   = CustomLabel(.secondaryLabel)
    let articleAuthorLabel = CustomLabel(.secondaryLabel)
    var article: Article?
    
    
    //MARK: - Class Funcs
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Functions
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius          = 10
        self.backgroundColor             = .secondarySystemBackground
        
        newsImage.contentMode            = .scaleToFill
        
        headlineLabel.textAlignment      = .left
        headlineLabel.textColor          = .label
        headlineLabel.font               = UIFont.boldSystemFont(ofSize: 20)
        headlineLabel.numberOfLines      = 3
        
        articleLabel.textAlignment       = .left
        articleDateLabel.textAlignment   = .left
        articleAuthorLabel.textAlignment = .left
    }
    
    
    ///updates the displayed news article on this view.
    func set(_ article: Article) {
        self.newsImage.downloadImage(from: article.media ?? "")
        self.headlineLabel.text      = article.title
        self.articleLabel.text       = article.summary
        self.articleAuthorLabel.text = article.rights
        self.article                 = article
        if let publishedDate = article.published_date {
            self.articleDateLabel.text   = DateFuncs().timeSinceDate(dateStr: publishedDate)
        }
        self.layoutIfNeeded()
    }
    
    private func layoutUI() {
        self.addSubviews(newsImage, headlineLabel, articleLabel, articleDateLabel, articleAuthorLabel)
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: self.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
            articleDateLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5),
            articleDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            articleDateLabel.heightAnchor.constraint(equalToConstant: 50),
            articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding),
            articleDateLabel.widthAnchor.constraint(equalToConstant: 100),
            
            articleAuthorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding),
            articleAuthorLabel.heightAnchor.constraint(equalToConstant: 50),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            headlineLabel.topAnchor.constraint(equalTo: articleDateLabel.bottomAnchor, constant: padding / 2),
            headlineLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            headlineLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            headlineLabel.heightAnchor.constraint(equalToConstant: 60),
            
            articleLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            articleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            articleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }

}
