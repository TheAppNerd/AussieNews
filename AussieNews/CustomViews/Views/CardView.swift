//
//  CardView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/5/2022.
//

import UIKit

class CardView: UIView {

    let card               = UIView()
    let newsImage          = CustomImageView(frame: .zero)
    let headlineLabel      = CustomLabel(.label)
    let articleLabel       = CustomLabel(.label)
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
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 10
        
        headlineLabel.textColor          = .label
        newsImage.image = images.placeholder
        newsImage.contentMode = .scaleAspectFill
    }
    
    func set(article: Article) {
        newsImage.downloadImage(from: article.media ?? "")
        headlineLabel.text      = article.title
    }
    
    private func layoutUI() {
        addSubview(card)
        card.addSubviews(newsImage, headlineLabel, articleLabel, articleDateLabel, articleAuthorLabel)
        
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            card.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.6),
            
            newsImage.topAnchor.constraint(equalTo: card.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 0.5),
            articleDateLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5),
            articleDateLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 5),
            articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -5),
            articleDateLabel.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.1),
            
            articleAuthorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: 5),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -5),
            articleAuthorLabel.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.1),
            
            headlineLabel.topAnchor.constraint(equalTo: articleDateLabel.bottomAnchor, constant: 5),
            headlineLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 5),
            headlineLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -5),
           
            
            
            
            headlineLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            headlineLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            headlineLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor)
            
        ])
    }
    
}
