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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func settingButtonDidTouch(_ sender: Any) {
    }
}
