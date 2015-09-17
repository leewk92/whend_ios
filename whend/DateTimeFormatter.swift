//
//  DateTimeFormatter.swift
//  whend
//
//  Created by macbook on 2015. 9. 17..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

extension Int {
    func string(integerDigits:Int) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = integerDigits
        formatter.maximumIntegerDigits = integerDigits
        return formatter.stringFromNumber(self) ?? "\(self)"
    }
}

class DateTimeFormatter{
    
    
    func stringToDate(date: String) -> Double
    {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date_value = dateFormatter.dateFromString(date)
        
        return date_value!.timeIntervalSince1970 as Double
    }
    
    func DateToStringDate(date: NSDate) -> String{
        let component = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone.localTimeZone(), fromDate: date)
        let stringDate = "\(getWeekdayInString(component.weekday)) \(component.month) / \(component.day)"
        
        return stringDate
    }
    
    func DateToStringTime(date: NSDate) -> String{
        let component = NSCalendar.currentCalendar().componentsInTimeZone(NSTimeZone.localTimeZone(), fromDate: date)
        
        let stringTime = "\(component.hour.string(2)) : \(component.minute.string(2))"
        
        return stringTime
    }
    
    func getWeekdayInString(weekday: Int)->String{
        switch weekday{
        case 1 : return "Mon"
        case 2 : return "Tue"
        case 3 : return "Wed"
        case 4 : return "Thu"
        case 5 : return "Fri"
        case 6 : return "Sat"
        case 7 : return "Sun"
        default: return ""
        }
    }
    
}