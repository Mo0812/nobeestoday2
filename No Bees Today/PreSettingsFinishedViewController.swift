//
//  PreSettingsFinishedViewController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 26.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit

class PreSettingsFinishedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePreSettings(_ sender: Any) {
        let preSettingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainPageViewController")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = preSettingsVC
        appDelegate.window?.makeKeyAndVisible()
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
