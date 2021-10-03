//
//  ChartViewController.swift
//  StockTracker
//
//  Created by Pavel Ryabov on 27.03.2021.
//

import UIKit
import Charts
import TinyConstraints

class ChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var chartTickerLabel: UILabel!
    var chartTickerText = ""
     var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .white
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .black
        yAxis.labelPosition = .outsideChart
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 10)
        xAxis.setLabelCount(0, force: false)
        xAxis.labelTextColor = .black
        xAxis.axisLineColor = .white
        
        return chartView
    }()
    
    var openPrice = [Double]()
    var highPrice = [Double]()
    var lowPrice = [Double]()
    var dataEntries: [ChartDataEntry] = []
    
    func setData() {
        dataEntries = [ChartDataEntry(x: 1, y: openPrice[0]),
                       ChartDataEntry(x: 2, y: highPrice[0]),
                       ChartDataEntry(x: 3, y: lowPrice[0])]
        let set1 = LineChartDataSet(entries: dataEntries, label: "Price (1:Open, 2:High, 3:Low)")
        set1.drawCirclesEnabled = false
        set1.mode = .linear
        set1.lineWidth = 3
        set1.setColor(.black)
        set1.fill = Fill(color: .gray)
        set1.fillAlpha = 0.5
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setValueFont(.boldSystemFont(ofSize: 10))
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        chartTickerLabel.text = chartTickerText
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}
