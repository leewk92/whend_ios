//
//  ViewController.swift
//  whend
//
//  Created by 맥북 on 2015. 8. 22..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

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

    func hi(){
        println("hi")
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
}

