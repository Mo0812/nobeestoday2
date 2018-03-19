//
//  PillTakingActionCollectionViewCell.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 19.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit

class PillTakingActionCollectionViewCell: PillInfoCell {
    
    @IBOutlet weak var takenButton: UIButton!
    
    var impactGenerator: ImpactGenerator?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.impactGenerator = ImpactGenerator(view: self)
        
        self.updateView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateView), name: Notification.Name("ClearStorageNotification"), object: nil)
    }
    
    @IBAction func pillTaken(_ sender: Any) {
        GlobalValues.pillTakenAction(completionHandler: {
            self.impactGenerator?.impact(.success)
            self.updateView()
            NotificationCenter.default.post(name: Notification.Name("PillTakingNotification"), object: nil, userInfo: nil)
        })
    }
    
    @objc
    func updateView() {
        if let _ = GlobalValues.getCurrentPillDayFromStorage() {
            self.takenButton.isEnabled = false
        } else {
            self.takenButton.isEnabled = true
        }
    }
}
