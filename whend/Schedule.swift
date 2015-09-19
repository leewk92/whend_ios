//
//  Schedule.swift
//  whend
//
//  Created by macbook on 2015. 9. 8..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

public class Schedule{
    
    var id: Int?
    var title: String
    
    var username: String?
    var user_photo: NSURL?
    var user_id: Int?
    
    var starttime: String?
    var endtime: String?
    var starttime_ms: Double?
    var endtime_ms: Double?
    var date_start: String?
    var date_end: String?
    var time_start: String?
    var time_end: String?
    var startDate: NSDate?
    var endDate: NSDate?
    
    var memo: String?
    var location: String?
    var photo_dir: NSURL?
    var allday: Bool
    var timezone: String?
    var color: String?
    
    var like_count: Int?
    var follow_count: Int?
    var comment_count: Int?
    
    var isLike: Bool?
    var isFollow: Bool?
    var isMaster: Bool?
    
    var hashtags: [Int]?
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        let id = data?.valueForKeyPath(ScheduleKey.Id) as? Int
        let title = data?.valueForKeyPath(ScheduleKey.Title) as? String
        let username = data?.valueForKeyPath(ScheduleKey.UserName) as? String
        var user_photo:NSURL? = nil
        if let s_user_photo = data?.valueForKeyPath(ScheduleKey.User_Photo) as? String{
            user_photo = NSURL(string: s_user_photo)
        }

        let user_id = data?.valueForKeyPath(ScheduleKey.User_Id) as? Int
        let starttime = data?.valueForKeyPath(ScheduleKey.StartTime) as? String
        let endtime = data?.valueForKeyPath(ScheduleKey.EndTime) as? String
        let starttime_ms = DateTimeFormatter().stringToTimestamp(starttime!)
        let endtime_ms = DateTimeFormatter().stringToTimestamp(endtime!)
        let date_start = data?.valueForKeyPath(ScheduleKey.Date_Start) as? String
        let date_end = data?.valueForKeyPath(ScheduleKey.Date_End) as? String
        let time_start = data?.valueForKeyPath(ScheduleKey.Time_Start) as? String
        let time_end = data?.valueForKeyPath(ScheduleKey.Time_End) as? String
        
        let memo = data?.valueForKeyPath(ScheduleKey.Memo) as? String
        let location = data?.valueForKeyPath(ScheduleKey.Location) as? String
        var photo_dir:NSURL? = nil
        if let s_photo_dir = data?.valueForKeyPath(ScheduleKey.Photo_Dir) as? String{
            photo_dir = NSURL(string: s_photo_dir)
        }
        let allday = data?.valueForKeyPath(ScheduleKey.AllDay) as? Bool
        let startDate:NSDate?
        let endDate:NSDate?
        // if allday, endtime -1 day
        if allday!{
            startDate = NSDate(timeIntervalSince1970: starttime_ms)
            endDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.CalendarUnitDay, value: -1, toDate: NSDate(timeIntervalSince1970: endtime_ms), options: NSCalendarOptions.MatchNextTime)
        }else {
            startDate = NSDate(timeIntervalSince1970: starttime_ms)
            endDate = NSDate(timeIntervalSince1970: endtime_ms)
        }
//        let allday_string = data?.valueForKeyPath(ScheduleKey.AllDay) as? String
//        let allday:Bool?
//        if allday_string == "false"{
//            allday = false
//        }else {
//            allday = true
//        }
        let timezone = data?.valueForKeyPath(ScheduleKey.TimeZone) as? String
        let color = data?.valueForKeyPath(ScheduleKey.Color) as? String
        let like_count = data?.valueForKeyPath(ScheduleKey.Like_Count) as? Int
        let follow_count = data?.valueForKeyPath(ScheduleKey.Follow_Count) as? Int
        let comment_count = data?.valueForKeyPath(ScheduleKey.Comment_Count) as? Int
        let isLike = data?.valueForKeyPath(ScheduleKey.IsLike) as? Bool
        let isFollow = data?.valueForKeyPath(ScheduleKey.IsFollow) as? Bool
        let isMaster = data?.valueForKeyPath(ScheduleKey.IsMaster) as? Bool
        
        if data != nil {
            self.id = id
            self.title = title!
            self.username = username
            self.user_photo = user_photo
            self.user_id = user_id
            self.starttime = starttime
            self.endtime = endtime
            self.starttime_ms = starttime_ms
            self.endtime_ms = endtime_ms
            self.date_start = date_start
            self.date_end = date_end
            self.time_start = time_start
            self.time_end = time_end
            self.startDate = startDate
            self.endDate = endDate
            self.memo = memo
            self.location = location
            self.photo_dir = photo_dir
            self.allday = allday!
            self.timezone = timezone
            self.color = color
            self.like_count = like_count
            self.follow_count = follow_count
            self.comment_count = comment_count
            self.isLike = isLike
            self.isFollow = isFollow
            self.isMaster = isMaster
        }else{
            self.id = 0
            self.title = "UnKnown"
            self.username = "Unknown"
            self.user_id = 0
            self.allday = false
            self.like_count = 0
            self.follow_count = 0
            self.comment_count = 0
            self.isLike = false
            self.isFollow = false
            self.isMaster = false
            
        }
        //return nil
        
    }
    
    init(){
        self.id = 0
        self.title = "UnKnown"
        self.username = "Unknown"
        self.user_id = 0
        self.allday = false
        self.like_count = 0
        self.follow_count = 0
        self.comment_count = 0
        self.isLike = false
        self.isFollow = false
        self.isMaster = false
    }
    
    var asPropertyList: AnyObject {
        
        var dtf = DateTimeFormatter()
        var dictionary = Dictionary<String,AnyObject>()
//        dictionary[ScheduleKey.Id] = self.id.description
        dictionary[ScheduleKey.Title] = self.title
        dictionary[ScheduleKey.StartTime] = self.starttime

        dictionary[ScheduleKey.EndTime] = self.endtime
//        dictionary[ScheduleKey.StartTime_ms] = self.starttime_ms?.description
//        dictionary[ScheduleKey.EndTime_ms] = self.endtime_ms?.description
//        dictionary[ScheduleKey.Date_Start] = self.date_start
//        dictionary[ScheduleKey.Date_End] = self.date_end
//        dictionary[ScheduleKey.Time_Start] = self.time_start
//        dictionary[ScheduleKey.Time_End] = self.time_end
        dictionary[ScheduleKey.Memo] = self.memo!
        dictionary[ScheduleKey.Location] = self.location!
//        dictionary[ScheduleKey.Photo_Dir] = self.photo_dir?.description
        dictionary[ScheduleKey.AllDay] = (self.allday == true ? "1" : "0")
//        dictionary[ScheduleKey.TimeZone] = self.timezone
//        dictionary[ScheduleKey.Color] = self.color
//        dictionary[ScheduleKey.Like_Count] = self.like_count.description
//        dictionary[ScheduleKey.Follow_Count] = self.follow_count.description
//        dictionary[ScheduleKey.Comment_Count] = self.comment_count.description
//        dictionary[ScheduleKey.IsLike] = self.isLike.description
//        dictionary[ScheduleKey.IsFollow] = self.isFollow.description
//        dictionary[ScheduleKey.IsMaster] = self.isMaster.description
        
//        dictionary[ScheduleKey.HashTag] = self.hashtags!.description
        
        return dictionary
    }
    
    
    
    struct ScheduleKey {
        
        static let Id = "id"
        static let Title = "title"
        static let UserName = "user_name"
        static let User_Photo = "user_photo"
        static let User_Id = "user_id"
        static let StartTime = "start_time"
        static let EndTime = "end_time"
//        static let StartTime_ms = "starttime_ms"
//        static let EndTime_ms = "endtime_ms"
        static let Date_Start = "date_start"
        static let Date_End = "date_end"
        static let Time_Start = "time_start"
        static let Time_End = "time_end"
        static let Memo = "memo"
        static let Location = "location"
        static let Photo_Dir = "photo"
        static let AllDay = "all_day"
        static let TimeZone = "timezone"
        static let Color = "color"
        static let Like_Count = "count_like"
        static let Follow_Count = "count_follow"
        static let Comment_Count = "count_comment"
        static let IsLike = "like"
        static let IsFollow = "follow"
        static let IsMaster = "master"
        static let HashTag = "hashtag"
        
    }
    
    func likeButtonClicked() {
        
        let isLike = self.isLike!
        
        
        if isLike {
            self.isLike = false
            like_count = like_count! - 1
        }
        else {
            self.isLike = true
            like_count = like_count! + 1
        }
    }
    
    func followButtonClicked() {
        let isFollow = self.isFollow!
        
        if isFollow {
            self.isFollow = false
            follow_count = follow_count! - 1
        }
        else {
            self.isFollow = true
            follow_count = follow_count! + 1
        }
    }

}