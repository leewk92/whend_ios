//
//  HashTag.swift
//  whend
//
//  Created by macbook on 2015. 9. 8..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

public class HashTag{
    
    var id: Int?
    var title: String
    var photo: NSURL?
    
    var follower_count: Int?
    var count_schedule: Int?
    var count_upcoming_schedule: Int?
    
    var isFollow: Bool?
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        let id = data?.valueForKeyPath(HashTagKey.Id) as? Int
        let title = data?.valueForKeyPath(HashTagKey.Title) as? String
        var photo : NSURL? = nil
        if let s_photo = data?.valueForKeyPath(HashTagKey.Photo) as? String{
            photo = NSURL(string: s_photo)
        }
        
        let follower_count = data?.valueForKeyPath(HashTagKey.Follower_Count) as? Int
        let count_schedule = data?.valueForKeyPath(HashTagKey.Count_Schedule) as? Int
        let count_upcoming_schedule = data?.valueForKeyPath(HashTagKey.Count_Upcoming_Schedule) as? Int
        let isFollow = data?.valueForKeyPath(HashTagKey.IsFollow) as? Bool
        
        if data != nil {
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
    var asPropertyList: AnyObject {
        var dictionary = Dictionary<String,AnyObject>()
//        dictionary[HashTagKey.Id] = self.id.description
        dictionary[HashTagKey.Title] = self.title
        dictionary[HashTagKey.Photo] = self.photo
        dictionary[HashTagKey.Follower_Count] = self.follower_count
        dictionary[HashTagKey.Count_Schedule] = self.count_schedule
        dictionary[HashTagKey.Count_Upcoming_Schedule] = self.count_upcoming_schedule
        
        dictionary[HashTagKey.IsFollow] = self.isFollow
        
        return dictionary
    }
    
    
    
    struct HashTagKey {
        
        static let Id = "id"
        static let Title = "title"
        static let Photo = "photo"
        static let Follower_Count = "count_follower"
        static let Count_Schedule = "count_schedule"
        static let Count_Upcoming_Schedule = "count_upcoming_schedule"
        static let IsFollow = "is_follow"
        
    }
    
    
    func followButtonClicked() {
        let isFollow = self.isFollow!
        
        if isFollow {
            self.isFollow = false
            follower_count = follower_count! - 1
        }
        else {
            self.isFollow = true
            follower_count = follower_count! + 1
        }
    }

    


}