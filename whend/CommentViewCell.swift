//
//  CommentViewCell.swift
//  whend
//
//  Created by macbook on 2015. 9. 23..
//  Copyright (c) 2015년 SOODAL. All rights reserved.
//

import UIKit

class CommentViewCell: UITableViewCell {

    var comment: Comment? {
        didSet {
            println(comment!.content!)
            updateUI()
        }
    }
    
    @IBOutlet weak var usernameLabel : UILabel!
    
    @IBOutlet weak var contentLabel : UILabel!
    
   
    
    func updateUI() {
       
        usernameLabel?.text = "ho"
        contentLabel?.text = "jo"
        
        
        
        println(usernameLabel?.text)
        
        if let comment = self.comment
        {
            usernameLabel?.text = "ho"
            contentLabel?.text = "JO"
        
//            usernameLabel?.text = comment.write_username!
//            contentLabel?.text = comment.content!
        
//            likeImageView.addTarget(self, action: Selector("clickLikeButton:"), forControlEvents: UIControlEvents.TouchUpInside)
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
