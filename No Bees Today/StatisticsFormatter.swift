//
//  StatisticsFormatter.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 03.04.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import Foundation
import Charts

class StatisticsFormatter: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if value > 0 {
            return String(format: "%.0f", value)
        } else {
            return ""
        }
    }
}
