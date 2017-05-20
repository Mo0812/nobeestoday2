//
//  GlobalValues.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation
import UIKit

class GlobalValues {
    static var firstTakingDate: Date?
    static var currentTakinPeriod: Date?
    static var takingTimePerDay: Date?
    
    class func initDates() {
        self.setFirstTakingDate(Date())
        self.setCurrentTakingPeriod(Date())
        self.setTimePerDay(value: "19:00:00")
    }
    
    class func setFirstTakingDate(_ date: Date) {
        self.firstTakingDate = self.normalizeDate(date)
    }
    
    class func setCurrentTakingPeriod(_ date: Date) {
        self.currentTakinPeriod = self.normalizeDate(date)
    }
    
    class func setTimePerDay(value: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        self.takingTimePerDay = dateFormatter.date(from: value)
    }
    
    class func normalizeDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day], from: date)
        let rightDate = calendar.date(from: components)
        return rightDate!
    }

}
