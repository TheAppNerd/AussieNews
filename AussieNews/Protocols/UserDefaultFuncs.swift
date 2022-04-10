//
//  UserDefaultProtocol.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

//each cell needs to load arrays to check if saved or visited
//savedpagesvc needs for count and to show
//tableview needs it at did select row at


class UserDefaultFuncs {
    
    var savedArticleArray: [Article]
    var visitedArticleArray: [Article]
    let defaults = UserDefaults.standard
    
    init() {
        savedArticleArray = []
        visitedArticleArray = []
    }
    
    
    func retrieveArticles() {
        if let data = defaults.object(forKey: "visited") as? Data {
            let array = try! JSONDecoder().decode([Article].self, from: data)
            visitedArticleArray = []
            visitedArticleArray.append(contentsOf: array)
        }
        
        if let data = defaults.object(forKey: "saved") as? Data {
            let array = try! JSONDecoder().decode([Article].self, from: data)
            savedArticleArray = []
            savedArticleArray.append(contentsOf: array)
        }
    }
        
    
    func saveArticle(_ articleArray: articleArray, article: Article) {
        retrieveArticles()
        switch articleArray {
        case .visited: visitedArticleArray.append(article)
            if let data = try? JSONEncoder().encode(visitedArticleArray) {
                defaults.set(data, forKey: "visited")
            } else {
                print("Failed to save articles.")
            }
            
        case .saved: savedArticleArray.append(article)
            if let data = try? JSONEncoder().encode(savedArticleArray) {
                defaults.set(data, forKey: "saved")
            } else {
                print("Failed to save articles.")
            }
        }
    }
    

    func removeSavedArticle(article: Article) {
        retrieveArticles()
        savedArticleArray.removeAll { $0.link == article.link }
            if let data = try? JSONEncoder().encode(savedArticleArray) {
                defaults.set(data, forKey: "saved")
            } else {
                print("Failed to save articles.")
            }
        }
    }


