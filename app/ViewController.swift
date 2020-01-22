//
//  ViewController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 05/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let pgTabBarController = PGTabBarController()
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
//		self.present(pgTabBarController, animated: true, completion: nil)
		
		self.view.addSubview(pgTabBarController.view)
	}
}
