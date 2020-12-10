//
//  ViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet var userPassword: UITextField!
    @IBOutlet var userEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginCheck()
    }

    func loginCheck(){
        if Auth.auth().currentUser != nil {
            createTabBar()
        }
    }
   
    @IBAction func LoginSucessful(_ sender: Any) {
        
        guard  let email = userEmail.text  , let password = userPassword.text , !email.isEmpty ,!password.isEmpty else {
            let error = Helper.error(title: "Details are Invalid", message: "Please retry to fill!")
            present(error, animated:  true)
            return
        }
        
        
        //firebase login
        let spinner = UIViewController.displayLoading(withView: self.view)
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let strongSelf = self else { return }
            
            if error == nil {
                DispatchQueue.main.async {
                    //remove spinner
                    UIViewController.removingLoading(spinner: spinner)
                }
                print("enter to database")
                
                // it is used to chache the email locally with this key
                UserDefaults.standard.set(email, forKey: "email")
                
                // creating tab bar
                strongSelf.createTabBar()
            }
                
            else if let error = error {
                DispatchQueue.main.async {
                    UIViewController.removingLoading(spinner: spinner)
                }
                let alertError = Helper.loginSignError(error: error , title: "Email or password is invalid")
                DispatchQueue.main.async {
                    strongSelf.present(alertError , animated: true)
                }
            }
        }
        
    }
    
    
    @IBAction func siginNewUser(_ sender: Any) {
        performSegue(withIdentifier: "SignupSegue", sender: nil)
    }
 
    func createTabBar(){
        let tabBarVc = UITabBarController()
        
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        
        let newPostStoryboard = UIStoryboard(name: "NewPost", bundle: nil)
        
        let homeVC = homeStoryboard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        
        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        
        let searchVC = searchStoryboard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        
        let newPostVC = newPostStoryboard.instantiateViewController(withIdentifier: "NewPost") as!  NewPostViewController
        
        let activityVC = ActivityViewController()
        
        let vcData: [(UIViewController, UIImage, UIImage)] = [
            (homeVC, UIImage(named: "home_tab_icon")!, UIImage(named: "home_selected_tab_icon")!),
            
            (searchVC, UIImage(named: "search_tab_icon")!, UIImage(named: "search_selected_tab_icon")!),
            
            (newPostVC, UIImage(named: "post_tab_icon")!, UIImage(named: "post_tab_icon")!),
            
            (activityVC, UIImage(systemName: "flame")!, UIImage(systemName: "flame.fill")!),
            
            (profileVC, UIImage(named: "profile_tab_icon")!, UIImage(named: "profile_selected_tab_icon")!)
        ]
        
        let vcs = vcData.map { (vc, defaultImage, selectedImage) -> UIViewController in
            let nav = UINavigationController(rootViewController: vc)
            
            nav.tabBarItem.image = defaultImage
            
            nav.tabBarItem.selectedImage = selectedImage
            
            return nav
        }
        
                
        tabBarVc.viewControllers = vcs
        tabBarVc.modalPresentationStyle = .fullScreen
        tabBarVc.tabBar.isTranslucent = false
        
        if let items = tabBarVc.tabBar.items {
            for item in items {
                
                if let image = item.image {
                    item.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                
                if let selectedImage = item.selectedImage {
                    item.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
                item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
        
        UINavigationBar.appearance().backgroundColor = UIColor.white
        present(tabBarVc , animated: true)
    }
    
}

