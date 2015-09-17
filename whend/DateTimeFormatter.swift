//
//  DateTimeFormatter.swift
//  whend
//
//  Created by macbook on 2015. 9. 17..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

class DateTimeFormatter{
    
    func stringToDate(date: String) -> Double
    {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date_value = dateFormatter.dateFromString(date)
        
        return date_value!.timeIntervalSince1970 as Double
    }
}