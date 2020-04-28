//
//  ReportController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 30/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit
import Then
import SnapKit

class ReportController: UIViewController {
  private var titleLabel = UILabel().then {
    $0.frame = CGRect(x:10, y:10, width:150, height:150)
    $0.text = "리포트"
    $0.textColor = .red
    $0.textAlignment = .center
  }
  
  private var todayLabel = UILabel().then {
    $0.frame = CGRect(x:10, y:110, width:150, height:150)
    $0.text = "오늘의 뽀글"
    $0.textColor = .red
    $0.textAlignment = .center
  }
  
  var horizontalLine_1 =  UIView().then {
    $0.frame = CGRect(x: 0, y: 100, width: 400, height: 1)
    $0.layer.borderWidth = 1
  }
  
  var horizontalLine_2 = UIView().then {
    $0.frame = CGRect(x: 0, y: 200, width: 400, height: 1)
    $0.layer.borderWidth = 1
  }
  
  var horizontalLine_3 = UIView().then {
    $0.frame = CGRect(x: 0, y: 300, width: 400, height: 1)
    $0.layer.borderWidth = 1
  }
  
	override func viewDidLoad() {
        self.view.addSubview(horizontalLine_1)
        self.view.addSubview(horizontalLine_2)
        self.view.addSubview(horizontalLine_3)
        self.view.addSubview(titleLabel)
        self.view.addSubview(todayLabel)
	}
}
