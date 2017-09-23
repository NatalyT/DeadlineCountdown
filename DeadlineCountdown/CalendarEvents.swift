//
//  CalendarEvents.swift
//  DeadlineCountdown
//
//  Created by Nataly Tatarintseva on 9/19/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class CalendarEvents {
    
    let eventStore = EKEventStore()
    
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            requestAccessToCalendar()
            break
        case EKAuthorizationStatus.authorized:
            break
        default: break
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
        })
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date) -> String {
        let event = EKEvent(eventStore: eventStore)
        
        if (EKEventStore.authorizationStatus(for: .event) == EKAuthorizationStatus.authorized) {
            event.title = title
            event.isAllDay = true
            event.startDate = startDate
            event.endDate = endDate
            event.notes = description
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            do {
                try eventStore.save(event, span: .thisEvent, commit: true)
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
            }
        }
        return event.eventIdentifier
    }
    
    func removeEvent(savedEventId: String) {
        if (EKEventStore.authorizationStatus(for: .event) == EKAuthorizationStatus.authorized) {
            if let event = eventStore.event(withIdentifier: savedEventId) {
                
                do{
                    try eventStore.remove(event, span: EKSpan.thisEvent)
                }
                catch let error {
                    print("Error removing events: ", error)
                }
            }
        }
    }
    
    func editEvent(savedEventId: String, title: String, startDate: Date, endDate: Date) {
        if (EKEventStore.authorizationStatus(for: .event) == EKAuthorizationStatus.authorized) {
            if let event = eventStore.event(withIdentifier: savedEventId) {
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                
                do {
                    try eventStore.save(event, span: .thisEvent, commit: true)
                } catch {
                    print("Error editing")
                }

            }
        }
    }

}
