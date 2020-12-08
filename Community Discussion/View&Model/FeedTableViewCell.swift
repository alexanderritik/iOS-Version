//
//  FeedTableViewCell.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var datePosted: UILabel!
    
    @IBOutlet var mainQuestion: UILabel!
    
    @IBOutlet var likesCount: UILabel!
    
    @IBOutlet var commentsCount: UILabel!
    
    @IBOutlet var viewsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = CGFloat(8)
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        // Initialization code
    }

    @IBAction func bookmarkDidTouch(_ sender: Any) {
    }
    
    @IBAction func commentButtonDidTouch(_ sender: Any) {
    }
    
    @IBAction func likeButtonDidTouch(_ sender: Any) {
    }
    
}
