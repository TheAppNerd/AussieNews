//
//  NewsManagerProtocol.swift
//  AussieNews
//
//  Created by Alexander Thompson on 29/3/2022.
//

import UIKit

protocol NewsManagerProtocol {
    
}

extension NewsManagerProtocol {
    
    func getArticles(params: NewsManager.networkParams, self: UIViewController, newsArray: inout [Article]) {
        var array: [Article] = []
        NewsManager.Shared.getNews(params: params) { result in
            switch result {
            case .success(let newsArticles):
                    array.append(contentsOf: newsArticles.articles)
            case.failure(let error): print(error.rawValue)
            }
        }
        newsArray.append(contentsOf: array)
    }
    
}
