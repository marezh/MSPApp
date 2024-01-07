//
//  Notification.swift
//  MSP
//
//  Created by Marko Lazovic on 06.01.24.
//

import Foundation


import UserNotifications

class NotificationManager {
    let notificationCenter = UNUserNotificationCenter.current()

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            // Handle errors or success
        }
    }

    func scheduleNotifications() {
        scheduleNotification(atHour: 18, minute: 0)
        scheduleNotification(atHour: 20, minute: 0)
    }

    private func scheduleNotification(atHour hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Erinnerung"
        content.body = "Hast du für Heute deine Daten schon erfasst?"

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            // Handle errors
        }
    }
}

