//
//  PreSettingFTDViewController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 26.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit

class PreSettingsFTDViewController: UIViewController {
    
    @IBOutlet weak var ftdDatePicker: UIDatePicker!
    
    var ftd = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPreSetting(_ sender: Any) {
        GlobalValues.setFirstTakingDate(self.ftd)
        GlobalValues.setCurrentTakingPeriod(self.ftd)
        self.performSegue(withIdentifier: "showTTPDView", sender: self)
    }

    @IBAction func changedFTD(_ sender: Any) {
        self.ftd = self.ftdDatePicker.date
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
