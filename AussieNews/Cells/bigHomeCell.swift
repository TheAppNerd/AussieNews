//
//  HomeScreenTableViewCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 18/3/2022.
//

import UIKit

class bigHomeCell: UITableViewCell {
    
    static let reuseIdentifier = "bigCell"
    
    
    var article: Article?
    let newsImage          = CustomImageView(frame: .zero)
    let topicLabel         = CustomLabel(.secondaryLabel)
    let headlineLabel      = CustomLabel(.label)
    let articleDateLabel   = CustomLabel(.secondaryLabel)
    let articleAuthorLabel = CustomLabel(.secondaryLabel)
    let saveButton         = CustomButton()
    let optionsButton      = CustomButton()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        layoutUI()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCell() {
        contentView.addSubviews(newsImage, topicLabel, headlineLabel, articleDateLabel, articleAuthorLabel, saveButton, optionsButton)
        contentView.isUserInteractionEnabled = true
        
        newsImage.contentMode = .scaleAspectFill
        
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        articleDateLabel.text = "1 hour ago"
    }
    
    private func configureButtons() {
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
       // saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        saveButton.tintColor = .secondaryLabel
        
        optionsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        optionsButton.addTarget(self, action: #selector(optionsPressed), for: .touchUpInside)
        optionsButton.tintColor = .secondaryLabel
        
    }
    
//    @objc func savePressed() {
//
//        switch UserDefaultFuncs.savedPagesArray.contains(article!) {
//        case true: UserDefaultFuncs().removeSavedPage(article: article!)
//            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
//        case false: UserDefaultFuncs().savePages(.saved, article: article!)
//            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
//        }
//
//        print(UserDefaultFuncs.savedPagesArray.count)
//    }
    
    @objc func optionsPressed() {
        
    }
    
    
    
    func set(article: Article) {
        self.article = article
        
        switch UserDefaultFuncs.savedPagesArray.contains(article) {
        case true: saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = .orange
        case false: saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.tintColor = .secondaryLabel
        }
        
        if let imageURL = article.media {
            newsImage.downloadImage(from: imageURL)
        }
        topicLabel.text = article.topic?.uppercased()
        headlineLabel.text = article.title
        articleAuthorLabel.text = article.rights

    }
    
    private func layoutUI() {
        
        let padding: CGFloat = 10
        

        NSLayoutConstraint.activate([
        
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            newsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
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
            articleDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            articleDateLabel.widthAnchor.constraint(equalToConstant: 100),

            articleAuthorLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor, constant: padding / 2),
            articleAuthorLabel.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -padding),
            articleAuthorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            
            saveButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            saveButton.trailingAnchor.constraint(equalTo: optionsButton.leadingAnchor, constant: -padding),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            saveButton.widthAnchor.constraint(equalTo: saveButton.heightAnchor, multiplier: 0.6),
            
            optionsButton.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: padding / 2),
            optionsButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: padding),
            optionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            optionsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2),
            optionsButton.widthAnchor.constraint(equalTo: optionsButton.heightAnchor, multiplier: 0.6)
     ])
        
        
    }
    
}
