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
    func requestRest(){
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
    
    func performWithOutputData(){
        // Override like following codes.
        // let success = outputJson.valueForKey("key") as? String
//        var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        prefs.setObject(username, forKey: "USERNAME")
//        prefs.setInteger(1, forKey: "ISLOGGEDIN")
//        prefs.synchronize()
        
    }
}


