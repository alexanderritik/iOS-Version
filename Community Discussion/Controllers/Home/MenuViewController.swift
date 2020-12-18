//
//  MenuViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 09/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class MenuViewController : UITableViewController {
    
    private let menuItems : [String]
    public var delegate : MenuControllerDelegate?
    
    init(with menuItems : [String]) {
        self.menuItems = menuItems
        super.init(nibName:nil , bundle: nil)
        tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.backgroundColor = UIColor.gray
        tableView.separatorColor = UIColor.clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell" , for : indexPath) as! SideMenuTableViewCell
        cell.cellName?.text = menuItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
    
}
