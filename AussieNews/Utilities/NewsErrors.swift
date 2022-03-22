//
//  NewsErrors.swift
//  AussieNews
//
//  Created by Alexander Thompson on 22/3/2022.
//

import UIKit


enum NewsErrors: String, Error {
  
    case urlError = "URL Error"
    case responseError = "Response Error"
    case decodeError = "Failed to decode"
    
    
}
