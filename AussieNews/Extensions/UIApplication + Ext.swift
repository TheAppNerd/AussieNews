//
//  UIApplication + Ext.swift
//  AussieNews
//
//  Created by Alexander Thompson on 8/4/2022.
//

import UIKit

extension UIApplication {
    
    ///Returns current app version which is included in feedback email to help with feedback.
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
