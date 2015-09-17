//
//  ViewController.swift
//  whend
//
//  Created by 맥북 on 2015. 8. 22..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            
            //We need to see about NSString
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as! NSString as String
        }
    }

    @IBAction func logoutButton(sender: UIButton) {
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
    
    
    
// for getting calendar permission
    
    let eventStore = EKEventStore()
    
    @IBOutlet weak var needPermissionView: UIView!
    
    var calendars: [EKCalendar]?
    
    override func viewWillAppear(animated: Bool) {
        checkCalendarAuthorizationStatus()
    }
    
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent)
        
        switch (status) {
        case EKAuthorizationStatus.NotDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.Authorized:
            // Things are in line with being able to show the calendars in the table view
            loadCalendars()
            
        case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
            // We need to help them give us permission
            needPermissionView.fadeIn()
        default:
            let alert = UIAlertView(title: "Privacy Warning", message: "You have not granted permission for this app to access your Calendar", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
            (accessGranted: Bool, error: NSError!) in
            
            if accessGranted == true {
                dispatch_async(dispatch_get_main_queue(), {
                    self.loadCalendars()
                    
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.needPermissionView.fadeIn()
                })
            }
        })
    }
    
    func loadCalendars() {
        self.calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent) as? [EKCalendar]
        print(self.calendars)
        
    }
    
   
    @IBAction func goToSettingsButtonTapped(sender: UIButton) {
        let openSettingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(openSettingsUrl!)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let calendars = self.calendars {
            return calendars.count
        }
        
        return 0
    }
    
    
}

