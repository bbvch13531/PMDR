//
//  SettingCustomCell.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 02/01/2019.
//  Copyright © 2019 KyungYoung Heo. All rights reserved.
//

import UIKit
class SettingCustomCell: UITableViewCell{
	var settingName: String!
	weak var settingSwitch: UISwitch?
	weak var settingBtn: UIButton?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
