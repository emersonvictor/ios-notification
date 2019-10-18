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

class LocalNotificationManager: NSObject {
    
    // MARK: - Variables
    let notificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Get notifcation status
    private func getNotificationStatus(completion: @escaping (_ status: UNAuthorizationStatus) -> Void){
        self.notificationCenter.getNotificationSettings { (setting) in
            completion(setting.authorizationStatus)
        }
    }
    
    // MARK: - Create notification request
    private func createNotificationRequest(identifier: String, content: UNMutableNotificationContent, trigger: UNNotificationTrigger) {
        self.getNotificationStatus { (status) in
            if status == .authorized {
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                self.notificationCenter.add(request) { (error) in
                    if let error = error {
                        print("Handle error: \(error)")
                    }
                }
            }
        }
    }
}

// MARK: - User interface
extension LocalNotificationManager {
    // MARK: - Notification authorization
    func requestAuthorization(withOptions options: UNAuthorizationOptions) {
        self.notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            /// User permission
            if !didAllow {
                print("User didn't allow notification")
            }
            
            /// Error in authorization request
            if let requestError = error {
                print("Error: \(requestError)")
            }
        }
    }
    
    // MARK: - Add custom actions
    func addCustomOptions(_ options: Set<UNNotificationCategory>) {
        self.notificationCenter.setNotificationCategories(options)
    }
    
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

// MARK: - User notification delegate
extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
         didReceive response: UNNotificationResponse,
         withCompletionHandler completionHandler: @escaping () -> Void) {

      // Determine the user action
      switch response.actionIdentifier {
      case UNNotificationDismissActionIdentifier:
        print("Dismiss Action")
      case UNNotificationDefaultActionIdentifier:
        print("Default")
      case "Snooze":
        print("Snooze")
      case "Delete":
        print("Delete")
      default:
        print("Unknown action")
      }
        
      completionHandler()
    }
}
