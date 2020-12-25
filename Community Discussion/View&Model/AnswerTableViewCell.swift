//
//  AnswerTableViewCell.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 09/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet var content: UITextView!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var downvote: UIButton!
    @IBOutlet var upvote: UIButton!
    @IBOutlet var upvoteCount: UILabel!
    @IBOutlet var downvoteCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfigure(answer: Answer){
        content.text = answer.content
        name.text = answer.username
        upvoteCount.text = String(answer.upvote)
        downvoteCount.text = String(answer.downvote)
    }
}
