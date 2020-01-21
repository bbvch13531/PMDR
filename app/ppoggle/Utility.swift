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
