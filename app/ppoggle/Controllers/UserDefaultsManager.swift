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
//    var currentDate: String {
//        get {
//            let date = Date()
//            let calendar = Calendar.current
//            let year = calendar.component(.year, from: date)
//            let month = calendar.component(.month, from: date)
//            let day = calendar.component(.day, from: date)
//
//            return "\(year)-\(month)-\(day)"
//        }
//    }
    
    static func update(info: PomoInfo) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(info)
            standard.set(data, forKey: info.date)
        } catch {
            print(error)
        }
    }
    
    static func loadPomoOfDays() -> [PomoInfo] {
        var array = [PomoInfo]()
        let decoder = JSONDecoder()
        
        var date = currentDate
        
        for i in 0..<30 {
            if let pomoInfoData = standard.data(forKey: date.toString()) {
                do {
                    let pomoInfo = try decoder.decode(PomoInfo.self, from: pomoInfoData)
                    array.append(pomoInfo)
                } catch {
                    print(error)
                }
            } else {
                array.append(PomoInfo(date: date.toString(), pomoDone: 0))
            }
            
            date = prevDate(date: date)!
        }
        array.reverse()
        
        return array
    }
    
    static func nextDate(date: Date) -> Date? {
        
        let dayComponent = calendar.dateComponents([.hour], from: date)
        return calendar.nextDate(after: date, matching: dayComponent, matchingPolicy: .nextTime)
        
    }
    static func prevDate(date: Date) -> Date? {
            let dayComponent = calendar.dateComponents([.hour,], from: date)
         return calendar.nextDate(after: date, matching: dayComponent, matchingPolicy: .nextTime, direction: .backward)
    }
}

extension Date {
    func toString() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)

        return "\(year)-\(month)-\(day)"
    }
}
