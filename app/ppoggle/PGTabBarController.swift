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
//		timerController.tabBarItem = UITabBarItem( ,tag: 0)
		timerController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home-selected-29"), tag: 0)
		settingController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "userGroup"), tag:1)
		
		
	}
}
