//
//  PreSettingsTTPDViewController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 26.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit

class PreSettingsTTPDViewController: UIViewController {

    @IBOutlet weak var ttpdDatePicker: UIDatePicker!
    
    var ttpd:String = "19:00:00"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextPreSetting(_ sender: Any) {
        GlobalValues.setTimePerDay(value: self.ttpd)
        LocalNotificationService.shared.registerDailyNotifications(forDate: GlobalValues.getTimePerDay()!)
        self.performSegue(withIdentifier: "showFinishedView", sender: self)
    }
    
    @IBAction func changedTTPD(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.ttpd = dateFormatter.string(from: self.ttpdDatePicker.date) + ":00"
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
