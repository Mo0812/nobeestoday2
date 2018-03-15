//
//  MenuView.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 15.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import UIKit

class MenuView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
    }
    
    override required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
    }
    
    private func loadXib() {
        Bundle.main.loadNibNamed("MenuView", owner: self, options: nil)
    }
}
