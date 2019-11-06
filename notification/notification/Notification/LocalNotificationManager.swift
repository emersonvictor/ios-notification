//
//  LocalNotificationManager.swift
//  notification
//
//  Created by Emerson Victor on 16/10/19.
//  Copyright © 2019 Emerson Victor. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

final class LocalNotificationManager {
    // MARK: - Notification manager
    let notificationManager = NotificationManager()
    
    // MARK: - Creating notifications
    func crateNotificationContent(title: String, subtitle: String, body: String, badge: Int, categoryIdentifier: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        
        /// Set notification content
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.badge = badge as NSNumber
        content.sound = .default
        content.categoryIdentifier = categoryIdentifier
        
        return content
    }
    
    // MARK: - Create notification request
    private func createNotificationRequest(identifier: String, content: UNMutableNotificationContent, trigger: UNNotificationTrigger) {
        self.notificationManager.getNotificationStatus { (status) in
            if status == .authorized {
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                self.notificationManager.notificationCenter.add(request) { (error) in
                    if let error = error {
                        print("Handle error: \(error)")
                    }
                }
            }
        }
    }
    
    // MARK: - Add custom actions
    func addCustomOptions(_ options: Set<UNNotificationCategory>) {
        self.notificationManager.notificationCenter.setNotificationCategories(options)
    }
    
    
    // MARK: - Schedule notification with trigger
    // Time based
    func scheduleNotification(withIdentifier identifier: String, content: UNMutableNotificationContent, triggeredBy timeInterval: TimeInterval, repeats: Bool = false) {
        
        /// Create trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        
        /// Request notification
        self.createNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    // Calendar based
    func scheduleNotification(withIdentifier identifier: String, content: UNMutableNotificationContent, triggeredBy date: DateComponents, repeats: Bool = false) {
        
        /// Create trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)
        
        /// Request notification
        self.createNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    // Location based
    func scheduleNotification(withIdentifier identifier: String, content: UNMutableNotificationContent, triggeredBy location: CLRegion, repeats: Bool = false) {
        
        /// Create trigger
        let trigger = UNLocationNotificationTrigger(region: location, repeats: repeats)
        
        /// Request notification
        self.createNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
}

