//
//  SafariProtocol.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit
import SafariServices

protocol SafariProtocol { }

extension SafariProtocol {

    func showArticle(_ vc: UIViewController, article: Article) {
        UserDefaultFuncs().saveArticle(.visited, article: article)
        guard let articleLink = article.link else { return }
        if let url = URL(string: articleLink) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariVC = SFSafariViewController(url: url, configuration: config)
            vc.present(safariVC, animated: true)
        }
    }
}

