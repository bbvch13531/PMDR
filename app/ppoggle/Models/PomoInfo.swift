//
//  PomoInfo.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/02/18.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation

struct PomoInfo: Codable {
    var date: String?
    var pomoDone: Int?
    
    init(date: String, pomoDone: Int) {
        self.date = date
        self.pomoDone = pomoDone
    }

}
