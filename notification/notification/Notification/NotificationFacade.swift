//
//  NotificationFacade.swift
//  notification
//
//  Created by Emerson Victor on 04/11/19.
//  Copyright © 2019 Emerson Victor. All rights reserved.
//

import Foundation
import UserNotifications
import CoreLocation

final class NotificationFacade {
    // MARK: - Managers
    private let notificationManager = NotificationManager()
    private let localNotificationManager = LocalNotificationManager()
    private let pushNotificationManager = PushNotificationManager()
    
    // MARK: - Notification managers
    // Notification authorization
    func requestAuthorization(withOptions options: UNAuthorizationOptions,
                              completion: @escaping (_ didAllow: Bool, _ error: Error) -> Void) {
        
        self.notificationManager.requestAuthorization(withOptions: options) { (didAllow, error) in
            completion(didAllow, error)
        }
    }
    
    // Notifcation status
    func getNotificationStatus(completion: @escaping (_ status: UNAuthorizationStatus) -> Void){
        self.notificationManager.getNotificationStatus { (status) in
            completion(status)
        }
    }
    
    // MARK: - Local notification
    // Creating notifications
    func crateNotificationContent(title: String,
                                  subtitle: String,
                                  body: String,
                                  badge: Int,
                                  categoryIdentifier: String) -> UNMutableNotificationContent {
        
        return self.localNotificationManager.crateNotificationContent(title: title,
                                                                      subtitle: subtitle,
                                                                      body: body,
                                                                      badge: badge,
                                                                      categoryIdentifier: categoryIdentifier)
    }
    
    // Add custom actions
    func addCustomOptions(_ options: Set<UNNotificationCategory>) {
        self.localNotificationManager.addCustomOptions(options)
    }
    
    // Time based
    func scheduleNotification(withIdentifier identifier: String,
                              content: UNMutableNotificationContent,
                              triggeredBy timeInterval: TimeInterval,
                              repeats: Bool = false) {
        
        self.localNotificationManager.scheduleNotification(withIdentifier: identifier,
                                                           content: content,
                                                           triggeredBy: timeInterval,
                                                           repeats: repeats)
    }
    
    // Calendar based
    func scheduleNotification(withIdentifier identifier: String,
                              content: UNMutableNotificationContent,
                              triggeredBy date: DateComponents, repeats: Bool = false) {
        
        self.localNotificationManager.scheduleNotification(withIdentifier: identifier,
                                                           content: content,
                                                           triggeredBy: date,
                                                           repeats: repeats)
    }
    
    // Location based
    func scheduleNotification(withIdentifier identifier: String,
                              content: UNMutableNotificationContent,
                              triggeredBy location: CLRegion,
                              repeats: Bool = false) {
        
        self.localNotificationManager.scheduleNotification(withIdentifier: identifier,
                                                           content: content,
                                                           triggeredBy: location,
                                                           repeats: repeats)
    }

}
