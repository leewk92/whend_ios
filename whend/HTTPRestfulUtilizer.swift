//
//  HTTPRestfulUtilizer.swift
//  whend
//
//  Created by macbook on 2015. 9. 10..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import Foundation
import UIKit

public class HTTPRestfulUtilizer{
    
    var inputDict:Dictionary<String,String>?
    var url:NSURL?
    var nextUrl:NSURL?
    var inputJson:NSData?
    var err: NSError?
    var request: NSMutableURLRequest?
    var reponseError: NSError?
    var response: NSURLResponse?
    var urlData: NSData?
    var outputJson: NSDictionary?
    var outputData:NSString?
    var innerResult: [NSDictionary]?
    
    enum RestType{
        case POST(url:NSURL, inputDict:Dictionary<String,String>)
        case DELETE(url:NSURL)
        case PUT(url:NSURL, inputDict:Dictionary<String,String>)
        case GET(url:NSURL)
    }
    
    init(){
    }
    
    init?(restTypes:RestType){
        
        switch restTypes{
        case .PUT(let url, let inputDict):
            self.request = NSMutableURLRequest(URL: url)
            initSettings(url,inputDict: inputDict)
            
            request!.HTTPMethod = "PUT"
            request!.HTTPBody = self.inputJson
            return
        case .DELETE(let url):
            self.request = NSMutableURLRequest(URL: url)
            initSettings(url,inputDict: nil)
            
            request!.HTTPMethod = "DELETE"
            return
        case .GET(let url):
            self.request = NSMutableURLRequest(URL: url)
            initSettings(url,inputDict: nil)
            
            request!.HTTPMethod = "GET"
            return
        case .POST(let url,let inputDict):
            self.request = NSMutableURLRequest(URL: url)
            initSettings(url,inputDict: inputDict)
            
            request!.HTTPMethod = "POST"
            request!.HTTPBody = self.inputJson
            return
        default :
            return nil
        }
        
    }
    
    func initSettings(url:NSURL, inputDict:Dictionary<String,String>?){
        self.url = url
        if let tmp_inputDict = inputDict{
            self.inputDict = inputDict
            self.inputJson = NSJSONSerialization.dataWithJSONObject(inputDict!, options: nil, error: &self.err)
        }
        
    }
    func requestRestSync(){
        //request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request!.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request!.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request!.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
        
        // Get Token
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let token = prefs.objectForKey("TOKEN") as? String{
            request!.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
        }
        // request!.setValue("Token d1e9cfab3ed0d118ab0e5ea7b088c42fc95dc1dd", forHTTPHeaderField: "Authorization")
        //
        urlData = NSURLConnection.sendSynchronousRequest(request!, returningResponse:&response, error:&reponseError)
        if ( urlData != nil ) {
            let res = response as! NSHTTPURLResponse!;
            
            NSLog("Response code: %ld", res.statusCode);
            
            self.outputData = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
            
            NSLog("Response ==> %@", outputData!);
            
            if (res.statusCode >= 200 && res.statusCode < 300){
                self.outputData  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                NSLog("Response ==> %@", outputData!);
                var error: NSError?
                self.outputJson = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSDictionary
                
                if let tmpInnerResult = outputJson!.valueForKey("results") as? [NSDictionary]{
                    self.innerResult = tmpInnerResult
                }
                
                if let tmpNextUrl = outputJson!.valueForKey("next") as? String {
                    self.nextUrl = NSURL(string: tmpNextUrl)
                }
                
            }else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Connection Alert"
                alertView.message = "Connection Failed"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        } else {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Connection Alert"
            alertView.message = "Connection Failure"
            if let error = reponseError {
                alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    func requestRestAsync(){
        //request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request!.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request!.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request!.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Accept")
        
        // Get Token
        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let token = prefs.objectForKey("TOKEN") as? String{
            request!.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            
        }
        // request!.setValue("Token d1e9cfab3ed0d118ab0e5ea7b088c42fc95dc1dd", forHTTPHeaderField: "Authorization")
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request!, queue: mainQueue, completionHandler: { (response: NSURLResponse!, urlData :NSData!, error:NSError!) -> Void in
            println(urlData!)
            if error == nil {
                if let response = response as? NSHTTPURLResponse {
                    let statusCode = response.statusCode
                    
                    self.outputData = NSString(data:urlData!, encoding:NSUTF8StringEncoding)
                    
                    NSLog("Response ==> %@", self.outputData!);
                    
                    if (statusCode >= 200 && statusCode < 300){
                        self.outputData  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                        NSLog("Response ==> %@", self.outputData!);
                        var error: NSError?
                        self.outputJson = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSDictionary
                        
                        
                        if let tmpInnerResult = self.outputJson!.valueForKey("results") as? [NSDictionary]{
                            self.innerResult = tmpInnerResult
                        }
                        
                        if let tmpNextUrl = self.outputJson!.valueForKey("next") as? String {
                            self.nextUrl = NSURL(string: tmpNextUrl)
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), {
                        })
                        
                    }else {
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Connection Alert"
                        alertView.message = "Connection Failed"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                    
                }
                
            }
            else {}
        })
    }

    
    func performWithOutputData(){
        // Override like following codes.
        // let success = outputJson.valueForKey("key") as? String
//        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        prefs.setObject(username, forKey: "USERNAME")
//        prefs.setInteger(1, forKey: "ISLOGGEDIN")
//        prefs.synchronize()
//        
//        dispatch_async(dispatch_get_main_queue(), {
//        
//            target.image = image
//        })

        
    }
    
    enum imageDestination{
        case wall
        case original
        case profile
    }
    
    func getUrlImage( inout _target:UIImageView!, _url:NSURL , _imageDestination:imageDestination){
        
        var string_url = _url.absoluteString! as NSString
        var tmp_url:String
        switch _imageDestination{
        case .wall:
            tmp_url = string_url.substringToIndex(string_url.length - 4).stringByAppendingString(".800x200.jpg")
        case .original:
            tmp_url = string_url as String
        case .profile:
            tmp_url = string_url.substringToIndex(string_url.length - 4).stringByAppendingString(".100x100.jpg")
        }
        
        println(tmp_url)
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: tmp_url)!)
        let mainQueue = NSOperationQueue.mainQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response: NSURLResponse!, data :NSData!, error:NSError!) -> Void in
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    if statusCode != 200 {
//                        var _named = "";
//                        
//                        if _type == "1" {
//                            _named = "t-m.jpg"
//                        }else if _type == "2"{
//                            _named = "t-w.jpg"
//                        }
//                        
//                        let image = UIImage(named: _named)!
//                        // Update the cell
//                        dispatch_async(dispatch_get_main_queue(), {
//                            _target.image = image
//                        })
                        
                    }else{
                        // Convert the downloaded data in to a UIImage objectwl
                        let image = UIImage(data: data)
                        
                        // Update the cell
                        dispatch_async(dispatch_get_main_queue(), {
                            _target.image = image
                        })
                    }
                }
                
            }
            else {}
        })
    }

}


