//
//  PillDay.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation

class PillDay: NSCoding {
    
    enum PillDayState: Int {
        case pillTaken = 0
        case pillBlood = 1
        case pillForgotten = 2
        case pillNotYetTaken = 3
    }
    
    var day: Date
    var state: PillDayState
    
    init(day: Date, state: PillDayState) {
        self.day = day
        self.state = state
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let day = aDecoder.decodeObject(forKey: "day") as? Date,
            let state = aDecoder.decodeObject(forKey: "state") as? Int
            else {
                return nil
        }
        
        self.init(day: day, state: PillDay.PillDayState(rawValue: state)!)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.day, forKey: "day")
        aCoder.encode(self.state, forKey: "state")
    }
}
