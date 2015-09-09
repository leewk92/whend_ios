//
//  WallTableViewController.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 7..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class WallTableViewController: UITableViewController {

    var schedules:[Schedule] = []
//    let data:NSDictionary = ["id":0,"title":"hi","allday":true, "like_count":0,"follow_count":0,"comment_count":0, "isLike":true, "isFollow":true ]
    let schedule1 = Schedule()
  //  schedules.append(Schedule())
    
    override func viewDidLoad() {
        schedules.append(Schedule())
        super.viewDidLoad()
//        self.tableView.registerClass(WallTableViewCell.self, forHeaderFooterViewReuseIdentifier: "ScheduleItem")
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
         print(self.schedules.count)
        return self.schedules.count
    }
    
    private struct StoryBoard {
        static let CellReuseIdentifier = "ScheduleItem"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        var cell:WallTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ScheduleItem") as! WallTableViewCell
        
        
       let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellReuseIdentifier, forIndexPath: indexPath) as! WallTableViewCell
//        schedule.append(Schedule())
        cell.schedule = self.schedules[indexPath.row]
        print(cell.schedule?.title)
        //        cell.textLabel?.text = tweet.text
        //        cell.detailTextLabel?.text = tweet.user.name
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
