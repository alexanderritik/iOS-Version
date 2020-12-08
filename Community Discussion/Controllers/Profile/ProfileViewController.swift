//
//  ProfileViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var posts : [[String]] = [["Ritik"],["Ritik"],["Ritik"],["Ritik"],["Ritik"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        navigationItem.title = "Profile"
        setupTableView()
    }
    

}


//MARK: It contains every functionality regarding table views
extension ProfileViewController :  UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else {
            return posts.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let profileHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderTableViewCell") as! MainProfileTableViewCell

            profileHeaderTableViewCell.settingDelegate = self

            return profileHeaderTableViewCell
        }
            
        else if indexPath.section == 1 {
            
            let profileViewStyleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileViewStyleTableViewCell")!

            return profileViewStyleTableViewCell
        }
            
        else if indexPath.section == 2 {
            
            let feedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell")!
            
            return feedTableViewCell
        }
            
        else {
            
            return UITableViewCell()
            
        }
        
    }
}

extension ProfileViewController : ProfileSettingDelegate {
    
    func profileSettingDidTouch() {
    print("profile did touch setting")
        let alert = UIAlertController(title: "Setting", message: "option available", preferredStyle: .actionSheet)
            
        let logout = UIAlertAction(title: "Logout", style: .default) {[weak self] _ in
            guard let strongSelf = self else { return }
//            strongSelf.doYouReallyWantToExist()
        }
        
        let setting = UIAlertAction(title: "Setting", style: .default) { _ in
            print("In the setting")
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel)
        
        alert.addAction(logout)
        alert.addAction(setting)
        alert.addAction(cancel)
        present(alert,animated: true)
    }
    
}
