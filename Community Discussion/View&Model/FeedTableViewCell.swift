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
    
    @IBOutlet var tag1: UILabel!
    
    @IBOutlet var tag2: UILabel!
    
    @IBOutlet var tag3: UILabel!
    
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
        print("Likes button did touch in the ")
    }
    
    
    func fillDetail(question : Question)
    {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: question.timestamp)
        
        username.text = question.name
        mainQuestion.text = question.title
        datePosted.text = dateString
        likesCount.text = String(question.likes)
        viewsCount.text = String(question.views)
        commentsCount.text = String(question.answercount)
        tag1.text = question.tags[0]
        tag2.text = question.tags[1]
        tag3.text = question.tags[2]
        
    }
    
}
