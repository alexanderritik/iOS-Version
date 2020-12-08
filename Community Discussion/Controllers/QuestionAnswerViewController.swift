//
//  QuestionAnswerViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 28/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class QuestionAnswerViewController: UIViewController {

    @IBOutlet var queryAskedBy: UILabel!
    @IBOutlet var dateAsked: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var QuestionDetail: UITextView!
    
    @IBOutlet var setting: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IN question view controller")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(moveBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingIcon"), style: .plain, target: self, action: nil)
    }
    
    @objc func moveBack(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        
    }

    @IBAction func readAnswer(_ sender: Any) {
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
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
