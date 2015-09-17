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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        startTimeField.inputView = datePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dateValueChanged(sender: UIDatePicker) {
        startTimeField.text = sender.date.description
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
