//
//  PillTakingController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 22.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit

class PillTakingController: UIViewController {
    
    @IBOutlet weak var pillImage: UIImageView!
    @IBOutlet weak var pillLabel: UILabel!
    @IBOutlet weak var pillTimer: UILabel!
    @IBOutlet weak var takenButton: UIButton!
    
    let formatter = DateFormatter()
    var dateTarget: TimeInterval = 0.0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateTimeDiff()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PillTakingController.updateTimeDiff), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTimeDiff() {
        if let currentPD = GlobalValues.getCurrentPillDayFromStorage() {
            // Auswertung des Pillenstatus
            if self.timer != nil {
                self.timer!.invalidate()
                self.timer = nil
            }
            self.takenButton.isEnabled = false
            
            let state = PillDay.PillDayState(rawValue: currentPD.state)!
            switch(state) {
                case .pillTaken:
                    self.pillImage.image = UIImage(named: "pill-taken")
                    self.pillTimer.textColor = UIColor.black
                    self.pillLabel.text = "Du hast die Pille eingenommen"
                    self.pillTimer.text = "Super!"
                case .pillBlood:
                    self.pillImage.image = UIImage(named: "blood")
                    self.pillTimer.textColor = UIColor.black
                    self.pillLabel.text = "Heute ist keine Pille nötig"
                    self.pillTimer.text = ""
                case .pillForgotten:
                    self.pillImage.image = UIImage(named: "pill-forgotten")
                    self.pillTimer.textColor = UIColor.red
                    self.pillLabel.text = "Du hast deine Pille vergessen"
                    self.pillTimer.text = "Denk dran!"
                default:
                    self.pillImage.image = UIImage(named: "pill")
                    self.pillLabel.text = ""
                    self.pillTimer.text = ""
            }
        } else {
            self.takenButton.isEnabled = true
            self.pillImage.image = UIImage(named: "timer")
            
            if let timePerDay = GlobalValues.getTimePerDay() {
                let timeDiff = NSCalendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: timePerDay)
                var pillTimerString = "\(abs(timeDiff.hour!)):\(abs(timeDiff.minute!)):\(abs(timeDiff.second!))"
                if(timeDiff.hour! > 0 || timeDiff.minute! > 0 || timeDiff.second! > 0) {
                    self.pillTimer.textColor = UIColor.black
                    self.pillLabel.text = "Zeit bis zur Pilleneinnahme:"
                } else {
                    self.pillTimer.textColor = UIColor.red
                    self.pillLabel.text = "Du hast deine Pille noch nicht genommen:"
                    pillTimerString = "- " + pillTimerString
                }
                self.pillTimer.text = pillTimerString
            } else {
                
            }           
            
        }
    }
    
    @IBAction func pillTaken(_ sender: AnyObject) {
        LocalNotificationService.shared.pillTakenAction(completionHandler: {
            self.updateTimeDiff()
        })
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
