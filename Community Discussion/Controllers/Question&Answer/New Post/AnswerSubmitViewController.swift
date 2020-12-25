//
//  AnswerSubmitViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 24/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit
import FirebaseAuth

class AnswerSubmitViewController: UIViewController {

    
    @IBOutlet var answerTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func uploadPictureDidTouch(_ sender: UIButton) {
    }
    
    @IBAction func postAnswerDidTouch(_ sender: Any) {
        guard let content = answerTextView.text  else{ return }
        
        let currentTime = Date()
        guard let id = Auth.auth().currentUser?.uid else { return  }
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let questionId = UserDefaults.standard.string(forKey: K.FQuestions.questionId) else { return }
        let ans = Answer(upvote: 0, downvote: 0, userId: id, username: name, timestamp: currentTime, content: content, questionId: questionId)
        
        answerDatabase.shared.submitAnswer(answer: ans) { (result) in
            switch result {
                
            case .success(let _):
                print("submit to database")
            case .failure(_):
                print("something is wrong")
            }
        }
        
    }
    
}
