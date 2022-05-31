//
//  CardView.swift
//  AussieNews
//
//  Created by Alexander Thompson on 17/5/2022.
//

import UIKit

class CardView: UIView {

    // MARK: - Properties

    let card               = UIView()
    let newsImage          = CustomImageView(frame: .zero)
    let headlineLabel      = CustomLabel(.label)
    let articleLabel       = CustomLabel(.label)
    let articleDateLabel   = CustomLabel(.secondaryLabel)
    let articleAuthorLabel = CustomLabel(.secondaryLabel)

    // MARK: - Class Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func configure() {
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.borderColor = Color.aussieGreen.cgColor
        card.layer.borderWidth = 2
        card.layer.cornerRadius = 10

        articleAuthorLabel.textAlignment = .right

        headlineLabel.textColor          = .label
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 25)
        headlineLabel.adjustsFontSizeToFitWidth = true
        headlineLabel.sizeToFit()

        newsImage.contentMode = .scaleAspectFill
    }

    func set(article: Article) {
        newsImage.downloadImage(from: article.media ?? "")
        headlineLabel.text      = article.title
        articleLabel.text = article.summary
        articleLabel.sizeToFit()
        articleAuthorLabel.text = article.clean_url
        if let publishedDate = article.published_date {
            self.articleDateLabel.text   = publishedDate.timeSinceDate()
        }
    }

    private func layoutUI() {
        addSubview(card)
        card.addSubviews(newsImage, headlineLabel, articleLabel, articleDateLabel, articleAuthorLabel)

        let padding: CGFloat = 5

        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            card.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            card.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            card.widthAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.6),

            newsImage.topAnchor.constraint(equalTo: card.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: card.trailingAnchor),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 0.5),

            articleDateLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            articleDateLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: padding),
            articleDateLabel.trailingAnchor.constraint(equalTo: articleAuthorLabel.leadingAnchor, constant: -padding),
            articleDateLabel.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.05),

            articleAuthorLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -padding),
            articleAuthorLabel.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.05),

            headlineLabel.topAnchor.constraint(equalTo: articleDateLabel.bottomAnchor),
            headlineLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: padding),
            headlineLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -padding),
            headlineLabel.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.2),

            articleLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding),
            articleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: padding),
            articleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -padding),
            articleLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -padding)
        ])
    }

}
