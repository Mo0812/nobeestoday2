//
//  NotificationService.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 21.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation
import UIKit

class NotificationService {
    
    static let sharedInstance = NotificationService()
    private let application = UIApplication.shared
    
    init() {
        self.initNotificationService()
    }
    
    func initNotificationService() {
        let completeAction = UIMutableUserNotificationAction()
        completeAction.identifier = "PILL_TAKEN" // the unique identifier for this action
        completeAction.title = "Pille genommen" // title for the action button
        completeAction.activationMode = .background // UIUserNotificationActivationMode.Background - don't bring app to foreground
        completeAction.isAuthenticationRequired = false // don't require unlocking before performing action
        completeAction.isDestructive = false // display action in red
        
        let remindAction = UIMutableUserNotificationAction()
        remindAction.identifier = "REMIND"
        remindAction.title = "Später erinnern"
        remindAction.activationMode = .background
        remindAction.isDestructive = true
        
        let pillCategory = UIMutableUserNotificationCategory() // notification categories allow us to create groups of actions that we can associate with a notification
        pillCategory.identifier = "PILL_CATEGORY"
        pillCategory.setActions([completeAction, remindAction], for: .default) // UIUserNotificationActionContext.Default (4 actions max)
        pillCategory.setActions([remindAction, completeAction], for: .minimal)
        
        self.application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: (NSSet(array: [pillCategory])) as? Set<UIUserNotificationCategory>))
    }
    
    func handle(action: String) {
        switch (action) {
            case "PILL_TAKEN":
                //GlobalValues.takingPlan?.addDay(Date(), state: PillDay.PillDayState.pillTaken)
                self.cancelStressNotificationsOnForgotten()
                break;
            case "REMIND":
                print("Weiter")
                break;
            default: // switch statements must be exhaustive - this condition should never be met
                print("Error: unexpected notification action identifier!")
        }
    }
    
    func setNotificationForTakingPerDay() {
        
        let app = UIApplication.shared
        if let searchedNotifications = app.scheduledLocalNotifications {
            for thisNotification in searchedNotifications {
                if let userinfo = thisNotification.userInfo as? [String: String] {
                    if userinfo["style"] == "pillPerDay" {
                        app.cancelLocalNotification(thisNotification)
                    }
                }
            }
            
        }
        
        let notification = UILocalNotification()
        notification.alertBody = "💊 Zeit für die Pille"
        notification.alertAction = "Öffnen"
        notification.category = "PILL_CATEGORY"
        //notification.fireDate = Date(timeIntervalSinceReferenceDate: GlobalValues.getTimePerDayAsInterval())
        notification.repeatInterval = NSCalendar.Unit.day
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["style": "pillPerDay"]
        UIApplication.shared.scheduleLocalNotification(notification)
        
        cancelAllStressNotifications()
        //setStressNotificationsOnForgotten(GlobalValues.getTimePerDayAsInterval())
    }
    
    func setStressNotificationsOnForgotten(_ forDay: TimeInterval) {
        let notification1 = UILocalNotification()
        notification1.alertBody = "💊 Du hast die Pille noch immer nicht genommen!"
        notification1.alertAction = "Öffnen"
        notification1.category = "PILL_CATEGORY"
        notification1.fireDate = Date(timeIntervalSinceReferenceDate: forDay+60)
        notification1.repeatInterval = NSCalendar.Unit.hour
        notification1.soundName = UILocalNotificationDefaultSoundName
        notification1.userInfo = ["style": "pillStressAlert"]
        UIApplication.shared.scheduleLocalNotification(notification1)
        
        let notification2 = UILocalNotification()
        notification2.alertBody = "💊 Los Los 😇"
        notification2.alertAction = "Öffnen"
        notification2.category = "PILL_CATEGORY"
        notification2.fireDate = Date(timeIntervalSinceReferenceDate: forDay+60*5)
        notification2.repeatInterval = NSCalendar.Unit.hour
        notification2.soundName = UILocalNotificationDefaultSoundName
        notification2.userInfo = ["style": "pillStressAlert"]
        UIApplication.shared.scheduleLocalNotification(notification2)
        
        let notification3 = UILocalNotification()
        notification3.alertBody = "💊 Jetzt nimm endlich die Pille!"
        notification3.alertAction = "Öffnen"
        notification3.category = "PILL_CATEGORY"
        notification3.fireDate = Date(timeIntervalSinceReferenceDate: forDay+60*20)
        notification3.repeatInterval = NSCalendar.Unit.hour
        notification3.soundName = UILocalNotificationDefaultSoundName
        notification3.userInfo = ["style": "pillStressAlert"]
        UIApplication.shared.scheduleLocalNotification(notification3)
    }
    
    func cancelAllStressNotifications() {
        let app = UIApplication.shared
        if let searchedNotifications = app.scheduledLocalNotifications {
            for thisNotification in searchedNotifications {
                if let userinfo = thisNotification.userInfo as? [String: String] {
                    if userinfo["style"] == "pillStressAlert" {
                        app.cancelLocalNotification(thisNotification)
                    }
                }
            }
            
        }
    }
    
    func cancelStressNotificationsOnForgotten() {
        let app = UIApplication.shared
        if let searchedNotifications = app.scheduledLocalNotifications {
            for thisNotification in searchedNotifications {
                if let userinfo = thisNotification.userInfo as? [String: String] {
                    if userinfo["style"] == "pillStressAlert" {
                        app.cancelLocalNotification(thisNotification)
                    }
                }
            }
            
        }
        
        //setStressNotificationsOnForgotten(GlobalValues.getTimePerDayAsInterval()+60*60*24)
    }
}
