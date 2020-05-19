//
//  PomoTimerData.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/04/28.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation

struct PomoTimerData {
    private static let pomoTimerDataKey = "pomo_timer_data_key"
    
    var date: Date
    var donePomo: Int
    
    init(date: Date, donePomo: Int) {
        self.date = date
        self.donePomo = donePomo
    }
    
//    static func save() {
//        let dateFormat = date.dateFormat
//        UserDefaults.standard.set(self as Any, forKey: pomoTimerDataKey + )
//    }
}
