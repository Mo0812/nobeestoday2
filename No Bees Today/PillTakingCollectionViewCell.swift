//
//  PillTakingCollectionViewCell.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 19.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit

class PillTakingCollectionViewCell: PillInfoCell {
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var pillImage: UIImageView!
    @IBOutlet weak var pillLabel: UILabel!
    @IBOutlet weak var pillTimer: UILabel!
    
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        self.updateView()
        if let _ = self.timer {
            
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateView() {
        if let currentPD = GlobalValues.getCurrentPillDayFromStorage() {
            
            let state = PillDay.PillDayState(rawValue: currentPD.state)!
            switch state {
            case .pillTaken:
            self.pillImage.image = UIImage(named: "pill-taken")
            self.pillTimer.textColor = UIColor.black
            self.pillLabel.text = NSLocalizedString("You have taken your pill", comment: "")
            self.pillTimer.text = NSLocalizedString("Perfect!", comment: "")
            case .pillBlood:
            self.pillImage.image = UIImage(named: "blood")
            self.pillTimer.textColor = UIColor.black
            self.pillLabel.text = NSLocalizedString("Today no pill is needed", comment: "")
            self.pillTimer.text = ""
            case .pillForgotten:
            self.pillImage.image = UIImage(named: "pill-forgotten")
            self.pillTimer.textColor = UIColor.red
            self.pillLabel.text = NSLocalizedString("You forgot to take the pill", comment: "")
            self.pillTimer.text = NSLocalizedString("Remember!", comment: "")
            default:
            self.pillImage.image = UIImage(named: "pill")
            self.pillLabel.text = ""
            self.pillTimer.text = ""
            }
        } else {
            self.pillImage.image = UIImage(named: "timer")
             
             if let timePerDay = GlobalValues.getTimePerDay() {
                let timeDiff = NSCalendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: timePerDay)
                
                var hour = String(abs(timeDiff.hour!))
                if hour.count == 1 {
                    hour = "0" + hour
                }
                var minute = String(abs(timeDiff.minute!))
                if minute.count == 1 {
                    minute = "0" + minute
                }
                var second = String(abs(timeDiff.second!))
                if second.count == 1 {
                    second = "0" + second
                }
                
                var pillTimerString = "\(hour):\(minute):\(second)"
                if (timeDiff.hour! > 0 || timeDiff.minute! > 0 || timeDiff.second! > 0) {
                    self.pillTimer.textColor = UIColor.black
                    self.pillLabel.text = NSLocalizedString("Time until pill taking:", comment: "")
                } else {
                    self.pillTimer.textColor = UIColor.red
                    self.pillLabel.text = NSLocalizedString("You haven't take your pill yet:", comment: "")
                    pillTimerString = "- " + pillTimerString
                }
                self.pillTimer.text = pillTimerString
             } else {
             
             }
        }
    }
    
}
