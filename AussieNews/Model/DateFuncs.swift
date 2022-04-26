//
//  DateFuncs.swift
//  AussieNews
//
//  Created by Alexander Thompson on 26/4/2022.
//

import UIKit

struct DateFuncs {
    
    func convertStringToDate(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    ///Takes a date string, converts it to Date, determines the amount of time between that date and now and presents it in a simple format.
    func timeSinceDate(dateStr: String) -> String {
        let date = convertStringToDate(dateStr: dateStr)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
        return relativeDate
    }
    
}
