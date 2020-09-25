//
//  DateHelper.swift
//  iOSArchitecturesDemo
//
//  Created by Igor Ivanov on 24.09.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation


class DateHelper {
    
    static func stringToDate(strDate: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from:strDate)!
        return date
    }
    
    static func getSimpleStrDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}
