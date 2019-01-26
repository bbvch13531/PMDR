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
		let mypomoController = MypomoController()
		let reportController = ReportController()
		let userGroupController = UserGroupController()
		let settingController = SettingController()
		
		self.viewControllers = [timerController,mypomoController,reportController,userGroupController,settingController]
//		self.view.backgroundColor = UIColor.red
//		timerController.tabBarItem = UITabBarItem( ,tag: 0)
		timerController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), tag: 0)
		mypomoController.tabBarItem = UITabBarItem(title: "내 뽀모도로", image: UIImage(named:"document"), tag: 1)
		reportController.tabBarItem = UITabBarItem(title: "리포트", image: UIImage(named: "asending-arrow"), tag: 2)
		userGroupController.tabBarItem = UITabBarItem(title: "함께하기", image: UIImage(named: "userGroup"), tag: 3)
		settingController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "setting"), tag:4)
		
	}
}
