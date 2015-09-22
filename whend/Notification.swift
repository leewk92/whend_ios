//
//  Notification.swift
//  whend
//
//  Created by macbook on 2015. 9. 22..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation



public class Notification{
    
    
    var target_id: Int?
    var actor_name: String?
    var actor_name2: String?
    var verb: String?
    var description: String?
    var timestamp: String?
    var unread: Bool?
    var target_type : String?
    var actor_type : String?
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        
        let target_id = data?.valueForKeyPath(NotificationKey.Target_Id) as? Int
        let actor_name = data?.valueForKeyPath(NotificationKey.Actor_Name) as? String
        let actor_name2 = data?.valueForKeyPath(NotificationKey.Actor_Name2) as? String
        let verb = data?.valueForKeyPath(NotificationKey.Verb) as? String
        let description = data?.valueForKeyPath(NotificationKey.Description) as? String
        let timestamp = data?.valueForKeyPath(NotificationKey.Timestamp) as? String
        let unread = data?.valueForKeyPath(NotificationKey.Unread) as? Bool
        let target_type = data?.valueForKeyPath(NotificationKey.Target_Type) as? String
        let actor_type = data?.valueForKeyPath(NotificationKey.Actor_Type) as? String
        
        if target_id != nil {
            
            self.target_id = target_id!
            self.actor_name = actor_name
            self.actor_name2 = actor_name2
            self.verb = verb!
            self.description = description
            self.timestamp = timestamp!
            self.unread = unread!
            self.target_type = target_type!
            self.actor_type = actor_type!
            
        }else{
            
            self.target_id = 0
            self.actor_name = "UnKnown"
            self.actor_name2 = "UnKnown"
            self.verb = "UnKnown"
            self.description = "UnKnown"
            self.timestamp = "UnKnown"
            self.unread = false
            self.target_type = "UnKnown"
            self.actor_type = "UnKnown"
            return nil
        }
        //return nil
        
    }
    
    init(){
        
        self.target_id = 0
        self.actor_name = "UnKnown"
        self.actor_name2 = "UnKnown"
        self.verb = "UnKnown"
        self.description = "UnKnown"
        self.timestamp = "UnKnown"
        self.unread = false
        self.target_type = "UnKnown"
        self.actor_type = "UnKnown"
    }
    //
    //    var asPropertyList: AnyObject {
    //        var dictionary = Dictionary<String,String>()
    //        dictionary[ScheduleKey.Id] = self.id.description
    //        dictionary[ScheduleKey.Title] = self.title
    //        dictionary[ScheduleKey.StartTime] = self.starttime
    //        dictionary[ScheduleKey.EndTime] = self.endtime
    //        dictionary[ScheduleKey.StartTime_ms] = self.starttime_ms?.description
    //        dictionary[ScheduleKey.EndTime_ms] = self.endtime_ms?.description
    //        dictionary[ScheduleKey.Date_Start] = self.date_start
    //        dictionary[ScheduleKey.Date_End] = self.date_end
    //        dictionary[ScheduleKey.Time_Start] = self.time_start
    //        dictionary[ScheduleKey.Time_End] = self.time_end
    //        dictionary[ScheduleKey.Memo] = self.memo
    //        dictionary[ScheduleKey.Location] = self.location
    //        dictionary[ScheduleKey.Photo_Dir] = self.photo_dir?.description
    //        dictionary[ScheduleKey.AllDay] = self.allday.description
    //        dictionary[ScheduleKey.TimeZone] = self.timezone
    //        dictionary[ScheduleKey.Color] = self.color
    //        dictionary[ScheduleKey.Like_Count] = self.like_count.description
    //        dictionary[ScheduleKey.Follow_Count] = self.follow_count.description
    //        dictionary[ScheduleKey.Comment_Count] = self.comment_count.description
    //        dictionary[ScheduleKey.IsLike] = self.isLike.description
    //        dictionary[ScheduleKey.IsFollow] = self.isFollow.description
    //
    //        return dictionary
    //    }
    //
    
    
    struct NotificationKey {
        
        static let Target_Id = "target_id"
        static let Actor_Name = "actor_name"
        static let Actor_Name2 = "actor_name2"
        static let Verb = "verb"
        static let Description = "description"
        static let Timestamp = "timestamp"
        static let Unread = "unread"
        static let Target_Type = "target_type"
        static let Actor_Type = "actor_type"
    }
}

