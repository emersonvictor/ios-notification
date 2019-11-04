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
        
        let localNotificationManager = LocalNotificationManager()
        let pushNotificationManager = PushNotificationManager()
        
        /// Request authorization for notification
        localNotificationManager.requestAuthorization(withOptions: [.alert, .badge, .sound])
        
        /// Request authorization for push notification
        pushNotificationManager.registerRemoteNotification()
        
        return true
    }

    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    // MARK: - Push notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }
}

