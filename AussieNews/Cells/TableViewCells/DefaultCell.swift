//
//  DefaultCell.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

class DefaultCell: UITableViewCell {

    // MARK: - Properties

    let newsImage          = CustomImageView(frame: .zero)
    let headlineLabel      = CustomLabel(.label)
    let articleDateLabel   = CustomLabel(.secondaryLabel)
    let articleAuthorLabel = CustomLabel(.secondaryLabel)
    let saveButton         = UIButton()
    let shareButton        = UIButton()
    let userDefaultFuncs   = UserDefaultFuncs()
    var parentVC           = UIViewController()
    var article: Article?

    /// Creates a menu list for each article to either share it or copy the url link to pasteboard.
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


    // MARK: - Methods

    func configureCell() {
        contentView.addSubviews(newsImage, headlineLabel, articleDateLabel, articleAuthorLabel, saveButton, shareButton)
        contentView.isUserInteractionEnabled = true
        newsImage.contentMode = .scaleAspectFill
        newsImage.image       = Images.placeholder // TODO: - Nessecary?

        headlineLabel.font    = UIFont.boldSystemFont(ofSize: 16)
        headlineLabel.adjustsFontSizeToFitWidth = true
    }

    func configureButtons() {
        saveButton.setButtonPurpose(.save)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)

        shareButton.setButtonPurpose(.share)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.menu = menu
        shareButton.showsMenuAsPrimaryAction = true
    }

    // TODO: - move outside of cell.
    func shareArticle() {
        guard let articleLink = article?.link else { return }
        if let urlString = NSURL(string: articleLink) {
            let activityItems = [urlString]
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)

            activityViewController.isModalInPresentation = true
            parentVC.present(activityViewController, animated: true, completion: nil)
        }
    }

    /// Called from primary VC to fill each cell with data. The switch confirms whether the article has been saved or not.
    func set(article: Article, vc: UIViewController) {
        userDefaultFuncs.retrieveArticles()
        self.article    = article
        parentVC        = vc //Allocated to perform various actions in primary VC

        switch userDefaultFuncs.savedArticleArray.contains(article) {
        case true:  saveButton.setImage(Images.bookMarkFill, for: .normal)
            saveButton.tintColor = Color.aussieGreen
        case false: saveButton.setImage(Images.bookmark, for: .normal)
            saveButton.tintColor = .secondaryLabel
        }

        if let imageURL = article.media {
            newsImage.downloadImage(from: imageURL)
        }

        headlineLabel.text      = article.title
        articleAuthorLabel.text = article.clean_url
        if let publishedDate    = article.published_date {
            articleDateLabel.text   = publishedDate.timeSinceDate()
        }
    }

    // MARK: - @objc Funcs

    @objc func savePressed() {
        guard let article = article else { return }

        switch userDefaultFuncs.savedArticleArray.contains(article) {
        case true: userDefaultFuncs.removeSavedArticle(article: article)
            saveButton.setImage(Images.bookmark, for: .normal)
            parentVC.saveLabel(.removing)
        case false: userDefaultFuncs.saveArticle(.saved, article: article)
            saveButton.setImage(Images.bookMarkFill, for: .normal)
            parentVC.saveLabel(.saving)
        }
    }

}
