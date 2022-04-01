//
//  UserDefaultsFuncs.swift
//  AussieNews
//
//  Created by Alexander Thompson on 24/3/2022.
//

import UIKit

class UserDefaultFuncs {
    
     static var visitedPagesArray = [Article]()
     static var savedPagesArray = [Article]()
     let defaults = UserDefaults.standard
    
    enum pagesArray {
        case visited
        case saved
    }
    
    init() {
        UserDefaultFuncs.visitedPagesArray = []
        UserDefaultFuncs.savedPagesArray = []
    }
}

extension UserDefaultFuncs {
    
    func retrievePages() {
            if let data = defaults.object(forKey: "visited") as? Data {
                UserDefaultFuncs.visitedPagesArray = try! JSONDecoder().decode([Article].self, from: data)
            }
        
            if let data = defaults.object(forKey: "saved") as? Data {
                UserDefaultFuncs.savedPagesArray = try! JSONDecoder().decode([Article].self, from: data)
            }
        }
    
    
    // add filter for duplicate articles
    func savePages(_ pagesArray: pagesArray, article: Article) {
        retrievePages()
        switch pagesArray {
        case .visited:
            UserDefaultFuncs.visitedPagesArray.append(article)
            if let array = try? JSONEncoder().encode(UserDefaultFuncs.visitedPagesArray) {
                defaults.set(array, forKey: "visited")
            } else {
                print("Failed to save articles.")
            }
            
        case .saved:
            UserDefaultFuncs.savedPagesArray.append(article)
            if let array = try? JSONEncoder().encode(UserDefaultFuncs.savedPagesArray) {
                defaults.set(array, forKey: "saved")
            } else {
                print("Failed to save articles.")
            }
        }
    }
    
    func removeSavedPage(article: Article) {
        retrievePages()
       
        UserDefaultFuncs.savedPagesArray.removeAll { $0.url == article.url }
        if let array = try? JSONEncoder().encode(UserDefaultFuncs.savedPagesArray) {
            defaults.set(array, forKey: "saved")
        } else {
            print("Failed to save articles.")
        }
        
    }
}
