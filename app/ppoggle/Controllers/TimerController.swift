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
import SnapKit

class TimerController: UIViewController {

	
    var progressRing: UICircularProgressRing = {
        let ring = UICircularProgressRing()
        ring.frame = CGRect(x: 45, y: 230, width: 300, height: 300)

        ring.backgroundColor = .white
        ring.outerRingColor = PGColors.gray
        ring.outerRingWidth = 25
        ring.startAngle = 270
        ring.innerRingWidth = 25
//        ring.ringStyle = 
        ring.shouldShowValueText = false
//        ring.animationStyle = CAMediaTimingFunctionName.linear.rawValue
        ring.font = UIFont.boldSystemFont(ofSize: 40)
        return ring
    }()

  // Pomo timer
    var timer = Timer()
  
    var timerState = TimerState.initialized

    var startBtn: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 40, y: 550, width: 150, height: 70)
        button.setTitle("start", for: .normal)
        button.backgroundColor = PGColors.red
        button.layer.cornerRadius = 15
        button.titleLabel?.font = PGFonts.buttonTitle
        return button
    }()
  
    var pauseBtn: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 40, y: 550, width: 150, height: 70)
        button.setTitle("pause", for: .normal)
        button.backgroundColor = PGColors.red
        button.layer.cornerRadius = 15
        button.titleLabel?.font = PGFonts.buttonTitle
        button.isHidden = true
        return button
    }()
  
    var resetBtn: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 200, y: 550, width: 150, height: 70)
        button.setTitle("reset", for: .normal)
        button.backgroundColor = PGColors.red
        button.layer.cornerRadius = 15
        button.titleLabel?.font = PGFonts.buttonTitle
        return button
    }()
  
    var completedPomoLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 120, y: 160, width: 200, height: 50)
        label.font = PGFonts.labelTitle
        label.text = "Today : 0 / 20"
        return label
    }()

    var timerLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 140, y: 350, width: 200, height: 50)
        label.font = PGFonts.buttonTitle
        label.text = "00:00"
        label.textColor = .black
        return label
    }()

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
	
    var pomoInfo: PomoInfo?
  
    var currentDate: String {
        get {
            let date = Date()
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            
            return "\(year)-\(month)-\(day)"
        }
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
  
//    init(pomoInfo: PomoInfo) {
//        super.init(nibName: nil, bundle: nil)
//        self.pomoInfo = pomoInfo
//    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        // Set up UI
    
        view.addSubview(startBtn)
        view.addSubview(pauseBtn)
        view.addSubview(resetBtn)

        startBtn.titleLabel?.font = PGFonts.buttonTitle
        startBtn.addTarget(self, action: #selector(startBtnClick), for: .touchDown)
        pauseBtn.addTarget(self, action: #selector(pauseBtnClick), for: .touchDown)
        resetBtn.addTarget(self, action: #selector(resetBtnClick), for: .touchDown)

        view.addSubview(progressRing)
        view.addSubview(timerLabel)
        view.addSubview(completedPomoLabel)
        
        print(currentDate)
	}
  
	override func viewWillDisappear(_ animated: Bool) {
		isPomoTimerRunning = false
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
        progressRing.innerRingColor = PGColors.red
        progressRing.maxValue = CGFloat(pomoMin * 60)
    
    #if DEBUG
		NSLog("isPomoTimerRunning = \(isPomoTimerRunning) before reset, at StartPomoTimer")
        NSLog("progressRing.value = \(String(describing: self.progressRing.currentValue)) after reset, at StartPomoTimer")
		NSLog("progressRing.value = \(progressRing.currentValue) after reset, at StartPomoTimer")
    #endif

        switch timerState {
        case .paused:
            resumePomoTimer()
            break;
        case .running:
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
                
            // Start progressRing animation start
            progressRing.startProgress(to: CGFloat(pomoMin * 60), duration: Double(pomoMin * 60)) {
              [weak self] in guard let ss = self else { return }
              if ss.timerState != .running {
                return
              }
              
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
    progressRing.innerRingColor = PGColors.red
    progressRing.maxValue = CGFloat(pomoMin * 60)
    
    isReset = false
    
    if isPomoTimerRunning {
      timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
      NSLog("progressRing.value = \(self.progressRing.currentValue) after reset, at StartBreakTimer")
      progressRing.continueProgress()
      
    }
  }
  
	func startBreakTimer() {
		
		progressRing.innerRingColor = PGColors.yellow
		progressRing.maxValue = CGFloat(breakMin * 60)
		progressRing.value = 0
		NSLog("isPomoTimerRunning = \(isPomoTimerRunning) before reset, at StartBreakTimer")
		
		// When resetBtn is not clicked
//		if isPomoTimerRunning == true {
			isReset = false
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    #if DEBUG
			NSLog("progressRing.value = \(progressRing.currentValue) after reset, at StartBreakTimer")
    #endif
			self.progressRing.startProgress(to: CGFloat(breakMin * 60), duration: Double(breakMin * 60)){ [weak self] in
        guard let ss = self else { return }
				print("Done!!")
				// When progress complete, set timer running false
				
                ss.startBtn.isHidden = true
                ss.pauseBtn.isHidden = false
				
				ss.finishProgress()
				ss.isPomoTimerRunning = true
				
				// Show up alert
				let alert = UIAlertController(title: "Break finished", message: "Time to focus on", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: NSLocalizedString("확인", comment: "Default action"), style: .default, handler: { _ in
					NSLog("The \"OK\" alert occured.")
				}))
				ss.present(alert, animated: true, completion: nil)
				
			}
//		}
		// else : When resetBtn is clicked
	}
  
	func updateDonePomo() {
        donePomo += 1
        
        let pomoInfo = PomoInfo(date: currentDate, pomoDone: donePomo)
        // save pomoDone
//        let userDefaults = UserDefaults.standard
//        let encoder = JSONEncoder()
//        do {
//            let jsonData = try encoder.encode(pomoInfo)
//            userDefaults.set(jsonData, forKey: currentDate)
//        } catch {
//            print(error)
//        }
//
//        let info = userDefaults.data(forKey: currentDate)
//        let decoder = JSONDecoder()
//
//        do {
//            let pomo = try decoder.decode(PomoInfo.self, from: info!)
////            print("\(pomo.date) \(pomo.pomoDone)")
//        } catch {
//            print(error)
//        }
        UserDefaultsManager.update(info: pomoInfo)
        
        completedPomoLabel.text = "Today : \(donePomo) / \(targetPomo)"
        
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
		timerLabel.text = "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
	}
  
	func finishProgress() {
		// save pomoInfo
        
		// When progress finish, check isPomoTimerRunning and start timer
		timer.invalidate()
		if isPomoTimerRunning {
			minutes = breakMin
			seconds = 0
			progressRing.startProgress(to: 0, duration: 0,completion: {
        self.startBreakTimer()
			})
		} else {
			minutes = pomoMin
			seconds = 0
			progressRing.startProgress(to: 0, duration: 0,completion: {
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
			
			progressRing.pauseProgress()
		} else {
      timerState = .running
			timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
			progressRing.continueProgress()
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
