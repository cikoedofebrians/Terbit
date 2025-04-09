//
//  NotificationHandler.swift
//  Terbit
//
//  Created by Syaoki Biek on 06/04/25.
//

import Foundation
import Observation
import UserNotifications

@Observable
class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    // set to store notification identifiers
    var notificationIdentifiers: Set<String> = []
    
    func askForNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleNotification(hour: Int, minute: Int, weekdays: [Int]) {
        
        let content = UNMutableNotificationContent()
        content.title = "Habis gelap terbitlah terang"
        content.body = "Cerahkan harimu dengan aktivitas yang sudah kamu buat!!"
        
        for weekday in weekdays {
            var dateComponents = DateComponents()
            dateComponents.weekday = weekday
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print( "Notification sent.")
                    }
                }
            }
    }
    
    
    func removeNotification(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        
        print( "Notification with identifier \(identifier) removed.")
        
        // remove identifier from the set
        notificationIdentifiers.remove(identifier)
    }
    
    func removeNotificationForWeekday(_ weekday: Int) {
        
        for identifier in notificationIdentifiers {
            print("Removing notification for weekday \(weekday) with identifier \(identifier)")
            removeNotification(identifier: identifier)
        }
    }
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All notification has been canceled")
    }
}
