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
    
    func showArticle(_ vc: UIViewController, urlString: String) {
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let safariVC = SFSafariViewController(url: url, configuration: config)
            vc.present(safariVC, animated: true)
        }
    }
    
}

//what other funcs can be protocols?
//json parsing
//
