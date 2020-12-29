//
//  AnswerViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 09/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var answerArray = [Answer]()
    
    var questionID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Answers"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
        // Do any additional setup after loading the view.
        
        guard let questionId = questionID else { return }
            
        answerDatabase.shared.getAllAnswer(questionId: questionId) {[weak self] (result) in
            guard let strongSelf = self else{ return }
            switch result {
                case .success(let ans):
                    print(ans)
                    strongSelf.answerArray.append(ans)
                    DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                    }
                case .failure(_):
                    print("answer canot fetch")
            }
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell") as! AnswerTableViewCell
        cell.cellConfigure(answer: answerArray[indexPath.row])
        return cell
    }

    
}
