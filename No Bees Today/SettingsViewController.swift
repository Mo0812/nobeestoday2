//
//  SettingsViewController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 24.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit
import RealmSwift
import Toast_Swift

class SettingsViewController: UIViewController {
    
    var impactGenerator: ImpactGenerator?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.impactGenerator = ImpactGenerator(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearRealmStorage(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        self.impactGenerator?.impact(.warning)
        self.view.makeToast("Alle Daten wurden gelöscht", duration: 2.0, position: .bottom)
    }

    @IBAction func showPreSettings(_ sender: Any) {
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
