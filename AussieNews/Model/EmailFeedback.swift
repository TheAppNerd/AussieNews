//
//  EmailFeedback.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

struct EmailFeedback {
    
    
    ///Method to open users main email app to send feedback to me personally.
    ///Utilises UI device to determine current system version to provide me with more in depth information when feedback is provided.
    func newEmail() {
        let address           = SocialMedia.emailAddress
        let subject           = SocialMedia.emailHeader
        
        let appVersion        = UIApplication.appVersion
        let systemVersion     = UIDevice.current.systemVersion
        let locale            = Locale.current
        let modelNumber       = UIDevice().modelIdentifier()
        
        let body              = """



Aussie News Version: \(appVersion ?? "Unable to Locate")
iOS Version: \(systemVersion)
Device: \(modelNumber)
Location: \(locale)

"""
        
        var components        = URLComponents()
        components.scheme     = "mailto"
        components.path       = address
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]
        
        guard let url = components.url else {
            print("Failed to create mailto URL")
            return
        }
        UIApplication.shared.open(url)
    }
}

