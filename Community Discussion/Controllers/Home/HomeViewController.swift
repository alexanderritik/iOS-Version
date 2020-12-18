//
//  HomeViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController ,MenuControllerDelegate {

    @IBOutlet var tableView: UITableView!
    
    private var sideMenu: SideMenuNavigationController?
    
    var posts : [[String]] = [["Ritik"],["Ritik"],["Ritik"],["Ritik"],["Ritik"]]
    
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
    
    
}


//MARK: It contains every functionality regarding table views
extension HomeViewController :  UITableViewDataSource, UITableViewDelegate {
    
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
            
            return feedTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         tableView.deselectRow(at: indexPath, animated: true)
        
        // opening the full questions
        openFullQuery()
    }
    
    func openFullQuery(){
        let vcStoryboard = UIStoryboard(name: "QuestionPage", bundle: nil)
        let vc = vcStoryboard.instantiateViewController(identifier: "QuestionPage") as! QuestionAnswerViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav , animated: true)
       }
}
