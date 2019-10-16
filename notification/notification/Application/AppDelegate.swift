//
//  AppDelegate.swift
//  notification
//
//  Created by Emerson Victor on 15/10/19.
//  Copyright © 2019 Emerson Victor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let notificationManager = LocalNotificationManager()
        
        /// Request authorization for notification
        notificationManager.requestAuthorization(withOptions: [.alert, .badge, .sound])
        
        /// Get authorization status
        notificationManager.getNotificationStatus { (status) in
            switch status {
                case .authorized: print("Authorized")
                case .denied: print("Denied")
                case .notDetermined: print("Not dertermied")
                case .provisional: print("Provisional")
                @unknown default: print("Unknown default")
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

