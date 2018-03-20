//
//  StatisticCollectionViewCell.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 20.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit

class StatisticCollectionViewCell: PillInfoCell {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var statistics = Statistics()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let result = statistics.calculateCycleReview() {
            let average = result[1] / result[0]
            let forgottenDays = result[1] - result[0]
            
            if average == 1 {
                resultLabel.text = "Super, du hast die Pille bisher kein mal vergessen!"
            } else {
                resultLabel.text = "Du hast die Pille bisher leider schon \(forgottenDays) nicht genommen!"
            }
        } else {
            resultLabel.text = "Es liegen leider nicht genug Daten vor."
        }
    }
}
