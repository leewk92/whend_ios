//
//  WallTableViewCell.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 7..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class WallTableViewCell: UITableViewCell {
    
    var schedule: Schedule? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var scheduleUserNameLabel: UILabel!
 
    @IBOutlet weak var scheduleTitleLabel: UILabel!
    
    @IBOutlet weak var scheduleDateLabel: UILabel!
    
    @IBOutlet weak var scheduleTimeLabel: UILabel!
    
    @IBOutlet weak var scheduleLocationLabel: UILabel!
    
    @IBOutlet weak var scheduleLikeLabel: UILabel!
    
    @IBOutlet weak var scheduleFollowLabel: UILabel!
    
    @IBOutlet weak var scheduleCommentLabel: UILabel!
    
    @IBOutlet weak var schedulePhoto: UIImageView!
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var likeImageView: UIButton!
    
    func updateUI() {
        scheduleUserNameLabel?.text = nil
        scheduleTitleLabel?.text = nil
        scheduleDateLabel?.text = nil
        scheduleTimeLabel?.text = nil
        scheduleLocationLabel?.text = nil
        scheduleLikeLabel?.text = nil
        scheduleFollowLabel?.text = nil
        scheduleCommentLabel?.text = nil
        //schedulePhoto?.image = nil
        if let schedule = self.schedule
        {
            scheduleUserNameLabel?.text = schedule.username
            scheduleTitleLabel?.text = schedule.title
            scheduleDateLabel?.text = schedule.starttime
            scheduleTimeLabel?.text = schedule.endtime
            scheduleLocationLabel?.text = schedule.location
            scheduleLikeLabel?.text = String(schedule.like_count)
            scheduleFollowLabel?.text = String(schedule.follow_count)
            scheduleCommentLabel?.text = String(schedule.comment_count)
            if let tmpPhoto_dir = schedule.photo_dir {
                
                getPhoto( &schedulePhoto, url: tmpPhoto_dir , _imageDestination: HTTPRestfulUtilizer.imageDestination.wall)
            }
            if let tmpUserPhoto_dir = schedule.user_photo {
                
                getPhoto( &userPhoto, url: tmpUserPhoto_dir, _imageDestination: HTTPRestfulUtilizer.imageDestination.profile)
            }
            
            // println(schedule.isLike)
            if schedule.isLike{
                likeImageView.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
            }
            else{
                likeImageView.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            }
            likeImageView.addTarget(self, action: Selector("clickLikeButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    
    @IBAction func clickLikeButton(sender: UIButton) {
        
        schedule?.likeButtonClicked()
        updateUI()
        
        var url_string = "http://119.81.176.245/schedules/\(schedule!.id)/like/"
        println(url_string)
        var url:NSURL = NSURL(string: url_string)!
        var inputDict = ["username": "useless", "password": "data"] as Dictionary<String, String>
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.PUT(url: url, inputDict: inputDict))!
        restfulUtil.requestRestAsync()
        
//        
//        url_string = "http://119.81.176.245/schedules/\(schedule!.id)/"
//        url = NSURL(string: url_string)!
//        restfulUtil = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
//        restfulUtil.requestRest()
//        var new_schedule = Schedule(data: restfulUtil.outputJson)
//        self.schedule = new_schedule
//        updateUI()
    }
    
    
    func getPhoto( inout photo:UIImageView!, url:NSURL, _imageDestination: HTTPRestfulUtilizer.imageDestination){
        var url:NSURL = url
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer()
        restfulUtil.getUrlImage( &photo, _url: url, _imageDestination: _imageDestination)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
            
}
