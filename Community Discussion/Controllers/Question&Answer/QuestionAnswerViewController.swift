//
//  QuestionAnswerViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 28/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class QuestionAnswerViewController: UIViewController {

    @IBOutlet var dateasked: UILabel!
    @IBOutlet var username: UILabel!
    @IBOutlet var mainQuestion: UITextView!
    
    var question : Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IN question view controller")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(moveBack))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settingIcon"), style: .plain, target: self, action: nil)
     
        fillData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(usernameDidTouch))
        tapgesture.numberOfTapsRequired = 1
        username.addGestureRecognizer(tapgesture)
        username.isUserInteractionEnabled = true
    }
    
    @objc func usernameDidTouch(){
        
        print("username did touch")
        
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        
        profileVC.uid = question?.userId
        
        present(profileVC , animated: true)
    }
    
    @objc func moveBack(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        
    }

    @IBAction func readAnswer(_ sender: Any) {
        
        let vcStoryboard = UIStoryboard(name: "QuestionPage", bundle: nil)
        let vc = vcStoryboard.instantiateViewController(identifier: "AnswerPage") as! AnswerViewController
        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
        vc.questionID = question?.id
        vc.loadViewIfNeeded()
        present(nav , animated: true)
        
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        let vcStoryboard = UIStoryboard(name: "QuestionPage", bundle: nil)
        let vc = vcStoryboard.instantiateViewController(identifier: "SubmitAnswerPage") as! AnswerSubmitViewController
        vc.questionID = question?.id
        vc.loadViewIfNeeded()
        present(vc , animated: true)
    }
    
    
    
    func fillData(){
        
        guard let q = question else { return }
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: q.timestamp)
        
        username.text = q.name
        mainQuestion.text = q.mainQuestion
        dateasked.text = dateString
        
    }

}
