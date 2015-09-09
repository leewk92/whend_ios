//
//  FacebookFriend.swift
//  whend
//
//  Created by macbook on 2015. 9. 8..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation


public class FacebookFriend{
    
    var facebook_username: String
    var whend_username: String
    var user_id: Int
    var facebook_photo: NSURL?
    var isFollow: Bool
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        let facebook_username = data?.valueForKeyPath(FacebookKey.Facebook_Username) as? String
        let whend_username = data?.valueForKeyPath(FacebookKey.Whend_Username) as? String
        let user_id = data?.valueForKeyPath(FacebookKey.User_Id) as? Int
        let facebook_photo = data?.valueForKeyPath(FacebookKey.Facebook_Photo) as? NSURL
        let isFollow = data?.valueForKeyPath(FacebookKey.IsFollow) as? Bool
        if facebook_username != nil {
            self.facebook_username = facebook_username!
            self.whend_username = whend_username!
            self.user_id = user_id!
            self.facebook_photo = facebook_photo
            self.isFollow = isFollow!
            
        }else{
            self.facebook_username = "Unknown"
            self.whend_username = "Unknown"
            self.user_id = 0
            self.isFollow = false
        }
        //return nil
        
    }
    
    init(){
        self.facebook_username = "Unknown"
        self.whend_username = "Unknown"
        self.user_id = 0
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
    
    
    struct FacebookKey {
        
        static let Facebook_Username = "facebook_username"
        static let Whend_Username = "whend_username"
        static let User_Id = "user_id"
        static let Facebook_Photo = "facebook_photo"
        static let IsFollow = "isFollow"
       
    }
    
    
}