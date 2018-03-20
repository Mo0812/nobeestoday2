//
//  PreSettingFTDViewController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 26.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit
import RealmSwift

class PreSettingsFTDViewController: UIViewController {
    
    @IBOutlet weak var ftdDatePicker: UIDatePicker!
    
    var ftd = Date()
    var changedGivenDate = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let oldFTD = GlobalValues.firstTakingDate {
            self.ftd = oldFTD
            self.ftdDatePicker.setDate(oldFTD, animated: false)
            self.changedGivenDate = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Korrekte Änderung der Daten über die boolsche Variable und die beiden Funktionen?
    @IBAction func nextPreSetting(_ sender: Any) {
        if self.changedGivenDate {
            let alert = UIAlertController(title: "Änderung des Zyklusdatums", message: "Wenn du das Zyklumdatum änderst, gehen alle bisherigen Daten verlorden", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Abbrechen", style: UIAlertActionStyle.default, handler: {
                action in
                self.setInGivenDate()
            }))
            alert.addAction(UIAlertAction(title: "Löschen", style: UIAlertActionStyle.cancel, handler: {
                action in
                self.changeCycleDate(clearAll: true)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.changeCycleDate(clearAll: false)
        }
    }

    @IBAction func changedFTD(_ sender: Any) {
        self.ftd = self.ftdDatePicker.date
    }
    
    func changeCycleDate(clearAll: Bool) {
        if clearAll {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
        GlobalValues.setFirstTakingDate(self.ftd)
        GlobalValues.setCurrentTakingPeriod(self.ftd)
        self.performSegue(withIdentifier: "showTTPDView", sender: self)
    }
    
    func setInGivenDate() {
        if let oldFTD = GlobalValues.firstTakingDate {
            self.ftd = oldFTD
            self.ftdDatePicker.setDate(oldFTD, animated: false)
            self.changedGivenDate = true
        }
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
