//
//  LocalNotificationManager.swift
//  notification
//
//  Created by Emerson Victor on 16/10/19.
//  Copyright © 2019 Emerson Victor. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
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
    
    func getNotificationStatus(completion: @escaping (_ status: UNAuthorizationStatus) -> Void){
        self.notificationCenter.getNotificationSettings { (setting) in
            completion(setting.authorizationStatus)
        }
    }
    
    // MARK: - Creating notifications
    private func scheduleNotification(withTitle title: String, subtitle: String, body: String, badge: Int) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        
        /// Set notification content
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.badge = badge as NSNumber
        content.sound = .default
        
        return content
    }
}
