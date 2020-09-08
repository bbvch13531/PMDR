//
//  UserDefaultsManager.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/05/05.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

struct UserDefaultsManager {
    private static let standard = UserDefaults.standard
    static let currentDate = Date()
    static let calendar = Calendar.current
    
    static func update(info: PomoInfo) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(info)
            standard.set(data, forKey: info.date)
        } catch {
            print(error)
        }
    }
    
    static func loadPomoInfoOfDay(date: Date) -> PomoInfo {
        let key = date.toString()
        let decoder = JSONDecoder()
        
        if let pomoInfoData = standard.data(forKey: key) {
            do {
                let pomoInfo = try decoder.decode(PomoInfo.self, from: pomoInfoData)
                return pomoInfo
            } catch {
                print(error)
            }
        }
        
        return PomoInfo(date: key, pomoDone: 0)
    }
    
    static func loadPomoInfoOfMonths(year: Int, month: Int) -> [PomoInfo] {
        var array = [PomoInfo]()
        
        guard let startDate = Date.firstDayOfMonth(year: year, month: month) else { return array }
        let maxDayOfMonth = startDate.getDaysOfMonth()

        var date = startDate
        for _ in 0..<maxDayOfMonth {
            let pomoInfo = loadPomoInfoOfDay(date: date)
            array.append(pomoInfo)
            date = date.nextDay()
        }

        return array
    }
}

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.locale = Locale.current
        
        return formatter.string(from: self)
    }

    func getDaysOfMonth() -> Int {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        
        if month <= 0 || month > 12 {
            return -1
        }
        
        if isLeapYear() && month == 2 {
            return 29
        } else {
            return days[month - 1]
        }
    }

    func isLeapYear() -> Bool {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        
        return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
    }
    
    func nextDay() -> Date {
        let seconds = self.timeIntervalSince1970 + 60 * 60 * 24
        return Date(timeIntervalSince1970: seconds)
    }
    
    static func firstDayOfMonth(year: Int, month: Int) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        
        return formatter.date(from: "\(year)-\(month)")
    }
}

extension Date: CustomDebugStringConvertible {
    var debugDescription: String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)

        return "\(year)-\(month)-\(day)"
     }
}
