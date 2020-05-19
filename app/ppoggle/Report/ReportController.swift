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
import Charts

class ReportController: UICollectionViewController {

    var pomoInfo = [PomoInfo]()
    var barChartView: BarChartView = {
        let chartView = BarChartView(frame: CGRect(x: 50, y: 50, width: 300, height: 300))
        chartView.setScaleEnabled(false)

        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        //        chartView.setVisibleXRangeMaximum(40)
        //        chartView.setVisibleXRange(minXRange: 10, maxXRange: 14)
        let yAxis = chartView.leftAxis
        yAxis.labelPosition = .outsideChart

        chartView.backgroundColor = .darkGray
        return chartView
    }()
    
    var barValues = [BarChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(barChartView)
        view.backgroundColor = .gray
        
        loadPomoInfo()
        loadData()
        
    }
    
    func loadPomoInfo() {
        let currentDate = Date()
        let monthBeforeDate = Date(timeInterval: -1 * 60 * 60 * 24 * 30, since: currentDate)
        
        let calendar = Calendar.current
        let curMonth = calendar.component(.month, from: currentDate)
        let pastMonth = calendar.component(.month, from: monthBeforeDate)
        
        pomoInfo = UserDefaultsManager.loadPomoOfDays()
        
    }
    
    func loadData() {
        // PomoInfo to barValues
        // String to Date
        
        let string = "1995-05-13 +0900"
        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy-MM-dd Z"
        let date = formatter.date(from: string)
        print("loadData = \(date)")
   
        let dataset = BarChartDataSet(entries: barValues, label: "pomo")
        let data = BarChartData(dataSet: dataset)
        barChartView.data = data
    }
}

extension ReportController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
