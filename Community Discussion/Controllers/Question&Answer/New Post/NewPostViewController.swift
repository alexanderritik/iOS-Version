//
//  NewPostViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewPostViewController: UIViewController {

    
    @IBOutlet var tag3: UITextField!
    @IBOutlet var tag2: UITextField!
    @IBOutlet var tag1: UITextField!
    @IBOutlet var tags: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var mainContent: UITextView!
    @IBOutlet var titleTexy: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Query"
        // Do any additional setup after loading the view.

    }
    
    
    @IBAction func askQueryDidTouch(_ sender: Any) {
        
        
        
        guard let title = titleTexy.text else {return }
        guard let mainQuestion = mainContent.text else {return }
        guard let tag1 = tag1.text else { return }
        guard let tag2 = tag2.text else { return }
        guard let tag3 = tag3.text else { return }
        let currentTime = Date()

        guard let id = Auth.auth().currentUser?.uid else { return  }
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        
        let q1 = Question(id:"_" ,answercount: 0, profileimg: "_", likes: 0, title: title, mainQuestion: mainQuestion, tags: [tag1 , tag2 , tag3], userId: id, name: name, views: 0, timestamp: currentTime)
        
        questionDatabase.shared.sendQuestionToDatabase(question: q1) { result in
    
            switch result{
            case .success(_):
                print("huuray")
            case .failure(_):
                print("error")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
