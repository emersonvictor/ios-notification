//
//  NotificationManager.swift
//  notification
//
//  Created by Emerson Victor on 04/11/19.
//  Copyright © 2019 Emerson Victor. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    // MARK: - Variables
    let notificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Get notifcation status
    func getNotificationStatus(completion: @escaping (_ status: UNAuthorizationStatus) -> Void){
        self.notificationCenter.getNotificationSettings { (setting) in
            completion(setting.authorizationStatus)
        }
    }
    
    // MARK: - Notification authorization
    func requestAuthorization(withOptions options: UNAuthorizationOptions, completion: @escaping (_ status: Bool, _ error: Error) -> Void) {
        self.notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            completion(didAllow, error)
        }
    }
    
    // MARK: - User notification delegate
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
