//
//  String+DateParsing.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/7.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formats = ["yyyy/MM/dd", "yyyyMMdd"]
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: self) {
                return date
            }
        }
        return nil
    }
}

