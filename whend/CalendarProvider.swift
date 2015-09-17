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

            println("Error : calendar wasn't saved")
        } else {
            NSUserDefaults.standardUserDefaults().setObject(newCalendar.calendarIdentifier, forKey: "EventTrackerPrimaryCalendar")
            self.whendCalendar = newCalendar
            println("calendar is created")
        }
        
        
    }
    
    func checkCalendar() -> EKCalendar{
        var retCal: EKCalendar?
        var calendarSource: EKSource?
        var count = 0
        let calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent) as! [EKCalendar] // Grab every calendar the user has
        var exists: Bool = false
        for calendar in calendars { // Search all these calendars
            if calendar.title == "whenD" {
                exists = true
                retCal = calendar
            }
            
            if calendar.source.title == "iCloud"{
                calendarSource = calendar.source
                count = count + 1
            }
            
        }
        if count == 0{
            self.createCalendar()
            calendarSource = eventStore.defaultCalendarForNewEvents.source
        }
        
        var err : NSError?
        if !exists {
            
            let eventStore = EKEventStore()
            let newCalendar = EKCalendar(forEntityType:EKEntityTypeEvent, eventStore:eventStore)
            newCalendar.title="whenD"
            
            newCalendar.source = calendarSource!;           eventStore.saveCalendar(newCalendar, commit:true, error:&err)
            
            retCal = newCalendar
        }
        
        self.whendCalendar = retCal!
        return retCal!
    }
    
    
    func insertEvent(schedule : Schedule) {

                
        // Create Event
        var event = EKEvent(eventStore: eventStore)
        
        event.allDay = schedule.allday
        event.calendar = checkCalendar()
        event.title = schedule.title
        
        //event.allDay = schedule.allday
        
        event.startDate = schedule.startDate
        event.endDate = schedule.endDate
        event.location = schedule.location
        event.notes = schedule.memo
        
        event.timeZone = NSTimeZone.localTimeZone()
        
        println(schedule.startDate)
        println(schedule.endDate)
        println(event.allDay)
        println(true)
        
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
    
    func removeEvent(schedule: Schedule) -> Bool{
        var calendar = checkCalendar()
        if calendar.allowsContentModifications == false{
            println("The selected calendar does not allow modifications.")
            return false
        }
        var result = false
        
        let predicate = eventStore.predicateForEventsWithStartDate(schedule.startDate, endDate: schedule.endDate, calendars: [calendar] )
        let events_nilable = eventStore.eventsMatchingPredicate(predicate) as? [EKEvent]
        if let events = events_nilable{
            if events.count > 0{
                for event in events{
                    var error:NSError?
                    if event.title == schedule.title{
                        if eventStore.removeEvent(event, span: EKSpanThisEvent, commit: false, error: &error) == false{
                            if let theError = error{
                                println("Failed to remove \(event) with error = \(theError)")
                            }
                        }
                        
                    }
                    
                }
                var error2:NSError?
                if eventStore.commit(&error2){
                    println("Successfully committed")
                    result = true
                } else if let theError = error2{
                    println("Failed to commit the event store with error = \(theError)")
                }
                
            } else {
                println("No events matched your input.")
            }
        }
        return result
    }
    
    func loadCalendars() -> [EKCalendar]{
        var calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent) as? [EKCalendar]
        return calendars!
    }
    
    
    

}