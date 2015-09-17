//
//  LoginViewController.swift
//  whend
//
//  Created by 맥북 on 2015. 8. 22..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogInButton(sender: UIButton) {
        
        //Authentication Button
        var username:NSString = usernameText.text
        var password:NSString = passwordText.text
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            //var post:NSString = "{\"username\":\"\(username)",\"password\":\"\(password)\"}"
            var params = ["username": usernameText.text, "password": passwordText.text] as Dictionary<String, String>
            var err: NSError?
            //post = NSJSONSerialization.dataWithJSONObject(params, options: nil, error : &err)
            
            //var post : NSString = "{\"username\":\"taein\",\"password\":\"taeintaein\"}"
            //var err: NSError?
            //var post = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
            //NSLog("PostData: %@",post);
            var url:NSURL = NSURL(string: "http://119.81.176.245/rest-auth/login/")!
            
            var restfulUtil:HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.POST(url: url,inputDict: params))!
            restfulUtil.requestRestSync()
            let outputJson = restfulUtil.outputJson!
            
            let token = outputJson.valueForKey("key") as? String
            
            if((token?.isEmpty) != nil)
            {
                NSLog("Login SUCCESS");
                
                var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                prefs.setObject(username, forKey: "USERNAME")
                prefs.setInteger(1, forKey: "ISLOGGEDIN")
                prefs.setObject(token, forKey:"TOKEN")
                prefs.synchronize()
                
                //create calendar
                var cal = CalendarProvider()
                cal.checkCalendar()
                
               // self.dismissViewControllerAnimated(true, completion: nil)
                self.performSegueWithIdentifier("goto_main", sender: self)
            } else {
                var error_msg:NSString
                
                if outputJson["error_message"] as? NSString != nil {
                    error_msg = outputJson["error_message"] as! NSString
                } else {
                    error_msg = "Unknown Error"
                }
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = error_msg as String
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
                
            }
            
            
//            
//            //var postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
//            //NSLog("PostData: %@",postData);
//            //var postLength:NSString = String( postData.length )
//            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
//            request.HTTPMethod = "POST"
//            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error : &err)        //request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
//            request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
//            
//            
//            var reponseError: NSError?
//            var response: NSURLResponse?
//            
//            var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
//            
//            if ( urlData != nil ) {
//                let res = response as! NSHTTPURLResponse!;
//                
//                NSLog("Response code: %ld", res.statusCode);
//                
//                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
//                
//                NSLog("Response ==> %@", responseData);
//                
//                if (res.statusCode >= 200 && res.statusCode < 300)
//                {
//                    var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
//                    
//                    NSLog("Response ==> %@", responseData);
//                    
//                    var error: NSError?
//                    
//                    let jsonData = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as! NSDictionary
//                    
//                   
//                    
//                    let success = jsonData.valueForKey("key") as? String
//                    
//                    //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
//                    //let success = jsonData.valueForKey("key") as? String
//                    //[jsonData[@"success"] integerValue];
//                    
//                    //NSLog("Success: %@", success);
//                    
//                    if((success?.isEmpty) != nil)
//                    {
//                        NSLog("Login SUCCESS");
//                        
//                        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                        prefs.setObject(username, forKey: "USERNAME")
//                        prefs.setInteger(1, forKey: "ISLOGGEDIN")
//                        prefs.synchronize()
//                        
//                        self.dismissViewControllerAnimated(true, completion: nil)
//                    } else {
//                        var error_msg:NSString
//                        
//                        if jsonData["error_message"] as? NSString != nil {
//                            error_msg = jsonData["error_message"] as! NSString
//                        } else {
//                            error_msg = "Unknown Error"
//                        }
//                        var alertView:UIAlertView = UIAlertView()
//                        alertView.title = "Sign in Failed!"
//                        alertView.message = error_msg as String
//                        alertView.delegate = self
//                        alertView.addButtonWithTitle("OK")
//                        alertView.show()
//                        
//                    }
//                    
//                } else {
//                    var alertView:UIAlertView = UIAlertView()
//                    alertView.title = "Sign in Failed!"
//                    alertView.message = "Connection Failed"
//                    alertView.delegate = self
//                    alertView.addButtonWithTitle("OK")
//                    alertView.show()
//                }
//            } else {
//                var alertView:UIAlertView = UIAlertView()
//                alertView.title = "Sign in Failed!"
//                alertView.message = "Connection Failure"
//                if let error = reponseError {
//                    alertView.message = (error.localizedDescription)
//                }
//                alertView.delegate = self
//                alertView.addButtonWithTitle("OK")
//                alertView.show()
//            }
        }

        /*
        //declare parameter as a dictionary which contains string as key and value combination.
        var parameters = ["name": usernameText.text, "password": passwordText.text] as Dictionary<String, String>
        //create the url with NSURL
        let url = NSURL(string: "http://119.81.176.245/rest-auth/login/") //change the url
        
        //create the session object
        var session = NSURLSession.sharedSession()
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST" //set http method as POST
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(parameters, options: nil, error: &err) // pass dictionary to nsdata object and set it as request body
        
        request.addValue("no-cache", forHTTPHeaderField: "Cashe-Control")
        request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        println("Response: \(response)")
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Body: \(strData)")
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
        
        // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
        if(err != nil) {
        println(err!.localizedDescription)
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: '\(jsonStr)'")
        }
        else {
        // The JSONObjectWithData constructor didn't return an error. But, we should still
        // check and make sure that json has a value using optional binding.
        if let parseJSON = json {
        // Okay, the parsedJSON is here, let's get the value for 'success' out of it
        var success = parseJSON["key"] as? String
        println("Success: \(success)")
        }
        else {
        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: \(jsonStr)")
        }
        }
        })
        
        task.resume()
*/
    }

    
    @IBAction func SignUpButton(sender: UIButton) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    


}