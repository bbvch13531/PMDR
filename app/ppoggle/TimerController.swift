//
//  TimerController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 27/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit
import UICircularProgressRing


class TimerController:UIViewController{
	
	// frame to make progressRing
	var frame : CGRect{
		get{
			return CGRect(x: 45, y: 230, width: 300, height: 300)
		}
	}
	
	// Using lazy var
	lazy var progressRing = UICircularProgressRing(frame: frame)
	var startBtn: UIButton!
	var pauseBtn: UIButton!
	var resetBtn: UIButton!
	var completedPomoLabel: UILabel!
	
	var isTimerRunning = false
	override func viewDidLoad() {
		
		// Set up UI
		setUpNavigationBar()
		setUpProgressRing()
		setUpBtns()
		setUpLabels()
		UIFont.familyNames.forEach {
			print($0)
			UIFont.fontNames(forFamilyName: $0).forEach {
				print("  \($0)")
			}
		}
		
	}
	private func setUpNavigationBar(){
		
		// Safearea screen size
		let screenRect = UIScreen.main.bounds
		let screenWidth = screenRect.size.width
		let screenHeight = screenRect.size.height
		
		// make Navi bar and add
		let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: screenWidth, height: 44))
		self.view.addSubview(navBar)
		
		let navItem = UINavigationItem(title: "Timer")
//		let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
//		navItem.leftBarButtonItem = doneItem
		
		navBar.setItems([navItem], animated: false)
		
	}
	private func setUpProgressRing(){
		let myRed = UIColor(red:1.00, green:0.33, blue:0.31, alpha:1.0)
		let myGray = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
		let myYellow = UIColor(red:1.00, green:0.77, blue:0.38, alpha:1.0)
		
		progressRing.backgroundColor = .white
		progressRing.outerRingColor = myGray
		progressRing.innerRingColor = myRed
		progressRing.outerRingWidth = 25
		progressRing.maxValue = 60
		progressRing.startAngle = 270
		progressRing.innerRingWidth = 25
		progressRing.ringStyle = .ontop
		progressRing.valueIndicator = "min"
		progressRing.font = UIFont.boldSystemFont(ofSize: 40)

		self.view.addSubview(progressRing)
	}
	private func setUpBtns(){
		self.startBtn = UIButton(frame: CGRect(x: 40, y: 550, width: 150, height: 70))
		startBtn.setTitle("start", for: .normal)
		startBtn.backgroundColor = .orange
		startBtn.layer.cornerRadius = 15
		startBtn.titleLabel?.font = UIFont(name: "SpoqaHanSans-Bold", size: 40)
		
		self.pauseBtn = UIButton(frame: CGRect(x: 40, y: 550, width: 150, height: 70))
		pauseBtn.setTitle("pause", for: .normal)
		pauseBtn.backgroundColor = .orange
		pauseBtn.layer.cornerRadius = 15
		pauseBtn.titleLabel?.font = UIFont(name: "SpoqaHanSans-Bold", size: 40)
		pauseBtn.isHidden = true
		
		self.resetBtn = UIButton(frame: CGRect(x: 200, y: 550, width: 150, height: 70))
		resetBtn.setTitle("reset", for: .normal)
		resetBtn.backgroundColor = .orange
		resetBtn.layer.cornerRadius = 15
		resetBtn.titleLabel?.font = UIFont(name: "SpoqaHanSans-Bold", size: 40)
		
		self.view.addSubview(startBtn)
		self.view.addSubview(pauseBtn)
		self.view.addSubview(resetBtn)
		startBtn.addTarget(self, action: #selector(self.startBtnClick), for: .touchDown)
		pauseBtn.addTarget(self, action: #selector(self.pauseBtnClick), for: .touchDown)
		resetBtn.addTarget(self, action: #selector(self.resetBtnClick), for: .touchDown)
	}
	private func setUpLabels(){
		completedPomoLabel = UILabel(frame: CGRect(x: 120, y: 160, width: 200, height: 50))
		completedPomoLabel.text = "오늘 완료한 뽀모도로"
		self.view.addSubview(completedPomoLabel)
	}
	@objc func startBtnClick(_ sender: UIButton?){
		// Set Timer running true
		self.isTimerRunning = true
		startBtn.isHidden = true
		pauseBtn.isHidden = false
		self.progressRing.startProgress(to: 60, duration: 2){
			print("Done!!")
			// When progress complete, set timer running false
			self.isTimerRunning = false
			self.startBtn.isHidden = false
			self.pauseBtn.isHidden = true
			
			// Show up alert
			let alert = UIAlertController(title: "뽀모도로 1개 완성!", message: "5분의 휴식을 즐기세요.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
				NSLog("The \"OK\" alert occured.")
			}))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	@objc func pauseBtnClick(_ sender: UIButton?){
		if self.isTimerRunning == true{
			self.isTimerRunning = false
			startBtn.isHidden = true
			pauseBtn.isHidden = false
			self.progressRing.pauseProgress()
		} else {
			self.isTimerRunning = true
			self.progressRing.continueProgress()
		}
	}
	@objc func resetBtnClick(_ sender: UIButton?){
		isTimerRunning = false
		self.progressRing.resetProgress()
	}
}
