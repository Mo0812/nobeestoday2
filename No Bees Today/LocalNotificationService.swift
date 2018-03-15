//
//  LocalNotificationService.swift
//  No Bees Today
//
//  Created by Moritz Kanzler on 26.05.17.
//  Copyright © 2017 Moritz Kanzler. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationService: NSObject, UNUserNotificationCenterDelegate {
    
    static let tomorrow: TimeInterval = 60 * 60 * 24
    static let shared = LocalNotificationService()
    private var center: UNUserNotificationCenter
    
    override init() {
        self.center = UNUserNotificationCenter.current()
        super.init()
        self.initNotificationService()
        self.initNotificationActions()
    }
    
    private func initNotificationService() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        self.center.requestAuthorization(options: options, completionHandler: {
            granted, error in
            if !granted {
                //TODO
            }
        })
    }
    
    private func initNotificationActions() {
        let takenAction = UNNotificationAction(identifier: "NBTPillTakenAction", title: "Pille genommen", options: [])
        let snoozeAction = UNNotificationAction(identifier: "NBTPillRemindMeLater", title: "Später erinnern", options: [])
        
        let pillReminderCategory = UNNotificationCategory(identifier: "NBTDailyNotificationCategory", actions: [takenAction, snoozeAction], intentIdentifiers: [], options: [])
        self.center.setNotificationCategories([pillReminderCategory])
        
        self.center.delegate = self
    }
    
    public func registerDailyNotifications(forDate: Date) {
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "NBTDailyNotificationCategory"
        content.title = "Pille nehmen"
        content.body = "Es ist Zeit deine Pille zu nehmen"
        content.sound = UNNotificationSound.default()
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: forDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let identifier = "NBTDailyNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        self.center.removeAllDeliveredNotifications()
        self.center.removeAllPendingNotificationRequests()
        self.center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
            }
        })
        
        
    }
    
    private func removeStressNotifications() {
        self.center.removePendingNotificationRequests(withIdentifiers: ["NBTStressNotification1", "NBTStressNotification2", "NBTStressNotification3"])
    }
    
    private func registerStressNotifications(forDate: Date) {
        self.generateStressNotification(identifierSuffix: "1", forDate: forDate.addingTimeInterval(60 * 0.5), title: "Deine Pille wartet auf dich", body: "Du hast die Pille immer noch nicht genommen, jetzt aber wirklich!")
        self.generateStressNotification(identifierSuffix: "2", forDate: forDate.addingTimeInterval(60 * 1), title: "Deine Pille wartet auf dich", body: "Du hast die Pille immer noch nicht genommen, jetzt aber wirklich!")
        self.generateStressNotification(identifierSuffix: "3", forDate: forDate.addingTimeInterval(60 * 60), title: "Deine Pille wartet auf dich", body: "Du hast die Pille immer noch nicht genommen, jetzt aber wirklich!")

    }
    
    private func generateStressNotification(identifierSuffix: String, forDate: Date, title: String, body: String) {
        let identifier = "NBTStressNotification" + identifierSuffix
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "NBTDailyNotificationCategory"
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: forDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
                // Something went wrong
                print("Error in Stress Notifications")
            }
        })
    }
    
    /** MARK: UNUserNotificationCenterDelegate **/
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> ()) {
        // Play sound and show alert to the user
        completionHandler([.alert,.sound])
        if notification.request.identifier == "NBTDailyNotification" {
            self.registerStressNotifications(forDate: GlobalValues.getTimePerDay()!)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> ()) {
        
        GlobalValues.updateCurrentTakingPeriodOnCycleChange()
        
        // Determine the user action
        switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:
                print("Dismiss Action")
            case UNNotificationDefaultActionIdentifier:
                print("Default")
            case "NBTPillTakenAction":
                self.pillTakenAction()
            case "NBTPillRemindMeLater":
                print("Snooze")
            default:
                print("Unknown action")
        }
        completionHandler()
    }
    
    func pillTakenAction() {
        self.pillTakenAction(completionHandler: {})
    }
    
    func pillTakenAction(completionHandler: @escaping () -> ()) {
        print("Genommen")
        self.removeStressNotifications()
        //self.registerStressNotifications(forDate: GlobalValues.getTimePerDay()!)
        if let pd = GlobalValues.getCurrentPillDayFromStorage() {
            pd.updateState(state: .pillTaken, result: {
                success in
                completionHandler()
            })
        } else {
            let pd = PillDay(day: GlobalValues.normalizeDate(Date()), state: .pillTaken)
            pd.updateState(result: {
                success in
                if success {
                    completionHandler()
                }
            })
        }
    }
}
