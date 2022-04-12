//
//  DefaultCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

class DefaultCell: UITableViewCell {


    var article: Article?
    let newsImage          = CustomImageView(frame: .zero)
    let topicLabel         = CustomLabel(.secondaryLabel)
    let headlineLabel      = CustomLabel(.label)
    let articleDateLabel   = CustomLabel(.secondaryLabel)
    let articleAuthorLabel = CustomLabel(.secondaryLabel)
    let saveButton         = CustomButton()
    let optionsButton      = CustomButton()
    var parentVC           = UIViewController()
    var parentTableView    = UITableView()
    let userDefaultFuncs = UserDefaultFuncs()
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Share To...", image: UIImage(systemName: "square.and.arrow.up"), attributes: .destructive, handler: { (_) in
                self.shareArticle()
            }),
            UIAction(title: "Copy Link", image: UIImage(systemName: "link"), attributes: .destructive, handler: { (_) in
                UIPasteboard.general.string = self.article?.link
                self.parentVC.saveLabel(.copied)
            }),
        ]
    }
        var menu: UIMenu {
            return UIMenu(title: "", image: nil, children: menuItems)
        }
    
    
     func configureCell() {
         
        contentView.addSubviews(newsImage, topicLabel, headlineLabel, articleDateLabel, articleAuthorLabel, saveButton, optionsButton)
        contentView.isUserInteractionEnabled = true
        
        newsImage.contentMode = .scaleAspectFill
        newsImage.image = UIImage(named: "placeholder")
        
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
    
     func configureButtons() {
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        saveButton.tintColor = .secondaryLabel
        
        optionsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        optionsButton.tintColor = .secondaryLabel
         
         optionsButton.menu = menu
         optionsButton.showsMenuAsPrimaryAction = true
    }
    
    func shareArticle() {
        if let urlString = NSURL(string: (article?.link)!) {
            let activityItems = [urlString]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        activityViewController.isModalInPresentation = true
        parentVC.present(activityViewController, animated: true, completion: nil)
        }
    }
        

    func calculateDates(from fromDate: Date) -> Date {
        let today = Date()
        let timeFrame = today.timeIntervalSince(fromDate)
        
        
        if timeFrame < 0 {
            return today
        } else {
            return today.addingTimeInterval(timeFrame)
        }
    }
        
    

    @objc func savePressed() {
        guard let article = article else { return }
        switch userDefaultFuncs.savedArticleArray.contains(article) {
        case true: userDefaultFuncs.removeSavedArticle(article: article)
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            parentVC.saveLabel(.removing)
        case false: userDefaultFuncs.saveArticle(.saved, article: article)
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            parentVC.saveLabel(.saving)
        }
        parentTableView.reloadData()
    }
    
    func stringToDate(for dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateStr)
    }
    
    
    func set(article: Article, vc: UIViewController, tableView: UITableView) {
        self.article = article
        userDefaultFuncs.retrieveArticles()
        parentVC = vc
        parentTableView = tableView
        switch userDefaultFuncs.savedArticleArray.contains(article) {
        case true: saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            saveButton.tintColor = .orange
        case false: saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            saveButton.tintColor = .secondaryLabel
        }
        
        if let imageURL = article.media {
            newsImage.downloadImage(from: imageURL)
        }
        //topicLabel.text = article.topic?.uppercased()
        headlineLabel.text = article.title
        articleAuthorLabel.text = article.rights
        articleDateLabel.text = article.published_date
    }
    
}
