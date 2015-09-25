//
//  UserViewController.swift
//  whend
//
//  Created by macbook on 2015. 9. 25..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var schedules:[Schedule] = []
    var nextUrl:NSURL?
    var itemCount:Int = 0
    
    var user: User?
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        
        
        // 밑에 주석단애들 없어야 작동합니다...
        //        // Register our cell's class for cell reuse
        //        tableView.registerClass(CommentViewCell.self, forCellReuseIdentifier: "CommentViewCell")
        //
        //        // Set our source and add the tableview to the view
        //        tableView.dataSource = self
        //        tableView.delegate = self
        
        tableView.rowHeight = tableView.frame.width/2
        self.view.addSubview(tableView)
        
        
        
        var url:NSURL = NSURL(string: "http://119.81.176.245/userinfos/")!
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
        restfulUtil.requestRestSync()
        self.user = User(data: restfulUtil.outputJson)
        
        updateUI()
        
        
        var url_schedule:NSURL = NSURL(string: "http://119.81.176.245/userinfos/\(user!.id)/schedules")!
        
        var restfulUtil_schedule:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url_schedule))!
        restfulUtil_schedule.requestRestSync()
        if let items = restfulUtil_schedule.innerResult{
            for item in items{
                let schedule:Schedule = Schedule(data: item)!
                schedules.append(schedule)
            }
        }
        itemCount = (restfulUtil_schedule.innerResult?.count)!
        nextUrl = restfulUtil_schedule.nextUrl
        
        // var tableView:UITableView = UITableView(frame:self.view.viewWithTag(1)!.frame)
        
        
    }
    
    
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var postCountLabel: UILabel!
    
    @IBOutlet weak var follwerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
   
    
    func updateUI() {
        userIdLabel?.text = nil
        postCountLabel?.text = nil
        follwerCountLabel?.text = nil
        followingCountLabel?.text = nil
        userNameLabel?.text = nil
        userPhotoImageView?.image = nil
        
        if let user = self.user
        {
            userIdLabel?.text = user.username
            postCountLabel?.text = String(user.schedule_count)
            
            follwerCountLabel?.text = String(user.count_follower)
            followingCountLabel?.text = String( user.count_following_hashtag + user.count_following_user)
            userNameLabel?.text = "\(user.lastname!) \(user.firstname!)"
          
            if let tmpPhoto_dir = user.user_photo {
                
                getPhoto( &userPhotoImageView, url: tmpPhoto_dir , _imageDestination: HTTPRestfulUtilizer.imageDestination.profile)
            }else{
                userPhotoImageView.image = UIImage(named:"UserImage_Default")
            }
            //likeImageView.addTarget(self, action: Selector("clickLikeButton:"), forControlEvents: UIControlEvents.TouchUpInside)
            
        }
    }
    
//    
//    @IBAction func clickLikeButton(sender: UIButton) {
//        
//        schedule?.likeButtonClicked()
//        updateUI()
//        
//        var url_string = "http://119.81.176.245/schedules/\(schedule!.id!)/like/"
//        println(url_string)
//        var url:NSURL = NSURL(string: url_string)!
//        var inputDict = ["username": "useless", "password": "data"] as Dictionary<String, String>
//        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.PUT(url: url, inputDict: inputDict))!
//        restfulUtil.requestRestAsync()
//        
//        //
//        //        url_string = "http://119.81.176.245/schedules/\(schedule!.id)/"
//        //        url = NSURL(string: url_string)!
//        //        restfulUtil = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
//        //        restfulUtil.requestRest()
//        //        var new_schedule = Schedule(data: restfulUtil.outputJson)
//        //        self.schedule = new_schedule
//        //        updateUI()
//    }
//    
//    @IBAction func clickFollowButton(sender: UIButton) {
//        
//        
//        
//        var url_string = "http://119.81.176.245/schedules/\(schedule!.id!)/follow/"
//        println(url_string)
//        var url:NSURL = NSURL(string: url_string)!
//        var inputDict = ["username": "useless", "password": "data"] as Dictionary<String, String>
//        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.PUT(url: url, inputDict: inputDict))!
//        restfulUtil.requestRestAsync()
//        
//        //
//        //        url_string = "http://119.81.176.245/schedules/\(schedule!.id)/"
//        //        url = NSURL(string: url_string)!
//        //        restfulUtil = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
//        //        restfulUtil.requestRest()
//        //        var new_schedule = Schedule(data: restfulUtil.outputJson)
//        //        self.schedule = new_schedule
//        //        updateUI()
//        
//        var cp = CalendarProvider()
//        if schedule!.isFollow! {
//            cp.removeEvent(schedule!)
//        }
//        else{
//            cp.insertEvent(schedule!)
//        }
//        schedule?.followButtonClicked()
//        updateUI()
//        
//    }
//    
//    @IBAction func clickCommentButton(sender: UIButton) {
//        
//        
//        self.performSegueWithIdentifier("goto_comments", sender: self)
//        
//    }
//    
//    
//    
    func getPhoto( inout photo:UIImageView!, url:NSURL, _imageDestination: HTTPRestfulUtilizer.imageDestination){
        var url:NSURL = url
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer()
        restfulUtil.getUrlImage( &photo, _url: url, _imageDestination: _imageDestination)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        // return 0
        return self.schedules.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        var cell:WallTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ScheduleItem") as! WallTableViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier , forIndexPath: indexPath) as! WallTableViewCell
        //        schedule.append(Schedule())
        cell.schedule = self.schedules[indexPath.row]
        //        cell.textLabel?.text = tweet.text
        //        cell.detailTextLabel?.text = tweet.user.name
        // Configure the cell...
        
        //        if let tmpPhoto_dir = cell.schedule?.photo_dir {
        //            var getImageUtil = HTTPRestfulUtilizer()
        //            getImageUtil.getUrlImage(&cell.schedulePhoto, _url: tmpPhoto_dir)
        //        }
        //
        
        
        return cell
    }
    
    // for endless scrolling
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (itemCount - indexPath.row == 3){
            
            if let url = nextUrl{
                
                // var url:NSURL = nextUrl!
                var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes:HTTPRestfulUtilizer.RestType.GET(url: url))!
                restfulUtil.requestRestSync()
                if let items = restfulUtil.innerResult{
                    for item in items{
                        let schedule:Schedule = Schedule(data: item)!
                        schedules.append(schedule)
                        //                    tableView.reloadData()
                        //                    self.itemCount = self.itemCount + 1
                    }
                }
                self.itemCount += (restfulUtil.innerResult?.count)!
                nextUrl = restfulUtil.nextUrl
                
                tableView.reloadData()
            }
            
        }
    }
    
    private struct StoryBoard {
        static let CellReuseIdentifier = "ScheduleItem"
        static let ScheduleSegueIdentifier = "goto_schedule"
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryBoard.ScheduleSegueIdentifier {
            if let destination = segue.destinationViewController as? SpecificScheduleViewController {
                if let index = tableView.indexPathForSelectedRow()?.row {
                    destination.schedule = schedules[index]
                    
                }
            }
        }
    }
    
}
