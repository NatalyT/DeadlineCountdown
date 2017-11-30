//
//  LocalNotifications.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 11/26/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotifications {
    let initialNotificationInDays = 7
    let finalNotificationInDays = 1
    
    func create(selectedDate: Date, titleOfDate: String) {
        let deadline = DeadlineCalculator(selectedDate).calculate()
        if (deadline.days > initialNotificationInDays) {
            scheduleNotification(at: calculateNotificationDate(date: selectedDate, days: initialNotificationInDays), titleOfDate: titleOfDate, days: initialNotificationInDays)
        }
        scheduleNotification(at: calculateNotificationDate(date: selectedDate, days: finalNotificationInDays), titleOfDate: titleOfDate, days: finalNotificationInDays)
    }
    
    func scheduleNotification(at date: Date, titleOfDate: String, days: Int) {
        let calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents(in: .current, from: date)
        components.hour = 8
        components.minute = 0
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = notificationContent(titleOfDate: titleOfDate, days: days)
        
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    func notificationContent(titleOfDate: String, days: Int) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Deadline Countdown"
        content.body = "Till \(titleOfDate) left \(days) day(s)"
        content.sound = UNNotificationSound.default()
        return content
    }
    
    func calculateNotificationDate(date: Date, days: Int) -> Date {
        var components = DateComponents()
        components.day = -1 * days
        return Calendar.current.date(byAdding: components, to: date)!
    }
}
