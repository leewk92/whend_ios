//
//  Comment.swift
//  whend
//
//  Created by macbook on 2015. 9. 8..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

public class Comment{
    
    var id: Int?
    var content: String?
    var write_username: String?
    var wried_userid : Int?
    var write_userphoto: NSURL?
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        let id = data?.valueForKeyPath(CommentKey.Id) as? Int
        let content = data?.valueForKeyPath(CommentKey.Content) as? String
        let write_username = data?.valueForKeyPath(CommentKey.Write_Username) as? String
       // let write_userphoto = data?.valueForKeyPath(CommentKey.Write_Userphoto) as? NSURL
       
        if data != nil {
            self.id = id!
            self.content = content!
            self.write_username = write_username!
            //self.write_userphoto = write_userphoto
            
            
        }else{
            self.id = 0
            self.content = "UnKnown"
            self.write_username = "Unknown"
        }
        //return nil
        
    }
    
    init(){
        self.id = 0
        self.content = "UnKnown"
        self.write_username = "Unknown"
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
    
    
    struct CommentKey {
        
        static let Id = "id"
        static let Content = "content"
        static let Write_Username = "user_name"
        static let Write_UserId = "user_id"
    
    }
    
    
}