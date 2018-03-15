//
//  PillCalendarController.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import UIKit

class PillCalendarController: UIViewController {
    
    var pillCycleArr: [PillDay] = [PillDay]()
    var impactGenerator: ImpactGenerator?
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.impactGenerator = ImpactGenerator(view: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updatePillCycle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updatePillCycle() {
        if let currentPeriod = GlobalValues.currentTakingPeriod {
            let pillCylce = PillCycle(startDate: currentPeriod)
            self.pillCycleArr = pillCylce.cycle
            self.collectionView.reloadData()
        }
    }
    
    func showActionSheet(controlledPillDay: PillDay) {
        let actionSheetController = UIAlertController(title: "Status", message: "Was hast du an diesem Tag gemacht?", preferredStyle: .actionSheet)
        
        let pillTakenButton = UIAlertAction(title: "Pille genommen", style: .default, handler: {
            action in
            controlledPillDay.updateState(state: .pillTaken, result: {
                success in
                if(success) {
                    self.impactGenerator?.impact(.success)
                    self.updatePillCycle()
                }
            })
        })
        let pillForgottenButton = UIAlertAction(title: "Pille vergessen", style: .destructive, handler: {
            action in
            controlledPillDay.updateState(state: .pillForgotten, result: {
                success in
                if(success) {
                    self.impactGenerator?.impact(.warning)
                    self.updatePillCycle()
                }
            })
        })
        let pillCancelButton = UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
            action in
            self.impactGenerator?.impact(.failure)
        })
        actionSheetController.addAction(pillTakenButton)
        actionSheetController.addAction(pillForgottenButton)
        actionSheetController.addAction(pillCancelButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
}

extension PillCalendarController: UICollectionViewDataSource, UICollectionViewDelegate {
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pillCycleArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PillCell", for: indexPath) as! PillCell
        
        let pillDay = self.pillCycleArr[indexPath.row]
        // Configure the cell
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "EE"
        cell.weekdayLabel.text = formatter.string(from: pillDay.day as Date)
        
        formatter.dateFormat = "dd.MM."
        cell.dateLabel.text = formatter.string(from: pillDay.day as Date)
        
        switch(pillDay.state) {
        case 0:
            cell.pillImage.image = UIImage(named: "pill-taken")
        case 1:
            cell.pillImage.image = UIImage(named: "blood")
        case 2:
            cell.pillImage.image = UIImage(named: "pill-forgotten")
        default:
            cell.pillImage.image = UIImage(named: "pill")
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.pillCycleArr[indexPath.row]
        if selectedItem.state != PillDay.PillDayState.pillBlood.rawValue {
            self.showActionSheet(controlledPillDay: self.pillCycleArr[indexPath.row])
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
