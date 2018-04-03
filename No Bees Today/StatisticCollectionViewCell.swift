//
//  StatisticCollectionViewCell.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 20.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit
import Charts

class StatisticCollectionViewCell: PillInfoCell {
    
    @IBOutlet weak var resultPieChartView: PieChartView!
    
    
    var statistics = Statistics()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name("ClearStorageNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name("PillStateChanged"), object: nil)
        self.updateView()
    }
    
    @objc func updateView() {
        guard let pc = GlobalValues.getCurrentPillCycleFromStorage() else { return }
        var taken = 0
        var forgotten = 0
        var open = 0
        for pd in pc.cycle {
            switch pd.state {
            case PillDay.PillDayState.pillTaken.rawValue:
                taken += 1
            case PillDay.PillDayState.pillNotYetTaken.rawValue:
                open += 1
            case PillDay.PillDayState.pillForgotten.rawValue:
                forgotten += 1
            default: break
                
            }
        }
        
        resultPieChartView.centerText = "Monatsstatistik"
        resultPieChartView.chartDescription?.text = ""
        resultPieChartView.rotationEnabled = false
        resultPieChartView.rotationAngle = 180

        let legend = resultPieChartView.legend
        legend.horizontalAlignment = .center
        legend.drawInside = false
        
        let takenDataEntry = PieChartDataEntry(value: Double(taken), label: "genommen")
        let forgottenDataEntry = PieChartDataEntry(value: Double(forgotten))
        let openDateEntry = PieChartDataEntry(value: Double(open))
        
        let dataSet = PieChartDataSet(values: [takenDataEntry, forgottenDataEntry, openDateEntry], label: nil)
        dataSet.colors = [NSUIColor(red: 89/255, green: 189/255, blue: 53/255, alpha: 1.0), NSUIColor(red: 236 / 255, green: 125 / 255, blue: 123 / 255, alpha: 1.0), NSUIColor.groupTableViewBackground]
        dataSet.valueFormatter = StatisticsFormatter()
        dataSet.drawValuesEnabled = false
        
        let data = PieChartData(dataSet: dataSet)
        resultPieChartView.data = data
        
        //All other additions to this function will go here
        resultPieChartView.animate(xAxisDuration: 1, yAxisDuration: 1, easingOption: .linear)
        //This must stay at end of function
        resultPieChartView.notifyDataSetChanged()

    }
}
