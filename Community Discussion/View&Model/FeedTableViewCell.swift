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
    
    @IBOutlet var likeButtonImage: UIButton!
    
    @IBOutlet var viewButtonImage: UIButton!
    
    var questionId: String?
    
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
//        print("Likes button did touch in the " , questionId)
        guard let questionID = questionId else { return }
        questionDatabase.shared.likePost(questionID: questionID , hit: 0) { [weak self] (result) in
            switch result {
            
            case .success(let cond):
                if cond == false , let likes = self?.likesCount.text , let noLikes = Int(likes){
                    self?.likesCount.text = String(noLikes+1)
                    self?.likeButtonImage.tintColor = UIColor.systemBlue
                }
                print("update the database")
            case .failure(_):
                print("some error in the database")

            }
        }
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
        
        questionDatabase.shared.likePost(questionID: question.id , hit: 1) {[weak self] (result) in
            switch result {
            
            case .success(_):
                self?.likeButtonImage.tintColor = UIColor.systemBlue
            case .failure(_):
                print("It is already likes")

            }
        }
        
        questionDatabase.shared.viewUniquePost(questionID: question.id  , hit: 1 , completition: { [weak self] (result) in
            switch result {
            
            case .success(let cond):
                print(cond)
                if cond == true {
                    print("Already views it")
                    self?.viewButtonImage.tintColor = UIColor.systemBlue
                }else{
                    print("no views it")
                }
            case .failure(_):
                print("there is some error")
            }
        })
        
    }
    
}
