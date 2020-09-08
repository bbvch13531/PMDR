//
//  Utility.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/01/14.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

func checkFont() {
//   Print all fonts on project
  UIFont.familyNames.forEach {
    print($0)
    UIFont.fontNames(forFamilyName: $0).forEach {
      print("  \($0)")
    }
  }
}

enum TimerState {
  case initialized
  case running
  case paused
  case done
}

struct PGColors {
    static let red = UIColor(red:1.00, green:0.33, blue:0.31, alpha:1.0)
    static let gray = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
    static let yellow = UIColor(red:1.00, green:0.77, blue:0.38, alpha:1.0)
}

struct PGFonts {
    static let buttonTitle = UIFont(name: "SpoqaHanSans-Bold", size: 40)
    static let labelTitle = UIFont(name: "Arial", size: 25)
}
