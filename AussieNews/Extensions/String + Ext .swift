//
//  String + Ext .swift
//  AussieNews
//
//  Created by Alexander Thompson on 31/5/2022.
//

import UIKit

extension String {

    func convertStringToDate(dateStr: String) -> Date {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date           = dateFormatter.date(from: dateStr) else { return Date() }
        return date
    }

    /// Takes a date string, converts it to Date, determines the amount of time between that date and now and presents it in a simple format.
    func timeSinceDate() -> String {
        let date             = convertStringToDate(dateStr: self)
        let formatter        = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate     = formatter.localizedString(for: date, relativeTo: Date())
        return relativeDate
    }

}
