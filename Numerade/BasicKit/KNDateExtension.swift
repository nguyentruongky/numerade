//
//  DateExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

extension Date {
    var timeAgo: String {
        let now = Date()
        let components = Calendar.current.dateComponents(
            [.year, .month, .weekOfYear, .day, .hour, .minute, .second],
            from: self,
            to: now
        )
        
        if let years = components.year, years > 0 {
            return "\(years) year\(years == 1 ? "" : "s") ago"
        }
        
        if let months = components.month, months > 0 {
            return "\(months) month\(months == 1 ? "" : "s") ago"
        }
        
        if let weeks = components.weekOfYear, weeks > 0 {
            return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
        }
        if let days = components.day, days > 0 {
            guard days > 1 else { return "yesterday" }
            
            return "\(days) day\(days == 1 ? "" : "s") ago"
        }
        
        if let hours = components.hour, hours > 0 {
            return "\(hours) hour\(hours == 1 ? "" : "s") ago"
        }
        
        if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
        }
        
        if let seconds = components.second, seconds > 30 {
            return "\(seconds) second\(seconds == 1 ? "" : "s") ago"
        }
        
        return "just now"
    }

    static func dateFrom(year: Int = 1970, month: Int = 1, day: Int = 1,
                         hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        var component = DateComponents()
        component.year = year
        component.month = month
        component.day = day
        component.hour = hour
        component.minute = minute
        component.second = second
        component.timeZone = TimeZone(abbreviation: "UTC")
        return Calendar.current.date(from: component)!
    }

    init(dateString: String, format: String, locale: Locale = Locale(identifier: "en_US_POSIX")) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = format
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        
        let d = dateFormatter.date(from: dateString)
        self.init(timeInterval:0, since:d!)
    }
    
    init(iso8601String: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        
        var d = dateFormatter.date(from: iso8601String)
        
        if d == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        d = dateFormatter.date(from: iso8601String)
        
        self.init(timeInterval:0, since:d!)
    }

    func toString(_ format: String = "MM/dd/yyyy",
                  locale: Locale = Locale(identifier: "en_US_POSIX")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func toISO8601String() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.calendar =  Calendar(identifier: Calendar.Identifier.iso8601)
        return dateFormatter.string(from: self) + "Z"
    }

    static var ISO8601Format: String {
        return "yyyy-MM-dd'T'HH:mm:ss.SSS"
    }

    func toLocalTime() -> Date {
        let localString = toCurrentTimezoneString(format: Date.ISO8601Format)
        return Date(iso8601String: localString)
    }

    func toCurrentTimezoneString(format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
