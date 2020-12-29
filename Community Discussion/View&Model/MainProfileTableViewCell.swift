//
//  MainProfileTableViewCell.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class MainProfileTableViewCell: UITableViewCell {

    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var username: UILabel!
    
    @IBOutlet var userEmail: UILabel!
    
    @IBOutlet var questionCount: UILabel!
    
    @IBOutlet var answerCount: UILabel!
    
    @IBOutlet var viewsCount: UILabel!
    @IBOutlet var settingButton: UIButton!
    
    var settingDelegate : ProfileSettingDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePic.layer.borderColor = UIColor.gray.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.width/2
        profilePic.layer.borderWidth = CGFloat(3)
        
        settingButton.isHidden = true
    }
    
    @IBAction func settingButtonDidTouch(_ sender: Any) {
        print("did touch setting")
        settingDelegate?.profileSettingDidTouch()
    }
    
    
    func fillDetail(user : User)
    {
        settingButton.isHidden = false
        username.text = user.name
        userEmail.text = user.email
        questionCount.text = String(user.query_asked)
        answerCount.text = String(user.total_answer)
        viewsCount.text = String(user.total_views)
    }
}
