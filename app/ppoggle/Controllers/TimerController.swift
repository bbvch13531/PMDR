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
import Then
import SnapKit

class TimerController: UIViewController {
	
  var progressRing = UICircularProgressRing().then {
      $0.frame = CGRect(x: 45, y: 230, width: 300, height: 300)
      $0.backgroundColor = .white
      $0.outerRingColor = PGColors.gray
      $0.outerRingWidth = 25
      $0.startAngle = 270
      $0.innerRingWidth = 25
      $0.ringStyle = .ontop
      $0.shouldShowValueText = false
      $0.animationStyle = CAMediaTimingFunctionName.linear.rawValue
      $0.font = UIFont.boldSystemFont(ofSize: 40)
  }
    
  // Pomo timer
  var timer = Timer()
  
  var timerState = TimerState.initialized

  var startBtn = UIButton().then {
      $0.frame = CGRect(x: 40, y: 550, width: 150, height: 70)
      $0.setTitle("start", for: .normal)
      $0.backgroundColor = PGColors.red
      $0.layer.cornerRadius = 15
      $0.titleLabel?.font = PGFonts.buttonTitle
  }
  
  var pauseBtn = UIButton().then {
      $0.frame = CGRect(x: 40, y: 550, width: 150, height: 70)
      $0.setTitle("pause", for: .normal)
      $0.backgroundColor = PGColors.red
      $0.layer.cornerRadius = 15
      $0.titleLabel?.font = PGFonts.buttonTitle
      $0.isHidden = true
  }
  
  var resetBtn = UIButton().then {
      $0.frame = CGRect(x: 200, y: 550, width: 150, height: 70)
      $0.setTitle("reset", for: .normal)
      $0.backgroundColor = PGColors.red
      $0.layer.cornerRadius = 15
      $0.titleLabel?.font = PGFonts.buttonTitle
  }
  
  var completedPomoLabel = UILabel().then {
      $0.frame = CGRect(x: 120, y: 160, width: 200, height: 50)
      $0.font = PGFonts.labelTitle
      $0.text = "Today : 0 / 20"
  }
  
  var timerLabel = UILabel().then {
      $0.frame = CGRect(x: 140, y: 350, width: 200, height: 50)
      $0.font = PGFonts.buttonTitle
      $0.text = "00:00"
      $0.textColor = .black
  }

	// State of current timer
	var minutes: Int = 25
	var seconds: Int = 0
	
	// Default value of duration of timer
	var pomoMin: Int = 25
	var breakMin: Int = 5
	
	var targetPomo: Int = 20
	var donePomo: Int = 0
	
	var isPomoTimerRunning = false
	var isReset = false
	
  var manager: PomoManager?
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(manager: PomoManager) {
    super.init(nibName: nil, bundle: nil)
    self.manager = manager
  }
  
	override func viewDidLoad() {
		// Set up UI

//    guard var pomoInfo = pomoInfo else { return }
    
    let data = ["asd":3]
    PomoManager.shared.pomoDone.append(data)
    self.view.addSubview(startBtn)
    self.view.addSubview(pauseBtn)
    self.view.addSubview(resetBtn)
    
    startBtn.titleLabel?.font = PGFonts.buttonTitle
    startBtn.addTarget(self, action: #selector(self.startBtnClick), for: .touchDown)
    pauseBtn.addTarget(self, action: #selector(self.pauseBtnClick), for: .touchDown)
    resetBtn.addTarget(self, action: #selector(self.resetBtnClick), for: .touchDown)
    
    self.view.addSubview(progressRing)
    self.view.addSubview(timerLabel)
    self.view.addSubview(completedPomoLabel)
        

//    Check installed font
//        checkFont()

	}
  
	override func viewWillDisappear(_ animated: Bool) {
		self.isPomoTimerRunning = false
		timer.invalidate()
	}
  
	private func setUpNavigationBar() {
		// Safearea screen size
		let screenRect = UIScreen.main.bounds
		let screenWidth = screenRect.size.width
		let screenHeight = screenRect.size.height
		
	}

	// MARK: Start trigger PomoTimer.
	func startPomoTimer() {
        self.progressRing.innerRingColor = PGColors.red
		self.progressRing.maxValue = 25 * 60
    
    #if DEBUG
		NSLog("isPomoTimerRunning = \(self.isPomoTimerRunning) before reset, at StartPomoTimer")
    NSLog("progressRing.value = \(String(describing: self.progressRing.currentValue)) after reset, at StartPomoTimer")
		NSLog("progressRing.value = \(self.progressRing.currentValue) after reset, at StartPomoTimer")
    #endif
    

    switch timerState {
    case .paused:
      resumePomoTimer()
      break;
    case .running:
      self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            
        // Start progressRing animation start
        self.progressRing.startProgress(to: 25 * 60, duration: 25 * 60) {
          [weak self] in guard let ss = self else { return }
          if ss.timerState != .running {
            return
          }
          print("Done!!")
          
          // When progress complete, set timer running false
          
          ss.finishProgress()
          ss.isPomoTimerRunning = false
          ss.timerState = .done
          ss.updateDonePomo()
          ss.pauseBtn.isHidden = true
            
            // Show up alert
            let alert = UIAlertController(title: "ppoggle completed", message: "Time to rest", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
              NSLog("The \"OK\" alert occured.")
            }))
            ss.present(alert, animated: true, completion: nil)
        }
      break;
    default:
      break;
    }
    timerState = .running
	}
  
  func resumePomoTimer() {
    self.progressRing.innerRingColor = PGColors.red
    self.progressRing.maxValue = 25 * 60
    
    isReset = false
    
    if isPomoTimerRunning {
      self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
      NSLog("progressRing.value = \(self.progressRing.currentValue) after reset, at StartBreakTimer")
      self.progressRing.continueProgress()
      
    }
  }
  
	func startBreakTimer() {
		
		self.progressRing.innerRingColor = PGColors.yellow
		self.progressRing.maxValue = 5 * 60
		self.progressRing.value = 0
		NSLog("isPomoTimerRunning = \(self.isPomoTimerRunning) before reset, at StartBreakTimer")
		
		// When resetBtn is not clicked
//		if isPomoTimerRunning == true {
			isReset = false
			self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    #if DEBUG
			NSLog("progressRing.value = \(self.progressRing.currentValue) after reset, at StartBreakTimer")
    #endif
			self.progressRing.startProgress(to: 5 * 60, duration: 5 * 60){
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
  
	func updateDonePomo() {
		self.donePomo += 1
		self.completedPomoLabel.text = "Today : \(donePomo) / \(targetPomo)"
	}
  
	@objc func updateTimer() {
		if seconds == 0 {
			minutes -= 1
			// 60으로 해야함. 테스트로 5초까지만 설정.
			seconds = 59
		} else {
			seconds -= 1
		}
		// TimerLabel text update every seconds
		self.timerLabel.text = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
    print(self.timerLabel.text)
	}
  
	func finishProgress() {
		
		// When progress finish, check isPomoTimerRunning and start timer
		self.timer.invalidate()
		if isPomoTimerRunning {
			self.minutes = 5
			self.seconds = 0
			self.progressRing.startProgress(to: 0, duration: 0,completion: {
				self.startBreakTimer()
			})
		} else {
			self.minutes = 25
			self.seconds = 0
			self.progressRing.startProgress(to: 0, duration: 0,completion: {
				self.startPomoTimer()
			})
		}
		
	}
  
	func pausePomoTimer() {
		
	}
  
	@objc func startBtnClick(_ sender: UIButton?) {
		// Set Timer running true
//		self.isPomoTimerRunning = true
    timerState = .running
		startBtn.isHidden = true
		pauseBtn.isHidden = false
    
		startPomoTimer()
		
	}
	
	@objc func pauseBtnClick(_ sender: UIButton?) {
		
    if timerState == .running {
      timerState = .paused
			timer.invalidate()
			
			self.progressRing.pauseProgress()
		} else {
      timerState = .running
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
			self.progressRing.continueProgress()
		}
	}
	
	@objc func resetBtnClick(_ sender: UIButton?) {
		isPomoTimerRunning = false
		timerState = .initialized
    #if DEBUG
    print("resetBtnClicked")
    #endif
    
		// Animation stop
    
    progressRing.resetProgress()
    timerLabel.text = "\(pomoMin):00"
    startBtn.isHidden = false
    pauseBtn.isHidden = true
    
    // Timer invalidate
    timer.invalidate()
    
		/*
    self.progressRing.startProgress(to: 0, duration: 0, completion: {
      [weak self] in
      guard let ss = self else { return }
			ss.progressRing.resetProgress()
			
			ss.timerLabel.text = "\(ss.pomoMin):00"
			ss.startBtn.isHidden = false
			ss.pauseBtn.isHidden = true
      ss.timerState = .initialized
			// Timer invalidate
			ss.timer.invalidate()
			
		})
     */
	}
}
