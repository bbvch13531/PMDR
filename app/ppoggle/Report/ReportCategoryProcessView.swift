//
//  ReportCategoryProcessView.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/03/24.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import UIKit
import SnapKit

class ReportCategoryProcessView: UIView {
    var titleLabel: UILabel?
    var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
