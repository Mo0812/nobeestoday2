//
//  PillCycle.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation

class PillCycle {
    
    var cycle: [PillDay]
    let startDate: Date
    
    init(startDate: Date) {
        self.startDate = startDate
        self.cycle = [PillDay]()
        
        self.createCycle()
    }
    
    private func createCycle() {
        self.cycle.removeAll()
        
        var currentDay = self.startDate
        for _ in 0..<28 {
            if let currentPillDay = self.getPillDay(from: currentDay) {
                self.cycle.append(PillDay(day: currentPillDay.day, state: currentPillDay.state))
            } else {
                self.cycle.append(PillDay(day: currentDay, state: PillDay.PillDayState.pillNotYetTaken))
            }
            
            currentDay.addTimeInterval(60 * 60 * 24)
        }
    }
    
    private func getPillDay(from storage: Date) -> PillDay? {
        return nil
    }
    
}
