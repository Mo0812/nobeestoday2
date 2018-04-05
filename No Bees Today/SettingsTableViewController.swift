//
//  SettingsTableViewController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 03.04.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit
import Toast_Swift
import RealmSwift
import AcknowList

class SettingsTableViewController: UITableViewController {

    var impactGenerator: ImpactGenerator?
    
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.impactGenerator = ImpactGenerator(view: self.view)
        
        self.versionLabel.text = GlobalValues.getAppVersion()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 2
        case 4:
            return 2
        default:
            return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            if indexPath.row == 1 {
                UIApplication.shared.open(URL(string: "https://github.com/Mo0812/nobeestoday2/issues")!, options: [:], completionHandler: nil)
            }
        }
        if indexPath.section == 4 {
            if indexPath.row == 0 {
                UIApplication.shared.open(URL(string: "https://icons8.de/")!, options: [:], completionHandler: nil)
            }
            if indexPath.row == 1 {
                let acknowViewController = AcknowListViewController()
                self.navigationController?.pushViewController(acknowViewController, animated: true)
            }
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

    @IBAction func resetAllData(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        self.impactGenerator?.impact(.warning)
        self.view.makeToast("Alle Daten wurden gelöscht", duration: 2.0, position: .center)
        NotificationCenter.default.post(name: Notification.Name("ClearStorageNotification"), object: nil, userInfo: nil)
    }
}
