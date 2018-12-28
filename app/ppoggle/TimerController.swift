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
	//	required init?(coder aDecoder: NSCoder) {
	//		super.init(nibName: nil, bundle: nil)
	//	}
	var frame : CGRect{
		get{
			return CGRect(x: 50, y: 100, width: 300, height: 300)
		}
	}
	lazy var progressRing = UICircularProgressRing(frame: frame)
	
	override func viewDidLoad() {
		self.title = "Timer"
	
		let startBtn = UIButton(frame: CGRect(x: 50, y: 450, width: 120, height: 50))
		startBtn.setTitle("start", for: .normal)
		startBtn.backgroundColor = UIColor.orange
		let resetBtn = UIButton(frame: CGRect(x: 200, y: 450, width: 120, height: 50))
		resetBtn.setTitle("reset", for: .normal)
		
		
		self.view.addSubview(startBtn)
		self.view.addSubview(resetBtn)
		startBtn.addTarget(self, action: #selector(self.startBtnClick), for: .touchDown)
		resetBtn.addTarget(self, action: #selector(self.resetBtnClick), for: .touchDown)
		self.view.addSubview(progressRing)
		start()
	
		//: Animate with a given duration
		//
		//		//: Pause and continue animations dynamically
		//		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
		//			progressRing.pauseProgress()
		//			//: Customize the ring even more
		//			progressRing.showsValueKnob = true
		//			progressRing.valueKnobSize = 20
		//			progressRing.valueKnobColor = .green
		//
		//		}
		//
		//		//: Continue the animation whenever you want
		//		DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
		//			progressRing.continueProgress()
		//		}
		//
		//		//: For more information [read the docs](https://goo.gl/JJCHeo)
		
	}
	@objc func startBtnClick(_ sender: UIButton?){
		self.progressRing.startProgress(to: 100, duration: 2){
			print("Done!!")
		}
	}
	@objc func resetBtnClick(_ sender: UIButton?){
		self.progressRing.resetProgress()
	}
	func start(){
		
		progressRing.backgroundColor = .white
		progressRing.outerRingColor = .blue
		progressRing.innerRingColor = .white
		progressRing.outerRingWidth = 10
		progressRing.innerRingWidth = 8
		progressRing.ringStyle = .ontop
		progressRing.font = UIFont.boldSystemFont(ofSize: 40)
		
		//		progressRing.startProgress(to: 100, duration: 3){
		//			print("Done!!")
		//		}
		
		// This is called when it's finished animating!
		
//		DispatchQueue.main.async {
//			// We can animate the ring back to another value here, and it does so fluidly
//			self.progressRing.startProgress(to: 100, duration: 2){
//				print("Done!!")
//			}
//		}
		
	}
}
