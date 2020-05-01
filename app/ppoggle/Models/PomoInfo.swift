//
//  PomoInfo.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/02/18.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation

class PomoInfo {

  var pomoDone: [String:Int] = [String:Int]()
  
}

class PomoManager {
  static let shared = PomoManager()
  
  var pomoDone: [[String:Int]] = [[String:Int]]()
  
}
