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
    var nextUrl:NSURL?
    var itemCount:Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var url:NSURL = NSURL(string: "http://119.81.176.245/schedules/")!
        var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.GET(url: url))!
        restfulUtil.requestRest()
        if let items = restfulUtil.innerResult{
            for item in items{
                let schedule:Schedule = Schedule(data: item)!
                schedules.append(schedule)
            }
        }
        itemCount = (restfulUtil.innerResult?.count)!
        nextUrl = restfulUtil.nextUrl
        
        /*
        let outputJson = restfulUtil.outputJson!
        
        let success = outputJson.valueForKey("title") as? String
        schedules[0].title = success!
        schedules[0].username = (outputJson.valueForKey("user_name") as? String)!
        */
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    
//    override func viewDidLoad() {
//        schedules.append(Schedule())
//        super.viewDidLoad()
////        self.tableView.registerClass(WallTableViewCell.self, forHeaderFooterViewReuseIdentifier: "ScheduleItem")
//        var params = ["username": "ji" , "password": "gh"]  as Dictionary<String, String>
//        var err: NSError?
//        var url:NSURL = NSURL(string: "http://119.81.176.245/schedules/1/")!
//        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "Get"
//        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error : &err)        //request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
//        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
//        request.setValue("Token a7311a1eebb197a53e330add91d29c05b2fb8f40", forHTTPHeaderField: "Authorization")
//        
//        
//        var reponseError: NSError?
//        var response: NSURLResponse?
//        
//        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
//        
//        if ( urlData != nil ) {
//            let res = response as! NSHTTPURLResponse!;
//            
//            NSLog("Response code: %ld", res.statusCode);
//            
//            var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
//            
//            NSLog("Response ==> %@", responseData);
//            
//            if (res.statusCode >= 200 && res.statusCode < 300)
//            {
//                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
//                
//                NSLog("Response ==> %@", responseData);
//                
//                var error: NSError?
//                
//                let jsonData = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary
//                
//                
//                
//                let success = jsonData.valueForKey("title") as? String
//                
//                //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
//                //let success = jsonData.valueForKey("key") as? String
//                //[jsonData[@"success"] integerValue];
//                
//                print("Success: %@", success!);
//                
//                if((success?.isEmpty) != nil)
//                {
//                    NSLog("Login SUCCESS");
//                    
//                    //var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
////                    prefs.setObject(username, forKey: "USERNAME")
////                    prefs.setInteger(1, forKey: "ISLOGGEDIN")
////                    prefs.synchronize()
//                    schedules[0].title = success!
//
//                    
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                } else {
//                    var error_msg:NSString
//                    
//                    if jsonData["error_message"] as? NSString != nil {
//                        error_msg = jsonData["error_message"] as! NSString
//                    } else {
//                        error_msg = "Unknown Error"
//                    }
//                    var alertView:UIAlertView = UIAlertView()
//                    alertView.title = "Sign in Failed!"
//                    alertView.message = error_msg as String
//                    alertView.delegate = self
//                    alertView.addButtonWithTitle("OK")
//                    alertView.show()
//                    
//                }
//                
//            } else {
//                var alertView:UIAlertView = UIAlertView()
//                alertView.title = "Sign in Failed!"
//                alertView.message = "Connection Failed"
//                alertView.delegate = self
//                alertView.addButtonWithTitle("OK")
//                alertView.show()
//            }
//        } else {
//            var alertView:UIAlertView = UIAlertView()
//            alertView.title = "Sign in Failed!"
//            alertView.message = "Connection Failure"
//            if let error = reponseError {
//                alertView.message = (error.localizedDescription)
//            }
//            alertView.delegate = self
//            alertView.addButtonWithTitle("OK")
//            alertView.show()
//        }
//
//        
//        
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }

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
        //        cell.textLabel?.text = tweet.text
        //        cell.detailTextLabel?.text = tweet.user.name
        // Configure the cell...
        return cell
    }
    
    // for endless scrolling
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if itemCount - indexPath.row == 2{
            var url:NSURL = nextUrl!
            var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes:HTTPRestfulUtilizer.RestType.GET(url: url))!
            restfulUtil.requestRest()
            if let items = restfulUtil.innerResult{
                for item in items{
                    let schedule:Schedule = Schedule(data: item)!
                    schedules.append(schedule)
                }
            }
            self.itemCount += (restfulUtil.innerResult?.count)!
            nextUrl = restfulUtil.nextUrl
            tableView.reloadData()
        }
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
