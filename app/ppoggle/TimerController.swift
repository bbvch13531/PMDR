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
		
		setUpNavigationBar()
		setUpProgressRing()
		setUpBtns()
		
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
	private func setUpNavigationBar(){
		let screenRect = UIScreen.main.bounds
		let screenWidth = screenRect.size.width
		let screenHeight = screenRect.size.height
		
		let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: screenWidth, height: 70))
		self.view.addSubview(navBar);
		
		let navItem = UINavigationItem(title: "SomeTitle");
		let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil);
		navItem.leftBarButtonItem = doneItem;
		
		navBar.setItems([navItem], animated: false);
		
	}
	private func setUpProgressRing(){
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
		self.view.addSubview(progressRing)
	}
	private func setUpBtns(){
		let startBtn = UIButton(frame: CGRect(x: 50, y: 450, width: 120, height: 50))
		startBtn.setTitle("start", for: .normal)
		startBtn.backgroundColor = UIColor.orange
		let resetBtn = UIButton(frame: CGRect(x: 200, y: 450, width: 120, height: 50))
		resetBtn.setTitle("reset", for: .normal)
		resetBtn.backgroundColor = UIColor.orange
		
		self.view.addSubview(startBtn)
		self.view.addSubview(resetBtn)
		startBtn.addTarget(self, action: #selector(self.startBtnClick), for: .touchDown)
		resetBtn.addTarget(self, action: #selector(self.resetBtnClick), for: .touchDown)
	}
	@objc func startBtnClick(_ sender: UIButton?){
		self.progressRing.startProgress(to: 100, duration: 2){
			print("Done!!")
		}
	}
	@objc func resetBtnClick(_ sender: UIButton?){
		self.progressRing.resetProgress()
	}
}
