//
//  Statistics.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 20.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import Foundation

class Statistics {
    
    init() {
        
    }
    
    public func calculateCycleReview() -> [Int]? {
        guard let currentCycle = GlobalValues.getCurrentPillCycleFromStorage(), let currentDay = currentCycle.getCurrentPillDay() else { return nil }
        
        
        
        var dayCounter = 0;
        var takenCounter = 0;
        for pd in currentCycle.cycle {
            if Calendar.current.compare(pd.day, to: currentDay.day, toGranularity: .day) == .orderedSame {
                break
            }
            dayCounter += 1
            if pd.state == PillDay.PillDayState.pillTaken.rawValue{
                takenCounter += 1
            }
        }
        
        var retArr = [Int]()
        retArr.append(dayCounter)
        retArr.append(takenCounter)
        
        return retArr
    }
    
}
