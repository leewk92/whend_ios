//
//  User.swift
//  whend
//
//  Created by macbook on 2015. 9. 8..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation

public class User{
    
    var username: String
    var firstname: String?
    var lastname: String?
    var id: Int
    var email: String?
    var user_photo: NSURL?
    var gender: String?
    var status: String?
    var schedule_count: Int
    var count_following_user: Int
    var count_following_hashtag: Int
    var count_follower: Int
    var following_user: [Int]?
    var following_hashtag: [Int]?
    var following_schedule: [Int]?
    var like_schedule: [Int]?
    
    
    
    // MARK: - Private Implementation
    
    init?(data: NSDictionary?) {
        let username = data?.valueForKeyPath(UserKey.UserName) as? String
        let firstname = data?.valueForKeyPath(UserKey.FirstName) as? String
        let lastname = data?.valueForKeyPath(UserKey.LastName) as? String
        let id = data?.valueForKeyPath(UserKey.Id) as? Int
        let email = data?.valueForKeyPath(UserKey.Email) as? String
        let user_photo = data?.valueForKeyPath(UserKey.UserPhoto) as? NSURL
        let gender = data?.valueForKeyPath(UserKey.Gender) as? String
        let status = data?.valueForKeyPath(UserKey.Status) as? String
        let schedule_count = data?.valueForKeyPath(UserKey.ScheduleCount) as? Int
        let count_following_user = data?.valueForKeyPath(UserKey.CountFollowingUser) as? Int
        let count_following_hashtag = data?.valueForKeyPath(UserKey.CountFollowingHashtag) as? Int
        let count_follower = data?.valueForKeyPath(UserKey.CountFollower) as? Int
        
        if username != nil && id != nil {
            self.username = username!
            self.id = id!
            self.firstname = firstname
            self.lastname = lastname
            self.email = email
            self.user_photo = user_photo
            self.gender = gender
            self.status = status
            self.schedule_count = schedule_count!
            self.count_following_user = count_following_user!
            self.count_following_hashtag = count_following_hashtag!
            self.count_follower = count_follower!
            
        } else {
            self.username = "UnKnown"
            self.id = 0
            self.schedule_count = 0
            self.count_following_user = 0
            self.count_following_hashtag = 0
            self.count_follower = 0
           
        }
        return nil
    }
    
    var asPropertyList: AnyObject {
        var dictionary = Dictionary<String,String>()
        dictionary[UserKey.UserName] = self.username
        dictionary[UserKey.FirstName] = self.firstname
        dictionary[UserKey.LastName] = self.lastname
        dictionary[UserKey.Id] = self.id.description
        dictionary[UserKey.Email] = self.email
        dictionary[UserKey.UserPhoto] = self.user_photo?.description
        dictionary[UserKey.Gender] = self.gender
        dictionary[UserKey.Status] = self.status
        dictionary[UserKey.ScheduleCount] = self.schedule_count.description
        dictionary[UserKey.CountFollowingUser] = self.count_following_user.description
        dictionary[UserKey.CountFollowingHashtag] = self.count_following_hashtag.description
        dictionary[UserKey.CountFollower] = self.count_follower.description
        dictionary[UserKey.FollowingUser] = self.following_user?.description
        dictionary[UserKey.FollowingHashtag] = self.following_hashtag?.description
        dictionary[UserKey.FollowingSchedule] = self.following_schedule?.description
        dictionary[UserKey.LikeSchedule] = self.like_schedule?.description
        
        return dictionary
    }
    
    
    
    
    struct UserKey {
        static let UserName = "username"
        static let FirstName = "firstname"
        static let LastName = "lastname"
        static let Id = "id"
        static let Email = "email"
        static let UserPhoto = "user_photo"
        static let Gender = "gender"
        static let Status = "status"
        static let ScheduleCount = "schedule_count"
        static let CountFollowingUser = "count_following_user"
        static let CountFollowingHashtag = "count_following_hashtag"
        static let CountFollower = "count_follower"
        static let FollowingUser = "following_user"
        static let FollowingHashtag = "following_hashtag"
        static let FollowingSchedule = "following_schedule"
        static let LikeSchedule = "like_schedule"
        
    }

    
}