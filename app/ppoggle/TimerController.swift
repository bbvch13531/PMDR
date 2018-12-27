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
	let frame = CGRect(x: 0, y: 0, width: 300, height: 300)

	override func viewDidLoad() {
		self.title = "Timer"
//		self.view.backgroundColor = UIColor.orange
		
		start()
		//: Animate with a given duration
		
//		{
//			// This is called when it's finished animating!
//
//			DispatchQueue.main.async {
//				// We can animate the ring back to another value here, and it does so fluidly
//				progressRing.startProgress(to: 80, duration: 2)
//			}
//		}
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
	func start(){
		let progressRing = UICircularProgressRing(frame: frame)
		progressRing.backgroundColor = .white
		progressRing.outerRingColor = .blue
		progressRing.innerRingColor = .white
		progressRing.outerRingWidth = 10
		progressRing.innerRingWidth = 8
		progressRing.ringStyle = .ontop
		progressRing.font = UIFont.boldSystemFont(ofSize: 40)
		self.view.addSubview(progressRing)
		progressRing.startProgress(to: 100, duration: 3){
			print("Done!!")
		}
	}
}
