//
//  WallTableViewCell.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 7..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class WallTableViewCell: UITableViewCell {
    
    var schedule: Schedule? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var scheduleTitleLabel: UILabel!

    func updateUI() {
        scheduleTitleLabel?.text = nil
        
        if let schedule = self.schedule
        {
            scheduleTitleLabel?.text = schedule.title
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        
            
}
