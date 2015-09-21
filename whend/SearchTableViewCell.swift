//
//  SearchTableViewCell.swift
//  whend
//
//  Created by macbook on 2015. 9. 21..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    var hashtag: HashTag? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var hashtagPhoto: UIImageView!
    @IBOutlet weak var hashtagTitleLabel: UILabel!
    @IBOutlet weak var likeImageView: UIButton!
    func updateUI() {
        
        hashtagTitleLabel?.text = nil
        //schedulePhoto?.image = nil
        if let hashtag = self.hashtag
        {
            hashtagTitleLabel?.text = hashtag.title
           
            
            if let tmpPhoto_dir = hashtag.photo {
                
                getPhoto( &hashtagPhoto, url: tmpPhoto_dir , _imageDestination: HTTPRestfulUtilizer.imageDestination.wall)
            }else{
//                hashtagPhoto.image = UIImage(named: "memo_photo_default1")
                
                hashtagPhoto.image = UIImage()
//                println("defualtScheduleIamge")
            }
            
            // println(schedule.isLike)
            if hashtag.isFollow!{
                likeImageView?.setImage(UIImage(named: "liked"), forState: UIControlState.Normal)
                
            }
            else{
                likeImageView?.setImage(UIImage(named: "like"), forState: UIControlState.Normal)
            }
            likeImageView?.addTarget(self, action: Selector("clickFollowButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    @IBAction func clickFollowButton(sender: UIButton) {
        hashtag?.followButtonClicked()
        updateUI()
        
        var url_string = "http://119.81.176.245/hashtags/\(hashtag!.id!)/follow/"
        println(url_string)
        var url:NSURL = NSURL(string: url_string)!
        var inputDict = ["username": "hashtagfollowbutton", "password": "clicked"] as Dictionary<String, String>
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.PUT(url: url, inputDict: inputDict))!
        restfulUtil.requestRestAsync()
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
