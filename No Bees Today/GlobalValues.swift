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
    static var currentTakingPeriod: Date?
    static private var takingTimePerDay: Date?
    
    class func initDates() {
        self.setFirstTakingDate(Date())
        self.setCurrentTakingPeriod(Date())
        self.setTimePerDay(value: "19:30:00")
    }
    
    class func setFirstTakingDate(_ date: Date) {
        self.firstTakingDate = self.normalizeDate(date)
    }
    
    class func setCurrentTakingPeriod(_ date: Date) {
        self.currentTakingPeriod = self.normalizeDate(date)
    }
    
    class func setTimePerDay(value: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        self.takingTimePerDay = dateFormatter.date(from: value)
    }
    
    class func getTimePerDay() -> Date? {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = Calendar.current.dateComponents([.year], from: currentDate).year
        dateComponents.month = Calendar.current.dateComponents([.month], from: currentDate).month
        dateComponents.day = Calendar.current.dateComponents([.day], from: currentDate).day
        dateComponents.hour = Calendar.current.dateComponents([.hour], from: takingTimePerDay!).hour
        dateComponents.minute = Calendar.current.dateComponents([.minute], from: takingTimePerDay!).minute
        dateComponents.second = 0
        
        /*var calender = Calendar.current
         calender.locale = Locale(identifier: "de_DE")
         
         let componentsPillTime = (calender as NSCalendar).components([.hour, .minute, .second], from: Date())
         if let pillTime = GlobalValues.takingTimePerDay {
         let componentsPillTime = (calender as NSCalendar).components([.hour, .minute, .second], from: pillTime)
         }
         let componentsNowTime = (calender as NSCalendar).components([.year, .month, .day], from: Date())
         
         let formatter = DateFormatter()
         formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
         let dateTargetNSD = formatter.date(from: "\(componentsNowTime.year)-\(componentsNowTime.month)-\(componentsNowTime.day) \(componentsPillTime.hour):\(componentsPillTime.minute):00")
         
         return dateTargetNSD*/
        return Calendar.current.date(from: dateComponents)
    }
    
    class func normalizeDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.year, .month, .day], from: date)
        let rightDate = calendar.date(from: components)
        return rightDate!
    }

}
