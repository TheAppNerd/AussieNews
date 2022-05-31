//
//  UserDefaultProtocol.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

// TODO: - setup user defauls differently.

class UserDefaultFuncs {

    // MARK: - Properties

    let defaults = UserDefaults.standard
    var savedArticleArray: [Article]
    var visitedArticleArray: [Article]

    /// Creates new empty arrays.
    init() {
        savedArticleArray = []
        visitedArticleArray = []
    }

    // MARK: - Functions

    /// Retrieve all articles saved via user defaults to populate saved & visited article arrays.
    func retrieveArticles() {
        if let visitedData = defaults.object(forKey: "visited") as? Data {
            let array = try! JSONDecoder().decode([Article].self, from: visitedData)
            visitedArticleArray = []
            visitedArticleArray.append(contentsOf: array)
        }

        if let savedData = defaults.object(forKey: "saved") as? Data {
            let array = try! JSONDecoder().decode([Article].self, from: savedData)
            savedArticleArray = []
            savedArticleArray.append(contentsOf: array)
        }
    }

    /// Save article to either visited or saved article arrays & store via UserDefaults.
    func saveArticle(_ articleArray: ArticleArray, article: Article) {
        retrieveArticles()
        switch articleArray {
        case .visited: visitedArticleArray.insert(article, at: 0)
            if let visitedData = try? JSONEncoder().encode(visitedArticleArray) {
                defaults.set(visitedData, forKey: "visited")
            } else {
                print("Failed to save articles.")
            }

        case .saved: savedArticleArray.insert(article, at: 0)
            if let savedData = try? JSONEncoder().encode(savedArticleArray) {
                defaults.set(savedData, forKey: "saved")
            } else {
                print("Failed to save articles.")
            }
        }
    }

    ///Removes article from saved article array.
    func removeSavedArticle(article: Article) {
        retrieveArticles()
        savedArticleArray.removeAll { $0.link == article.link }
        if let data = try? JSONEncoder().encode(savedArticleArray) {
            defaults.set(data, forKey: "saved")
        } else {
            print("Failed to save articles.")
        }
    }

    ///empties either saved or visited article arrays & clears UserDefaults data.
    func clearArticles(_ articleArray: ArticleArray) {
        retrieveArticles()
        switch articleArray {
        case .visited:
            visitedArticleArray.removeAll()
            if let visitedData = try? JSONEncoder().encode(visitedArticleArray) {
                defaults.set(visitedData, forKey: "visited")
            } else {
                print("Failed to save articles.")
            }
        case .saved:
            savedArticleArray.removeAll()
            if let savedData = try? JSONEncoder().encode(savedArticleArray) {
                defaults.set(savedData, forKey: "saved")
            } else {
                print("Failed to save articles.")
            }
        }
    }

}
