//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by 맥북 on 2015. 8. 20..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!

    func updateUI() {
    tweetTextLabel?.attributedText = nil
    tweetScreenNameLabel?.text = nil
    tweetProfileImageView?.image = nil
 //   tweetCreatedLabel?.text = nil
    
    if let tweet = self.tweet
    {


        tweetTextLabel?.text = tweet.text
        if tweetTextLabel?.text != nil {
            for _ in tweet.media {
                tweetTextLabel.text! += " 📷"
            }
        }
        
        

    
    tweetScreenNameLabel?.text = "\(tweet.user)"
    
//    self.tweetProfileImageView?.image = nil
    if let profileImageURL = tweet.user.profileImageURL {
    dispatch_async(dispatch_get_global_queue(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 ? Int(QOS_CLASS_USER_INITIATED.value) : DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
    let imageData = NSData(contentsOfURL: profileImageURL)
    dispatch_async(dispatch_get_main_queue()) {
    if profileImageURL == tweet.user.profileImageURL {
    if imageData != nil {
    self.tweetProfileImageView?.image = UIImage(data: imageData!)
    }
    }
    }
    }
    }
    /*
    let formatter = NSDateFormatter()
    if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
    } else {
    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
    }
    tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
    
    if tweet.hashtags.count + tweet.urls.count + tweet.userMentions.count + tweet.media.count > 0 {
    accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    } else {
    accessoryType = UITableViewCellAccessoryType.None
    }*/
    }
    }

}
