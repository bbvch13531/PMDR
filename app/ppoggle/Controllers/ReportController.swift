//
//  ReportController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 30/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

class ReportController: UIViewController {
  private var titleLabel: UILabel!
  var horizontalLine_1: UIView!
  var horizontalLine_2: UIView!
  var horizontalLine_3: UIView!
  
	override func viewDidLoad() {
    setUpBtns()
	}
  
  func setUpBtns() {
    titleLabel = UILabel(frame: CGRect(x:10, y:10, width:150, height:150))
    titleLabel.text = "리포트"
    titleLabel.textColor = .red
    titleLabel.textAlignment = .center
    
    horizontalLine_1 = UIView(frame: CGRect(x: 0, y: 100, width: 300, height: 1))
    horizontalLine_2 = UIView(frame: CGRect(x: 0, y: 200, width: 300, height: 1))
    horizontalLine_3 = UIView(frame: CGRect(x: 0, y: 300, width: 300, height: 1))
    
    horizontalLine_1.layer.borderWidth = 1
    horizontalLine_2.layer.borderWidth = 1
    horizontalLine_3.layer.borderWidth = 1
    
    self.view.addSubview(horizontalLine_1)
    self.view.addSubview(horizontalLine_2)
    self.view.addSubview(horizontalLine_3)
    self.view.addSubview(titleLabel)
  }
  
}
