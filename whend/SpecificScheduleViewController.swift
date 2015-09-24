//
//  SpcificScheduleViewController.swift
//  whend
//
//  Created by macbook on 2015. 9. 22..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class SpecificScheduleViewController : UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    
    var comments:[Comment] = []
    var nextUrl:NSURL?
    var itemCount:Int = 0

    var schedule: Schedule?
    
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        updateUI()
        
        
        
        
        var url:NSURL = NSURL(string: "http://119.81.176.245/schedules/\(schedule!.id!)/comments/")!
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
        restfulUtil.requestRestSync()
        if let items = restfulUtil.innerResult{
            for item in items{
                let comment:Comment = Comment(data: item)!
                comments.append(comment)
            }
        }
        itemCount = (restfulUtil.innerResult?.count)!
        nextUrl = restfulUtil.nextUrl
        
        var tableView:UITableView = UITableView(frame:self.view.viewWithTag(1)!.frame)
        
        // Register our cell's class for cell reuse
        tableView.registerClass(CommentViewCell.self, forCellReuseIdentifier: "CommentViewCell")
        
        // Set our source and add the tableview to the view
        tableView.dataSource = self
        self.view.viewWithTag(1)!.addSubview(tableView)

    }
    
    
    @IBOutlet weak var scheduleUserNameLabel: UILabel!
    
    @IBOutlet weak var scheduleTitleLabel: UILabel!
    
    @IBOutlet weak var scheduleStartDateLabel: UILabel!
    
    @IBOutlet weak var scheduleStartTimeLabel: UILabel!
    
    @IBOutlet weak var scheduleEndDateLabel: UILabel!
    
    @IBOutlet weak var scheduleEndTimeLabel: UILabel!
    
    @IBOutlet weak var scheduleLocationLabel: UILabel!
    
    @IBOutlet weak var scheduleLikeLabel: UILabel!
    
    @IBOutlet weak var scheduleFollowLabel: UILabel!
    
    @IBOutlet weak var scheduleCommentLabel: UILabel!
    
    @IBOutlet weak var schedulePhoto: UIImageView!
    
    @IBOutlet weak var userPhoto: UIImageView!
    
    @IBOutlet weak var likeImageView: UIButton!
    
    @IBOutlet weak var scheduleMemoLabel: UILabel!
    
    func updateUI() {
        scheduleUserNameLabel?.text = nil
        scheduleTitleLabel?.text = nil
        scheduleStartDateLabel?.text = nil
        scheduleStartTimeLabel?.text = nil
        scheduleEndDateLabel?.text = nil
        scheduleEndTimeLabel?.text = nil
        scheduleLocationLabel?.text = nil
        scheduleLikeLabel?.text = nil
        scheduleFollowLabel?.text = nil
        scheduleCommentLabel?.text = nil
        scheduleMemoLabel?.text = nil
        //schedulePhoto?.image = nil
        if let schedule = self.schedule
        {
            scheduleUserNameLabel?.text = schedule.username
            scheduleTitleLabel?.text = schedule.title
            scheduleStartDateLabel?.text = DateTimeFormatter().DateToStringDate(schedule.startDate!)
            scheduleStartTimeLabel?.text = DateTimeFormatter().DateToStringTime(schedule.startDate!)
            scheduleEndDateLabel?.text = DateTimeFormatter().DateToStringDate(schedule.endDate!)
            scheduleEndTimeLabel?.text = DateTimeFormatter().DateToStringTime(schedule.endDate!)
            scheduleLocationLabel?.text = schedule.location
            scheduleLikeLabel?.text = String( schedule.like_count!)
            scheduleFollowLabel?.text = String(schedule.follow_count!)
            scheduleCommentLabel?.text = String(schedule.comment_count!)
            scheduleMemoLabel?.text = String(schedule.memo!)
            
            if let tmpPhoto_dir = schedule.photo_dir {
                
                getPhoto( &schedulePhoto, url: tmpPhoto_dir , _imageDestination: HTTPRestfulUtilizer.imageDestination.wall)
            }else{
                schedulePhoto.image = UIImage(named: "memo_photo_default1")
                println("defualtScheduleIamge")
            }
            if let tmpUserPhoto_dir = schedule.user_photo {
                
                getPhoto( &userPhoto, url: tmpUserPhoto_dir, _imageDestination: HTTPRestfulUtilizer.imageDestination.profile)
            }else{
                userPhoto.image = UIImage(named:"UserImage_Default")
                println("deaultuserImage")
            }
            
            // println(schedule.isLike)
            if schedule.isLike!{
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
        
        var url_string = "http://119.81.176.245/schedules/\(schedule!.id!)/like/"
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
    
    @IBAction func clickFollowButton(sender: UIButton) {
        
        
        
        var url_string = "http://119.81.176.245/schedules/\(schedule!.id!)/follow/"
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
        
        var cp = CalendarProvider()
        if schedule!.isFollow! {
            cp.removeEvent(schedule!)
        }
        else{
            cp.insertEvent(schedule!)
        }
        schedule?.followButtonClicked()
        updateUI()
    }
    
    @IBAction func clickCommentButton(sender: UIButton) {
        
      
        self.performSegueWithIdentifier("goto_comments", sender: self)
        
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        // return 0
        return self.comments.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        var cell:WallTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ScheduleItem") as! WallTableViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier , forIndexPath: indexPath) as! CommentViewCell
        //        schedule.append(Schedule())
        cell.comment = self.comments[indexPath.row]
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
        
        if itemCount - indexPath.row == 3{
            var url:NSURL = nextUrl!
            var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes:HTTPRestfulUtilizer.RestType.GET(url: url))!
            restfulUtil.requestRestSync()
            if let items = restfulUtil.innerResult{
                for item in items{
                    let comment:Comment = Comment(data: item)!
                    comments.append(comment)
                    //                    tableView.reloadData()
                    //                    self.itemCount = self.itemCount + 1
                }
            }
            self.itemCount += (restfulUtil.innerResult?.count)!
            nextUrl = restfulUtil.nextUrl
            
            tableView.reloadData()
        }
    }
    
    private struct StoryBoard {
        static let CellReuseIdentifier = "CommentViewCell"
        static let CommenSegueIdentifier = "goto_comments"
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryBoard.CommenSegueIdentifier {
            if let destination = segue.destinationViewController as? CommentTableViewController {
                destination.schedule = self.schedule
                
            }
        }
    }

    
}
