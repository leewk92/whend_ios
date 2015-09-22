//
//  NotificationViewCell.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 19..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class NotificationViewCell: UITableViewCell {

    var notification: Notification? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var notificationActorLabel: UILabel!
    @IBOutlet weak var notificationVerbDescriptionLabel: UILabel!
    
    
    func updateUI() {
        
        notificationActorLabel?.text = nil
        notificationVerbDescriptionLabel?.text = nil
        
        if let notification = self.notification
        {
            if notification.actor_type == "user" {
    
                notificationActorLabel?.text = notification.actor_name
            }else if notification.actor_type == "hash tag"{
    
                notificationActorLabel?.text = notification.actor_name2
                
            }
            if let description = notification.description{
                notificationVerbDescriptionLabel?.text = "\(notification.verb!) \n \(description)"
            }else{
                notificationVerbDescriptionLabel?.text = notification.verb!
            }
            
//            
//            likeImageView?.addTarget(self, action: Selector("clickFollowButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func getPhoto( inout photo:UIImageView! , url:NSURL, _imageDestination: HTTPRestfulUtilizer.imageDestination){
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
