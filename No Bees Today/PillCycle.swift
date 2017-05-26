//
//  PillCycle.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation
import RealmSwift

class PillCycle {
    
    var cycle: [PillDay]
    let startDate: Date
    let realm: Realm
    
    init(startDate: Date) {
        self.startDate = GlobalValues.normalizeDate(startDate)
        self.cycle = [PillDay]()
        self.realm = try! Realm()
        
        self.createCycle()
    }
    
    private func createCycle() {
        self.cycle.removeAll()
        
        var currentDay = self.startDate
        for day in 0..<28 {
            if let currentPillDay = self.getPillDay(from: currentDay) {
                self.cycle.append(currentPillDay)
            } else {
                if (21...27).contains(day) {
                    let pd = PillDay(day: currentDay, state: PillDay.PillDayState.pillBlood)
                    self.cycle.append(pd)
                    try! self.realm.write {
                        self.realm.add(pd)
                    }
                } else {
                    self.cycle.append(PillDay(day: currentDay, state: PillDay.PillDayState.pillNotYetTaken))
                }
            }
            
            currentDay.addTimeInterval(60 * 60 * 24)
        }
    }
    
    private func getPillDay(from: Date) -> PillDay? {
        let searchedPD = realm.objects(PillDay.self).filter("day = %@", from)
        return searchedPD.first
    }
    
    public func getCurrentPillDay() -> PillDay? {
        return self.getPillDay(from: GlobalValues.normalizeDate(Date()))
    }
    
}
