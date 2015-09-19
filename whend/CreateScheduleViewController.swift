//
//  CreateScheduleViewController.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 17..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class CreateScheduleViewController: UIViewController {

    
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var endTimeField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var alldaySwitch: UISwitch!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    
    var startTime_NSDate : NSDate?
    var endTime_NSDate : NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //startTimeField.inputView = datePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
        println("cancel")
    }
*/
    @IBAction func startTimeFieldEditing(sender: UITextField) {
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    @IBAction func endTimeFieldEditing(sender: UITextField) {
        var datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.DateAndTime
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged2:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    
    func datePickerValueChanged(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        startTimeField.text = dateFormatter.stringFromDate(sender.date)
        println(sender.date)
        startTime_NSDate = sender.date
    }
    func datePickerValueChanged2(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        endTimeField.text = dateFormatter.stringFromDate(sender.date)
        endTime_NSDate = sender.date
    }
    
    
    @IBAction func UploadScheduleButtonClicked(sender: UIBarButtonItem) {
        var schedule_Dic : Dictionary<String,AnyObject> = Dictionary<String, AnyObject>()
      /*  var schedule_NSDic : NSDictionary = NSDictionary()"{"title":"연세휘트니스 10월 접수","hashtag":[10,285,286,287],"start_time":"2015-09-21T00:00:00Z","end_time":"2015-09-22T00:00:00Z","memo":"#연세대학교 #휘트니스 #헬스 #운동 을 열심히 합시다\n나는 시즌권이라 안갈거지만 ㅋㅋㅋㅋ","user_name":"wonchulhouse","user_id":186,"user_photo":"http://119.81.176.245/media/profile/2015/09/04/bec94c5d-04d.jpg","id":425,"like":0,"follow":1,"master":0,"count_like":2,"count_follow":6,"photo":"http://119.81.176.245/media/schedule/2015/09/14/74f77c2b-9f7.jpg","location":"연세휘트니스센터","count_comment":4,"all_day":true}
        */
       
        var dateFormatter = NSDateFormatter()
        var dtf = DateTimeFormatter()
        
        schedule_Dic.updateValue(titleTextField.text, forKey: Schedule.ScheduleKey.Title)
        schedule_Dic.updateValue(dtf.dateToStringForUpload(startTime_NSDate) , forKey: Schedule.ScheduleKey.StartTime)
        schedule_Dic.updateValue(dtf.dateToStringForUpload(endTime_NSDate) , forKey: Schedule.ScheduleKey.EndTime)
        schedule_Dic.updateValue(alldaySwitch.on, forKey: Schedule.ScheduleKey.AllDay)
        schedule_Dic.updateValue(locationTextField.text, forKey: Schedule.ScheduleKey.Location)
        schedule_Dic.updateValue(memoTextField.text, forKey: Schedule.ScheduleKey.Memo)
        
        var schedule : Schedule = Schedule(data: schedule_Dic )!
        
        let url:NSURL = NSURL( string: "http://119.81.176.245/schedules/")!
        var inputDict = schedule.asPropertyList as! Dictionary<String, AnyObject>
        
        if let hashtags_id = memoParsorToGetHashtags( memoTextField.text){
            inputDict.updateValue( hashtags_id, forKey: "hashtag")
            let restfulUtil: HTTPRestfulUtilizer = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.POST(url: url, inputDict: inputDict))!
            restfulUtil.requestRestSync()
        }
        
        
    }
    
    func memoParsorToGetHashtags(memo_string:String)-> [Int]? {
        
        var memo = NSString(string: memo_string)
        memo = memo.stringByReplacingOccurrencesOfString("\n" , withString: " ")
        let memo_s = memo.stringByReplacingOccurrencesOfString("#" , withString: " #")
        
        var tmpArray = split(memo_s){$0 == "#"}
        var hashtags : [Dictionary <String, AnyObject>] = [Dictionary<String,AnyObject>]()
    
        if tmpArray.count != 0{
            tmpArray.removeAtIndex(0)
            var i = 0
            for tmpItem in tmpArray {
                var tmpDic = Dictionary<String, AnyObject>()
                tmpDic.updateValue( split(tmpItem){$0 == " "}[0] , forKey: "title" )
                hashtags.insert(tmpDic , atIndex: i)
                i = i + 1
            }
            var url = NSURL(string: "http://119.81.176.245/hashtags/getid/")
            let restfulUtil = HTTPRestfulUtilizer(restTypes: HTTPRestfulUtilizer.RestType.POST_array(url: url!,inputDict: hashtags))
            restfulUtil?.requestRestSync_OuputIsArray()
            var tmpOutput_NSDic = restfulUtil!.outputJsonArray!
            
            var hashtags_id : [Int] = [Int]()
            for tmpItem in tmpOutput_NSDic {
                hashtags_id.append( tmpItem.valueForKey("id") as! Int )
            }
            return hashtags_id
        }
        else {
            return nil
        }
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
