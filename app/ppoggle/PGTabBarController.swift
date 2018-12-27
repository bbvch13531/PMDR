//
//  PGTabBarController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 27/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

class PGTabBarController : UITabBarController{
	
	override func viewDidLoad() {
		let timerController = TimerController()
		let settingController = SettingController()
		self.viewControllers = [timerController,settingController]
//		self.view.backgroundColor = UIColor.red
		timerController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
		settingController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
		
		
	}
}
