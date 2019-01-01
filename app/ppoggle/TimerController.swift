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
	// Pomo timer
	var timer = Timer()
	
	var startBtn : UIButton!
	var pauseBtn : UIButton!
	var resetBtn : UIButton!
	var completedPomoLabel : UILabel!
	var timerLabel : UILabel!
	
	var minutes : Int = 25
	var seconds : Int = 0
	
	var pomoMin : Int = 25
	var breakMin : Int = 5
	
	let myRed = UIColor(red:1.00, green:0.33, blue:0.31, alpha:1.0)
	let myGray = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
	let myYellow = UIColor(red:1.00, green:0.77, blue:0.38, alpha:1.0)
	
	
	var isPomoTimerRunning = false
	
	override func viewDidLoad() {
		
		// Set up UI

		setUpProgressRing()
		setUpBtns()
		setUpLabels()
		
		// Print all fonts on project
//		UIFont.familyNames.forEach {
//			print($0)
//			UIFont.fontNames(forFamilyName: $0).forEach {
//				print("  \($0)")
//			}
//		}
		
	}
	private func setUpNavigationBar(){
		
		// Safearea screen size
		let screenRect = UIScreen.main.bounds
		let screenWidth = screenRect.size.width
		let screenHeight = screenRect.size.height
		
		
	}
	private func setUpProgressRing(){
		
		
		progressRing.backgroundColor = .white
		progressRing.outerRingColor = myGray
		
		progressRing.outerRingWidth = 25
		
		progressRing.startAngle = 270
		progressRing.innerRingWidth = 25
		progressRing.ringStyle = .ontop
		progressRing.shouldShowValueText = false
//		progressRing.valueIndicator = "min"
		
		progressRing.animationStyle = CAMediaTimingFunctionName.linear.rawValue
		
		progressRing.font = UIFont.boldSystemFont(ofSize: 40)

		self.view.addSubview(progressRing)
	}
	private func setUpBtns(){
		self.startBtn = UIButton(frame: CGRect(x: 40, y: 550, width: 150, height: 70))
		startBtn.setTitle("start", for: .normal)
		startBtn.backgroundColor = myRed
		startBtn.layer.cornerRadius = 15
		startBtn.titleLabel?.font = UIFont(name: "SpoqaHanSans-Bold", size: 40)
		
		self.pauseBtn = UIButton(frame: CGRect(x: 40, y: 550, width: 150, height: 70))
		pauseBtn.setTitle("pause", for: .normal)
		pauseBtn.backgroundColor = myRed
		pauseBtn.layer.cornerRadius = 15
		pauseBtn.titleLabel?.font = UIFont(name: "SpoqaHanSans-Bold", size: 40)
		pauseBtn.isHidden = true
		
		self.resetBtn = UIButton(frame: CGRect(x: 200, y: 550, width: 150, height: 70))
		resetBtn.setTitle("reset", for: .normal)
		resetBtn.backgroundColor = myRed
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
		timerLabel = UILabel(frame: CGRect(x: 140, y: 350, width: 200, height: 50))
		timerLabel.text = "\(minutes ?? 25):00"
		timerLabel.font = UIFont(name: "SpoqaHanSans-Bold", size: 40)
		completedPomoLabel = UILabel(frame: CGRect(x: 120, y: 160, width: 200, height: 50))
		completedPomoLabel.text = "Today : "
		
		self.view.addSubview(timerLabel)
		self.view.addSubview(completedPomoLabel)
	}
	
	// MARK: Start trigger PomoTimer.
	func startPomoTimer(){
		self.progressRing.innerRingColor = self.myRed
		self.progressRing.maxValue = 25*60

		NSLog("isPomoTimerRunning = \(self.isPomoTimerRunning) before reset, at StartPomoTimer")
		
//		NSLog("progressRing.value = \(self.progressRing.currentValue) after reset, at StartPomoTimer")
		
		if isPomoTimerRunning == true {
			// Start timer start
			self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
			// Start progressRing animation start
			self.progressRing.startProgress(to: 25*60, duration: 10){
				print("Done!!")
				// When progress complete, set timer running false
				
				self.finishProgress()
				self.isPomoTimerRunning = false
	//			self.progressRing.resetProgress()
				
				self.pauseBtn.isHidden = true
				
				// Show up alert
				let alert = UIAlertController(title: "ppoggle completed", message: "Time to rest", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
					NSLog("The \"OK\" alert occured.")
				}))
				self.present(alert, animated: true, completion: nil)
				
			}
		}
	}
	func startBreakTimer(){
		
		self.progressRing.innerRingColor = self.myYellow
		self.progressRing.maxValue = 5*60
		self.progressRing.value = 0
		NSLog("isPomoTimerRunning = \(self.isPomoTimerRunning) before reset, at StartBreakTimer")
		
		// When resetBtn is not clicked
//		if isPomoTimerRunning == true {
		
			self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
			NSLog("progressRing.value = \(self.progressRing.currentValue) after reset, at StartBreakTimer")
			self.progressRing.startProgress(to: 5*60, duration: 10){
				print("Done!!")
				// When progress complete, set timer running false
				
				self.startBtn.isHidden = true
				self.pauseBtn.isHidden = false
				
				self.finishProgress()
				self.isPomoTimerRunning = true
				
				// Show up alert
				let alert = UIAlertController(title: "Break finished", message: "Time to focus on", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
					NSLog("The \"OK\" alert occured.")
				}))
				self.present(alert, animated: true, completion: nil)
				
			}
//		}
		// else : When resetBtn is clicked
	}
	@objc func updateTimer(){
		if seconds == 0 {
			minutes -= 1
			// 60으로 해야함. 테스트로 5초까지만 설정.
			seconds = 9
		} else {
			seconds -= 1
		}
		// TimerLabel text update every seconds
		self.timerLabel.text = "\(minutes):\(String(format: "%02d", seconds))"
	}
	func finishProgress(){
		self.minutes = 25
		self.seconds = 0
		
		// When progress finish, check isPomoTimerRunning and start timer
		self.timer.invalidate()
		if isPomoTimerRunning {
			self.progressRing.startProgress(to: 0, duration: 0,completion: {
				self.startBreakTimer()
			})
		} else {
			self.progressRing.startProgress(to: 0, duration: 0,completion: {
				self.startPomoTimer()
			})
		}
		
	}
	func pausePomoTimer(){
		
	}
	@objc func startBtnClick(_ sender: UIButton?){
		// Set Timer running true
		self.isPomoTimerRunning = true
		startBtn.isHidden = true
		pauseBtn.isHidden = false
		startPomoTimer()
		
	}
	
	@objc func pauseBtnClick(_ sender: UIButton?){
		
		if self.isPomoTimerRunning == true{
			self.isPomoTimerRunning = false
			timer.invalidate()
			
			self.progressRing.pauseProgress()
		} else {
			self.isPomoTimerRunning = true
			
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
			self.progressRing.continueProgress()
		}
	}
	
	@objc func resetBtnClick(_ sender: UIButton?){
		isPomoTimerRunning = false
		
		
		print("resetBtnClicked")
		// Animation stop
		self.progressRing.startProgress(to: 0, duration: 0,completion: {
			self.progressRing.resetProgress()
			
			// Timer invalidate
			self.timer.invalidate()
		})
		
	}
	
}
