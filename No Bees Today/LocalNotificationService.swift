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
    
    public func registerDailyNotifications() {
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "NBTDailyNotificationCategory"
        content.title = "Pille nehmen"
        content.body = "Es ist Zeit deine Pille zu nehmen"
        content.sound = UNNotificationSound.default()
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: GlobalValues.getTimePerDay()!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let identifier = "NBTDailyNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.removePendingNotificationRequests(withIdentifiers: ["NBTDailyNotification"])
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
            }
        })
    }
    
    private func registerStressNotifications() {
        
    }
    
    private func cancelStressNotifications() {
        
    }
    
    /** MARK: UNUserNotificationCenterDelegate **/
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> ()) {
        // Play sound and show alert to the user
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> ()) {
        
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
        print("Genommen")
        self.cancelStressNotifications()
        if let pd = GlobalValues.getCurrentPillDayFromStorage() {
            pd.updateState(state: .pillTaken, result: {
                success in
                
            })
        } else {
            let pd = PillDay(day: GlobalValues.normalizeDate(Date()), state: .pillTaken)
            pd.updateState(result: {
                success in
                if success {
                }
            })
        }
    }
}
