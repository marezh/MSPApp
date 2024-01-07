//
//  MSPApp.swift
//  MSP
//
//  Created by Marko Lazovic on 03.12.23.
//

import SwiftUI

@main
struct MSPApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            
        }
    }
    class AppDelegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?
        let notificationManager = NotificationManager()

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Benachrichtigungsberechtigungen anfordern
            notificationManager.requestAuthorization()

            // Weitere Initialisierungen
            return true
        }
    }
}

