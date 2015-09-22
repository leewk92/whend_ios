//
//  NotificationTableViewController.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 19..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class NotificationTableViewController: UITableViewController {

    var notifications:[Notification] = []
    var nextUrl:NSURL?
    var itemCount:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var url:NSURL = NSURL(string: "http://119.81.176.245/notifications/")!
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
        restfulUtil.requestRestSync()
        if let items = restfulUtil.innerResult{
            for item in items{
                if let notification:Notification = Notification(data: item){
                    notifications.append(notification)
                    self.itemCount = self.itemCount + 1
                }
                
            }
        }
        //itemCount = (restfulUtil.innerResult?.count)!
        nextUrl = restfulUtil.nextUrl
        


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        // return 0
        return self.notifications.count
    }
    
    private struct StoryBoard {
        static let CellReuseIdentifier = "NotificationViewCell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //        var cell:WallTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ScheduleItem") as! WallTableViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier, forIndexPath: indexPath) as! NotificationViewCell
        
        //        schedule.append(Schedule())
        cell.notification = self.notifications[indexPath.row]
        //        cell.textLabel?.text = tweet.text
        //        cell.detailTextLabel?.text = tweet.user.name
        // Configure the cell...
        
        //        if let tmpPhoto_dir = cell.schedule?.photo_dir {
        //            var getImageUtil = HTTPRestfulUtilizer()
        //            getImageUtil.getUrlImage(&cell.schedulePhoto, _url: tmpPhoto_dir)
        //        }
        //
        
        //cell.sizeThatFits(CGSize(width: cell.frame.width, height: cell.frame.width/4))
        return cell
    }
    
    // for endless scrolling
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if itemCount - indexPath.row == 3{
            var url:NSURL = nextUrl!
            var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes:HTTPRestfulUtilizer.RestType.GET(url: url))!
            restfulUtil.requestRestSync()
            if let items = restfulUtil.innerResult{
                for item in items{
                    if let notification:Notification = Notification(data: item){
                        notifications.append(notification)
                        self.itemCount = self.itemCount + 1
                    }
                    //                    tableView.reloadData()
                   // self.itemCount = self.itemCount + 1
                }
            }
            // self.itemCount += (restfulUtil.innerResult?.count)!
            nextUrl = restfulUtil.nextUrl
            tableView.reloadData()
        }
    }

}
