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

enum topics {
    static let topicsArray = ["business", "beauty", "economics", "energy", "entertainment", "finance", "food", "gaming", "music", "politics", "science", "sport", "tech", "travel", "world"]
}

enum darkMode {
    static let device      = "Device"
    static let light       = "Light"
    static let dark        = "Dark"
    static let key = "darkMode"
}

