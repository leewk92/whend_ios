//
//  WallTableViewCell.swift
//  whend
//
//  Created by 맥북 on 2015. 9. 7..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class WallTableViewCell: UITableViewCell {
    @IBOutlet weak var scheduleTitleLabel: UILabel!
    
    var schedule: Schedule? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        scheduleTitleLabel?.attributedText = nil
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
