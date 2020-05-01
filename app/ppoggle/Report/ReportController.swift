//
//  ReportController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 30/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ReportController: UIViewController {
  
    var pomoInfo: PomoInfo?
  
    init(pomoInfo: PomoInfo) {
        super.init(nibName: nil, bundle: nil)
        self.pomoInfo = pomoInfo
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
	override func viewDidLoad() {
        guard let pomoInfo = pomoInfo else { return }
        
        for dic in pomoInfo.pomoDone {
            print(dic)
        }
	}
  
    override func viewDidAppear(_ animated: Bool) {
    
    let options: UIView.AnimationOptions = [.curveEaseInOut]
        
    }
}
