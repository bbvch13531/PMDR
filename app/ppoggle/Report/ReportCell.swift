//
//  ReportCell.swift
//  ppoggle
//
//  Created by KyungYoung Heo on 2020/05/03.
//  Copyright © 2020 KyungYoung Heo. All rights reserved.
//

import Foundation
import UIKit

class ReportCell: UICollectionViewCell {
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var barHeightConstraint: NSLayoutConstraint?

    override var isHighlighted: Bool {
        didSet {
            barView.backgroundColor = isHighlighted ? .black : .red
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(barView)
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300)
        barHeightConstraint?.isActive = true
        barHeightConstraint?.constant = 100
        
//        barView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        barHeightConstraint?.constant = 0
    }
}
