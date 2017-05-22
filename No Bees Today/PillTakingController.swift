//
//  PillTakingController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 22.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit

class PillTakingController: UIViewController {
    
    @IBOutlet weak var pillLabel: UILabel!
    @IBOutlet weak var pillTimer: UILabel!
    
    let formatter = DateFormatter()
    var dateTarget: TimeInterval = 0.0
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateTimeDiff()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        if(false) {
            self.pillLabel.text = "Für heute ist alles:"
            self.pillLabel.textColor = UIColor.gray
            self.pillTimer.text = "Erledigt"
            self.pillTimer.textColor = UIColor.black
        } else {
            let timeDiff = NSCalendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: GlobalValues.getTimePerDay()!)
            
            self.pillTimer.text = "\(timeDiff.hour!):\(timeDiff.minute!):\(timeDiff.second!)"
            
            if(timeDiff.hour! > 0 || timeDiff.minute! > 0 || timeDiff.second! > 0) {
                self.pillTimer.textColor = UIColor.red
                self.pillLabel.text = "Du hast deine Pille noch nicht genommen:"
            } else {
                self.pillTimer.textColor = UIColor.black
                self.pillLabel.text = "Zeit bis zur Pilleneinnahme:"
            }
        }
    }
    
    @IBAction func pillTaken(_ sender: AnyObject) {
        /*GlobalValues.takingPlan?.addDay(Date(), state: PillDay.PillDayState.pillTaken)
        NotificationService.cancelStressNotificationsOnForgotten()*/
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
