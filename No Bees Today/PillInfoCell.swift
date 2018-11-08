//
//  PillInfoCell.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 19.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit

class PillInfoCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.layer.cornerRadius = 25.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layoutIfNeeded()
    }
    
}
