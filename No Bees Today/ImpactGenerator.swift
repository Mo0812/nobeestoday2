//
//  ImpactGenerator.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 15.03.18.
//  Copyright © 2018 Moritz Kanzler. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class ImpactGenerator {
    
    enum ImpactType {
        case success
        case failure
        case warning
    }
    
    private var impactAvailable: Bool
    
    init(view: UIView) {
        self.impactAvailable = false
        if #available(iOS 9, *) {
            if view.traitCollection.forceTouchCapability == .available {
                self.impactAvailable = true
            }
        }
    }
    
    public func impact(_ type: ImpactType) {
        if impactAvailable {
            let impactNotificationGenerator = UINotificationFeedbackGenerator()
            let impactGenerator = UIImpactFeedbackGenerator()
            switch type {
            case .warning:
                impactNotificationGenerator.notificationOccurred(.warning)
            case .failure:
                impactNotificationGenerator.notificationOccurred(.error)
            default:
                impactGenerator.impactOccurred()
            }
        } else {
            switch type {
            case .warning:
                AudioServicesPlaySystemSound(1520)
            case .failure:
                AudioServicesPlaySystemSound(1521)
            default:
                AudioServicesPlaySystemSound(1519)
            }
        }
    }
    
}
