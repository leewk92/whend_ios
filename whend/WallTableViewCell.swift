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
            println(schedule.photo_dir)
            if let tmpPhoto_dir = schedule.photo_dir {
                //println(tmpPhoto_dir)
                getSchedulePhoto( &schedulePhoto, url: tmpPhoto_dir)
            }
            
        }
    }
    
    func getSchedulePhoto( inout schedulePhoto:UIImageView!, url:NSURL){
        var url:NSURL = url
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer()
        restfulUtil.getUrlImage( &schedulePhoto, _url: url)
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
