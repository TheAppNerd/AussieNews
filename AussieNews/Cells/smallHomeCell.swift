//
//  smallHomeCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

class smallHomeCell: UITableViewCell {

    static let reuseIdentifier = "smallCell"
    
    
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
        newsImage.image = UIImage(named: "placeholder")
        
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
        
        if let imageURL = article.urlToImage {
            newsImage.downloadImage(from: imageURL)
        }
        //topicLabel.text = article.topic?.uppercased()
        headlineLabel.text = article.title
        articleAuthorLabel.text = article.source?.name

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
