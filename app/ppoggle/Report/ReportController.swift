//
//  ReportController.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 30/12/2018.
//  Copyright © 2018 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ReportController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var pomoInfo = [PomoInfo]()
    let cellID = "ReportCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPomoInfo()
        
        collectionView.backgroundColor = .white
        collectionView.register(ReportCell.self, forCellWithReuseIdentifier: cellID)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }
    
    func loadPomoInfo() {
        let currentDate = Date()
        let monthBeforeDate = Date(timeInterval: -1 * 60 * 60 * 24 * 30, since: currentDate)
        
        let calendar = Calendar.current
        let curMonth = calendar.component(.month, from: currentDate)
        let pastMonth = calendar.component(.month, from: monthBeforeDate)
        
        print("\(curMonth), \(pastMonth)")
    }
    func maxHeight() -> CGFloat {
        return CGFloat(view.frame.height - 20 - 44 - 100)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: maxHeight())
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ReportCell
        
            
        cell.barHeightConstraint?.constant = 200
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
}
