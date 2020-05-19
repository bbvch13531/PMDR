//
//  ReportCollectionViewFlowLayout.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/05/06.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

class ReportCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
//        headerReferenceSize = CGSize(width: 400, height: 50)
//        footerReferenceSize = CGSize(width: 400, height: 50)
        
        scrollDirection = .horizontal
    }
    
}
