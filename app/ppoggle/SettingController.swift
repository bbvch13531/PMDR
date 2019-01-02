//
//  SettingController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 27/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

class SettingController: UITableViewController {
//	required init?(coder aDecoder: NSCoder) {
//		super.init(nibName: nil, bundle: nil)
//	}
	
	override func viewDidLoad() {
		
	}
	
	/// view가 appear될 때마다 실행되는 함수.
	/// tableView의 data를 reload함
	/// - Parameter animated: animated: Bool
	override func viewDidAppear(_ animated: Bool) {
		self.tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		<#code#>
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		<#code#>
	}
	
}
