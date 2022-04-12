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
