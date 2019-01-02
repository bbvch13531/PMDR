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
	var tableView: UITableView = UITableView()
	
	lazy var list:[String] = {
		var titleData = [String]()
		return titleData
	}()
	
	
	/// view가 appear될 때마다 실행되는 함수.
	/// tableView의 data를 reload함
	/// - Parameter animated: animated: Bool
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let screenSize = UIScreen.main.bounds
		let screenWidth = screenSize.size.width
		let screenHeight = screenSize.size.height
		
		tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
		
		self.view.addSubview(tableView)
		
		let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
		footerView.backgroundColor = UIColor.green
		tableView.tableFooterView = footerView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
//		cell.settingName = "test"
//
//		var sbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//		sbtn.setTitle(">", for: .normal)
//
//		cell.settingBtn = sbtn
//		NSLog("indexPath.row = %d, cell.name = %s",indexPath.row, cell.settingName)
		
		for title in self.list {
			cell.textLabel!.text = self.list[indexPath.row]
		}
		return cell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func setUpList(){
		let titleArr = ["프로필 수정","알림","서비스 약관","개인정보 처리방침","로그아웃","탈퇴하기"]
		
		for title in titleArr {
			self.list.append(title)
		}
		
	}
}
