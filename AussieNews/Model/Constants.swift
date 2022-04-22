//
//  Constants.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import Foundation

enum SocialMedia {
    
    static let websiteURL           = "appNerd.com.au"
    
    static let linkedInUsername     = "Alexander-Thompson-847a6486"
    static let linkedInURL          = "https://www.linkedin.com/in/\(SocialMedia.linkedInUsername)"
    
    static let instagramUsername    = "AlexThompsonDevelopment"
    static let instagramURL         = "https://instagram.com/\(SocialMedia.instagramUsername)"
    
    static let githubUsername       = "AlexThompsonDevelopment"
    static let githubURL            = "https://github.com/\(SocialMedia.githubUsername)"
    
    static let emailAddress         = "Alex@appNerd.com.au"
    static let emailHeader          = "Aussie News Feedback"
}

enum articleArray {
    case visited
    case saved
}

enum emptyState {
    case search
    case saved
    case visited
}

enum topics: String, CaseIterable {
    case business      = "business"
    case beauty        = "beauty"
    case economics     = "economics"
    case energy        = "energy"
    case entertainment = "entertainment"
    case finance       = "finance"
    case food          = "food"
    case gaming        = "gaming"
    case music         = "music"
    case politics      = "politics"
    case science       = "science"
    case sport         = "sport"
    case tech          = "tech"
    case travel        = "travel"
    case world         = "world"
}

