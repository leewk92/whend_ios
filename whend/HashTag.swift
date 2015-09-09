//
//  HashTag.swift
//  whend
//
//  Created by macbook on 2015. 9. 8..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

public class HashTag{
    
    var id: Int
    var title: String
    var photo: NSURL?
    
    var follower_count: Int
    var count_schedule: Int
    var count_upcoming_schedule: Int
    
    var isFollow: Bool
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        let id = data?.valueForKeyPath(HashTagKey.Id) as? Int
        let title = data?.valueForKeyPath(HashTagKey.Title) as? String
        let photo = data?.valueForKeyPath(HashTagKey.Photo) as? NSURL
        let follower_count = data?.valueForKeyPath(HashTagKey.Follower_Count) as? Int
        let count_schedule = data?.valueForKeyPath(HashTagKey.Count_Schedule) as? Int
        let count_upcoming_schedule = data?.valueForKeyPath(HashTagKey.Count_Upcoming_Schedule) as? Int
        let isFollow = data?.valueForKeyPath(HashTagKey.IsFollow) as? Bool
        
        if id != nil {
            self.id = id!
            self.title = title!
            self.photo = photo
            self.follower_count = follower_count!
            self.count_schedule = count_schedule!
            self.count_upcoming_schedule = count_upcoming_schedule!
            self.isFollow = isFollow!
            
        }else{
            self.id = 0
            self.title = "UnKnown"
            self.follower_count = 0
            self.count_schedule = 0
            self.count_upcoming_schedule = 0
            self.isFollow = false
            
        }
        //return nil
        
    }
    
    init(){
        self.id = 0
        self.title = "UnKnown"
        self.follower_count = 0
        self.count_schedule = 0
        self.count_upcoming_schedule = 0
        self.isFollow = false
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
    
    
    struct HashTagKey {
        
        static let Id = "id"
        static let Title = "title"
        static let Photo = "photo"
        static let Follower_Count = "follower_count"
        static let Count_Schedule = "count_schedule"
        static let Count_Upcoming_Schedule = "count_upcoming_schedule"
        static let IsFollow = "isFollow"
        
    }


}