//
//  Constants.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

enum socialMedia {
    
    static let socialImageArray = ["appNerdIcon", "appNerdIcon", "GitHub", "linkedIn", "Instagram"]
    static let socialTextArray  = ["Send Feedback", "Website", "GitHub", "LinkedIn", "Instagram"]
    
    static let websiteURL           = "appNerd.com.au"
    
    static let linkedInUsername     = "Alexander-Thompson-847a6486"
    static let linkedInURL          = "https://www.linkedin.com/in/\(socialMedia.linkedInUsername)"
    
    static let instagramUsername    = "AlexThompsonDevelopment"
    static let instagramURL         = "https://instagram.com/\(socialMedia.instagramUsername)"
    
    static let githubUsername       = "AlexThompsonDevelopment"
    static let githubURL            = "https://github.com/\(socialMedia.githubUsername)"
    
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
    static let segmentArray = ["Device", "Light Theme", "Dark Theme"]
    static let device      = "Device"
    static let light       = "Light"
    static let dark        = "Dark"
    static let key         = "darkMode"
}

enum emptyStateConstant {
    static let searchImage = UIImage(systemName: "magnifyingglass")
    static let searchTitle = "No Search Results"
    static let searchSecondary = """
            There are no search results here.
            Use the text field above to search.
            """
    
    static let savedImage = UIImage(systemName: "bookmark")
    static let savedTitle = "No Saved Content"
    static let savedSecondary = """
            Looks like you havent saved anything yet.
            Tap on bookmark to start saving content.
            """
    
    static let visitedImage = UIImage(systemName: "list.bullet.rectangle.portrait")
    static let visitedTitle = "No Visited Pages"
    static let visitedSecondary = """
            Looks like you havent ready any articles yet.
            Read some news articles to fill this list.
            """
}

enum settings {
    static let iconImage = UIImage(named: "appNerdIcon")
    static let footerText = """
Aussie News
App made with 🤍 by
Alex Thompson
"""
}

enum images {
    static let bookMarkFill = UIImage(systemName: "bookmark.fill")
    static let bookmark = UIImage(systemName: "bookmark")
    static let placeholder = UIImage(named: "placeholder")
    static let link = UIImage(systemName: "link")
}

enum saveLabelText {
    static let saveMain = "Saved"
    static let saveSecond = "You can find this story in bookmarks"
    
    static let removingMain = "Removed"
    static let removingSecond = "This story has been removed from bookmarks"
    
    static let copiedMain = "Copied"
    static let copiedSecond = "Article copied & can now be shared"
}

enum color {
    static let aussieGreen = UIColor(red: 0.00, green: 0.52, blue: 0.24, alpha: 1.00)
}
