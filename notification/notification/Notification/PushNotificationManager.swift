//
//  PushNotificationManager.swift
//  notification
//
//  Created by Emerson Victor on 04/11/19.
//  Copyright © 2019 Emerson Victor. All rights reserved.
//

import Foundation
import UIKit

final class PushNotificationManager: NotificationManager {
    // MARK: - Register for remote notification
    func registerRemoteNotification() {
        self.getNotificationStatus { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                  UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}
