//
//  NotificationManager.swift
//  CountTo
//
//  Created by Michael Rausch on 13/04/20.
//  Copyright © 2020 Michael Rausch. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound]
    let settings = SettingManager()
    
    init() {
        
    }
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("Declined Notifications")
            }
        }
    }
    
    func scheduleNotification(id: String, title: String, body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        if settings.isRemindersEnabled() == false {
            return
        }
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    func cancelNotification(id: String) {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id])
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func removeAllReminders() {
        notificationCenter.getPendingNotificationRequests { (notifications) in
            for notification in notifications {
                let id = notification.identifier
                self.cancelNotification(id: id)
            }
        }
    }
    
    func enableAllReminders() {
        let events = EventRepositoryDatabase().getAll()
        
        for event in events {
            scheduleNotification(id: event.id, title: event.eventName, body: "It's time for \(event.eventName)!", date: event.eventTime)
        }
    }
}
