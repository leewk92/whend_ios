//
//  CalendarProvider.swift
//  whend
//
//  Created by macbook on 2015. 9. 16..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation
import EventKit
import UIKit

public class CalendarProvider{
    
    var whendCalendar:EKCalendar?
    var eventStore:EKEventStore
    
    init(){
        
        // Create an Event Store instance
        eventStore = EKEventStore()
        let calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent)
            as! [EKCalendar]
        
        for calendar in calendars {
            if calendar.title == "whenD"{
                self.whendCalendar = calendar
            }
        }
    }
    
    func createCalendar(){
        
        
        // Use Event Store to create a new calendar instance
        // Configure its title
        let newCalendar = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: eventStore)
        newCalendar.title = "whenD"
       
        // Access list of available sources from the Event Store
        let sourcesInEventStore = eventStore.sources() as! [EKSource]
        
        // Filter the available sources and select the "Local" source to assign to the new calendar's
        // source property
        newCalendar.source = sourcesInEventStore.filter{
            (source: EKSource) -> Bool in
            source.sourceType.value == EKSourceTypeLocal.value
            }.first
        
        // Save the calendar using the Event Store instance
        var error: NSError? = nil
        let calendarWasSaved = eventStore.saveCalendar(newCalendar, commit: true, error: &error)
        
        // Handle situation if the calendar could not be saved
        if calendarWasSaved == false {
//            let alert = UIAlertController(title: "Calendar could not save", message: error?.localizedDescription, preferredStyle: .Alert)
//            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            alert.addAction(OKAction)
//            self.presentViewController(alert, animated: true, completion: nil)
            println("Error : calendar wasn't saved")
        } else {
            NSUserDefaults.standardUserDefaults().setObject(newCalendar.calendarIdentifier, forKey: "EventTrackerPrimaryCalendar")
            self.whendCalendar = newCalendar
            println("calendar is created")
        }
    }
    
    
    func insertEvent(schedule : Schedule) {
        
        // 3
//        let startDate = NSDate()
        let startDate = NSDate(timeIntervalSince1970: schedule.starttime_ms!)
        print(startDate)
        let endDate:NSDate
        
        if let endtime_ms = schedule.endtime_ms{
            endDate = NSDate(timeIntervalSince1970: schedule.endtime_ms!)
        }
        else{
            endDate = startDate.dateByAddingTimeInterval(60 * 60)       // 1 hour
        }
        
        // 4
        // Create Event
        var event = EKEvent(eventStore: eventStore)
        event.calendar = whendCalendar
        event.title = schedule.title
        event.startDate = startDate
        event.endDate = endDate
        event.location = schedule.location
        event.notes = schedule.memo
        event.allDay = schedule.allday
        event.timeZone = NSTimeZone.systemTimeZone()
        
        // 5
        // Save Event in Calendar
        var error: NSError?
        let result = eventStore.saveEvent(event, span: EKSpanThisEvent, error: &error)
        
        if result == false {
            if let theError = error {
                println("An error occured \(theError)")
            }
        }
        
    }
    
    
    

}