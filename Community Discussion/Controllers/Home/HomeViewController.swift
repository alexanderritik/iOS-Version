//
//  HomeViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit
import SideMenu
import FirebaseFirestore

class HomeViewController: UIViewController ,MenuControllerDelegate {

    private let db = Firestore.firestore()
    
    @IBOutlet var tableView: UITableView!
    
    private var sideMenu: SideMenuNavigationController?
    
    private var isPaginating = false
    
    private var lastDocumentSnapshot : DocumentSnapshot?
    
    private var posts = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let menu = MenuViewController(with: ["PROFILE" ,"FRIENDS" ,"EVENTS" , "TICKETS" ,"REDEEM" ,"FEATURED" ,"ABOUT"])
               
        menu.delegate = self
               
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
       
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
               
        
        navigationItem.title = "Community Discussion"
        
        setupTableView()
        print("call load more")
        
        fetchFirstTime { [weak self] (result) in
            
            switch result {
            case .success(let cond):
                if cond == true{
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            case .failure(_):
                print("Something is wrong")
            }
            
            self?.isPaginating = true
        }
                
    }
    
    @IBAction func sideMenuDidTouch(_ sender: Any) {
        present(sideMenu! ,animated: true)
    }
    
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true) {
            
            if named == "PROFILE"{
                
            }
            else if named == "FRIENDS"{
                
            }
            else if named == "EVENTS"{
                
            }
            else if named == "TICKETS"{
                
            }
            else if named == "REDEEM"{
                
            }
            else if named == "FEATURED"{
                
            }
            else if named == "ABOUT"{
                
            }
        }
    }
    
    
    private func createViewSpinner()->UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width , height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.color = UIColor.black
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    
    @IBAction func reloadPage(_ sender: Any) {
        lastDocumentSnapshot = nil
        posts.removeAll()
        fetchFirstTime { [weak self] (result) in
            switch result {
            case .success(let cond):
                if cond == true{
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            case .failure(_):
                print("Something is wrong")
            }
            self?.isPaginating = true
        }
    }
    
}


//MARK: It contains every functionality regarding table views
extension HomeViewController :  UITableViewDataSource, UITableViewDelegate  ,UIScrollViewDelegate{
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let feedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        
            feedTableViewCell.questionId = posts[indexPath.row].id
            
            feedTableViewCell.fillDetail(question : posts[indexPath.row])
        
            return feedTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
       
           // opening the full questions
           openFullQuery(question: posts[indexPath.row])
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            if isPaginating {
                print("fetch more")
                
                self.tableView.tableFooterView = createViewSpinner()
                
                loadMore { [weak self] (result) in
                    DispatchQueue.main.async {
                        self?.tableView.tableFooterView = nil
                    }
                    switch result {
                        case .success(let cond):
                            if cond == true{
                                DispatchQueue.main.async {
                                    self?.tableView.reloadData()
                                }
                                self?.isPaginating = true
                            }
                        case .failure(_):
                            print("Something is wrong")
                    }
                   
                }
                isPaginating = false
                
            }
            
            
        }
    }
    
    func openFullQuery(question : Question){
        let vcStoryboard = UIStoryboard(name: "QuestionPage", bundle: nil)
        let vc = vcStoryboard.instantiateViewController(identifier: "QuestionPage") as! QuestionAnswerViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        vc.loadViewIfNeeded()
        vc.question = question
        vc.fillData()
        
        present(nav , animated: true)
    }
    
}


//MARK: Fetch the database from questions
extension HomeViewController {
    
    func fetchFirstTime(completion : @escaping (Result<Bool, Error>)->Void ) {
        
        let ref =  db.collection(K.FQuestions.question).order(by: "timestamp", descending: true).limit(to: 5)
        
        
        ref.getDocuments {[weak self] (snapshot, error) in
            
            guard let strongSelf = self else { return }
            guard let snap = snapshot else { return }
            
            self?.lastDocumentSnapshot = snap.documents.last
            
            for document in snap.documents {
                    
                if let data = document.data() as? [String:Any] , document.exists {
                        let id = data[K.FQuestions.questionId] as? String ?? "_"
                        let answerCount = data[K.FQuestions.answercount] as? Int ?? 0
                        let likes = data[K.FQuestions.likes] as? Int  ?? 0
                        let views = data[K.FQuestions.views] as? Int  ?? 0
                        let name = data[K.FQuestions.name] as? String  ?? "_"
                        let title = data[K.FQuestions.title] as? String  ?? "_"
                        let mainQuestion = data[K.FQuestions.mainQuestion] as? String  ?? "_"
                        let userId = data[K.FQuestions.userId] as? String  ?? "_"
                        let profileimg = data[K.FQuestions.profileimg] as? String  ?? "_"
                        let tags = data[K.FQuestions.tags] as? [String] ?? ["_"]
                        
                        let UploadTime = data[K.FQuestions.timestamp] as! Timestamp
                        let time = UploadTime.dateValue()
                        
                        let q1 = Question(id: id, answercount: answerCount, profileimg: profileimg, likes: likes, title: title, mainQuestion: mainQuestion, tags: tags, userId: userId, name: name, views: views, timestamp: time)
                        
                        print(q1)
                        strongSelf.posts.append(q1)
                }
            }
            completion(.success(true))
        }
    }
    
    func loadMore(completion : @escaping (Result<Bool, Error>)->Void){
        
        
        guard let lastDocumentSnapshot = lastDocumentSnapshot else {
            DispatchQueue.main.async {
                self.tableView.tableFooterView = nil
            }
            return }
        
        let ref =  db.collection(K.FQuestions.question).order(by: "timestamp", descending: true).limit(to: 5).start(afterDocument: lastDocumentSnapshot)
        
        ref.getDocuments { [weak self] (snapshot, error) in
            
            guard let strongSelf = self else { return }
            guard let snap = snapshot else { return }
            
            self?.lastDocumentSnapshot = snap.documents.last
            
            for document in snap.documents {
                    
                if let data = document.data() as? [String:Any] , document.exists {
                        let id = data[K.FQuestions.questionId] as? String ?? "_"
                        let answerCount = data[K.FQuestions.answercount] as? Int ?? 0
                        let likes = data[K.FQuestions.likes] as? Int  ?? 0
                        let views = data[K.FQuestions.views] as? Int  ?? 0
                        let name = data[K.FQuestions.name] as? String  ?? "_"
                        let title = data[K.FQuestions.title] as? String  ?? "_"
                        let mainQuestion = data[K.FQuestions.mainQuestion] as? String  ?? "_"
                        let userId = data[K.FQuestions.userId] as? String  ?? "_"
                        let profileimg = data[K.FQuestions.profileimg] as? String  ?? "_"
                        let tags = data[K.FQuestions.tags] as? [String] ?? ["_"]
                        
                        let UploadTime = data[K.FQuestions.timestamp] as! Timestamp
                        let time = UploadTime.dateValue()
                        
                        let q1 = Question(id: id, answercount: answerCount, profileimg: profileimg, likes: likes, title: title, mainQuestion: mainQuestion, tags: tags, userId: userId, name: name, views: views, timestamp: time)
                        
                        print(q1)
                        strongSelf.posts.append(q1)
                }
            }
            completion(.success(true))
        }

    }
    
}
