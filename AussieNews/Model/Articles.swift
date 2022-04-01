//
//  NewsArticle.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import Foundation

struct Articles: Codable {
    
    let articles: [Article]
}

struct Article: Codable, Hashable {
        let author: String?
        let title: String?
        let description: String?
        let content: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let source: Source?
    }

    
struct Source: Codable, Hashable {
        let name: String?
}


