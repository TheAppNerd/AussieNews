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
    let title: String?
        let author: String?
        let published_date: String?
        let link: String?
        let excerpt: String?
        let summary: String?
        let rights: String?
        let topic: String?
        let country: String?
        let language: String?
        let media: String?
    }


