//
//  PillDay.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation
import RealmSwift

class PillDay: Object {
    
    enum PillDayState: Int {
        case pillTaken = 0
        case pillBlood = 1
        case pillForgotten = 2
        case pillNotYetTaken = 3
    }
    
    dynamic var day: Date = Date()
    dynamic var state: Int = 0
    
    convenience public init(day: Date, state: PillDayState) {
        self.init()
        self.day = day
        self.state = state.rawValue
    }
    
    public func updateState(state: PillDayState) {
        let realm = try! Realm()
        
        let pd = realm.objects(PillDay.self).filter("day = %@", self.day).first
        
        if let pd = pd {
            try! realm.write {
                pd.state = state.rawValue
            }
        } else {
            try! realm.write {
                realm.add(self)
            }
        }
    }
}
