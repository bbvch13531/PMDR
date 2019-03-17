//
//  SettingController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 27/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

class SettingController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//	required init?(coder aDecoder: NSCoder) {
//		super.init(nibName: nil, bundle: nil)
//	}
	var tableView = UITableView()
	var navBar = UINavigationBar()
	
	lazy var list:[String] = {
		var titleData = [String]()
		return titleData
	}()
	
	var sectionList =  [[String]]()
	
	let screenSize = UIScreen.main.bounds
	let screenWidth = UIScreen.main.bounds.size.width
	let screenHeight = UIScreen.main.bounds.size.height
	
	/// view가 appear될 때마다 실행되는 함수.
	/// tableView의 data를 reload함
	/// - Parameter animated: animated: Bool
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		
		
		// 이 부분 코드 리팩토링해야함. Nav bar 과 tableView 같이 쓰는 더 나은 방법 찾아보자.
		let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 10))
		let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 1))

		tableView.tableFooterView = footerView
		tableView.tableHeaderView = headerView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.frame = CGRect(x: 0, y: 50, width: screenWidth, height: screenHeight)
		tableView.delegate = self
		tableView.dataSource = self
		//		tableView.style =
		tableView.register(SettingCustomCell.self, forCellReuseIdentifier: "settingCustomCell")
		
		self.view.addSubview(tableView)
		
		// NavigationBar의 size 는 항상 고정. Safe area 부터 적용해야함.
		navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenWidth, height: 0))
		navBar.tintColor = .lightGray
		
		var navTitle = UINavigationItem(title: "설정")
		
		navBar.items = [navTitle]
		
		self.view.addSubview(navBar)
		
		self.setUpList()
//		DispatchQueue.global().async{
//			defer{
//				DispatchQueue.main.async {
//					self.tableView.reloadData()
//				}
//			}
//			do{
//				// 리스트 초기화
//				self.setUpList()
//			}catch{
//				print(error.localizedDescription)
//			}
//		}
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let row = self.list[indexPath.row]
		
		var customCell = SettingCustomCell()
		var rowList = self.sectionList[indexPath.section]
		print("rowList[0] = \(rowList[0]), section = \(indexPath.section), row = \(indexPath.row)")
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "settingCustomCell", for: indexPath) as? SettingCustomCell {
			customCell = cell
			customCell.textLabel!.text = rowList[indexPath.row]
			
			return customCell
		} else {
			print("Cannot casting to SettingCustomCell")
		}
//		let cell = tableView.dequeueReusableCell(withIdentifier: "settingCustomCell", for: indexPath) as! SettingCustomCell
//		cell.settingName = "test"
//
//		var sbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//		sbtn.setTitle(">", for: .normal)
//
//		cell.settingBtn = sbtn
//		NSLog("indexPath.row = %d, cell.name = %s",indexPath.row, cell.settingName)
		
		return customCell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 60))
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
		
		view.backgroundColor = .lightGray
		label.textColor = .black
		var sectionTitle: String
		switch section {
		case 0:
			sectionTitle = ""
			break;
		case 1:
			sectionTitle = "서비스 설정"
			break;
		case 2:
			sectionTitle = "고객지원"
			break;
		case 3:
			sectionTitle = "계정설정"
			break;
		default:
			sectionTitle = ""
		}
		
		label.text = sectionTitle
		view.addSubview(label)
		return view
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else if section == 1 {
			return 1
		} else if section == 2 {
			return 2
		} else if section == 3 {
			return 2
		} else {
			return 0
		}
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 4
	}
	func setUpList(){
//		let section0 = ["프로필 수정"]
//		let sectoin1 = ["알림"]
//		let sectoin2 = ["서비스 약관","개인정보 처리방침"]
//		let section3 = ["로그아웃","탈퇴하기"]
//		titleArr = ["프로필 수정","알림","서비스 약관","개인정보 처리방침","로그아웃","탈퇴하기"]
		
		self.sectionList.append(["프로필 수정"])
		self.sectionList.append(["알림"])
		self.sectionList.append(["서비스 약관","개인정보 처리방침"])
		self.sectionList.append(["로그아웃","탈퇴하기"])
//		for title in titleArr {
//			self.list.append(title)
//		}
		
	}
}
