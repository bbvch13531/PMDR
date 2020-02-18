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
  
  var bar1 = UIView().then {
    $0.frame = CGRect(x: 50, y: 300, width: 20, height: 30)
    $0.backgroundColor = PGColors.red
  }
  
  var bar2 = UIView().then {
    $0.frame = CGRect(x: 50, y: 360, width: 20, height: 30)
    $0.backgroundColor = PGColors.yellow
  }
  
  var rect2 = UIView().then {
    $0.frame = CGRect(x: 50, y: 350, width: 200, height: 200)
    $0.backgroundColor = PGColors.red
  }
  
  var pomoInfo: PomoInfo?
  
  init(pomoInfo: PomoInfo) {
    super.init(nibName: nil, bundle: nil)
    self.pomoInfo = pomoInfo
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
	override func viewDidLoad() {
    self.view.addSubview(horizontalLine_1)
    self.view.addSubview(horizontalLine_2)
    self.view.addSubview(horizontalLine_3)
    self.view.addSubview(titleLabel)
    self.view.addSubview(todayLabel)
    self.view.addSubview(bar1)
    self.view.addSubview(bar2)
    self.view.addSubview(rect2)
    
    guard let pomoInfo = pomoInfo else { return }
    for dic in pomoInfo.pomoDone {
      print(dic)
    }
	}
  
  override func viewDidAppear(_ animated: Bool) {
    
    let options: UIView.AnimationOptions = [.curveEaseInOut]
    
    UIView.animate(withDuration: 1.0,
                             delay: 0,
                             options: options,
                             animations: { [weak self] in
                              self?.bar1.frame.size.width *= 10.0
    //                          self?.bar2.frame.size.width *= 7.0
                }, completion: nil)
//    UIView.animate(withDuration: 0.5,
//                     delay: 0,
//                     options: options,
//                     animations: { [weak self] in
//    //                  self?.bar1.frame.size.width *= 10.0
//                      self?.bar2.frame.size.width *= 10.0
//        }, completion: nil)
//
    bar1.transform = CGAffineTransform(scaleX: 1, y: 10)
    bar2.transform = CGAffineTransform(scaleX: 1, y: 100)
        
    rect2.transform = CGAffineTransform(scaleX: 0, y: 1)

    UIView.animate(withDuration: 1, animations: {
      self.rect2.transform = .identity
      self.bar1.transform = .identity
      self.bar2.transform = .identity
    }, completion: nil)
  }
}
