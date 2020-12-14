//
//  RegisterViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var cnfPassword: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var userEmail: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func LoginDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInDidTouch(_ sender: Any) {
        
        username.resignFirstResponder()
        userEmail.resignFirstResponder()
        password.resignFirstResponder()
        cnfPassword.resignFirstResponder()
        
        guard let username = username.text  ,let email = userEmail.text  , let password = password.text , let cnfPassword = cnfPassword.text ,!email.isEmpty ,!password.isEmpty , password.count>=6  , password == cnfPassword  else {
            let error = Helper.error(title: "Details are Invalid", message: "Please retry to fill!")
            present(error, animated:  true)
            return
        }
        
        print(username , email , password , cnfPassword)
        
        createNewUser(email: email, password: password, username: username)
        
        self.username.text = ""
        self.userEmail.text = ""
        self.password.text = ""
        self.cnfPassword.text = ""
        
    }
    
}


extension RegisterViewController {
    
    func createNewUser(email : String , password: String , username:String){
        
        //spinner to avoid freeze of UI
        let spinner = UIViewController.displayLoading(withView: self.view)
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let strongSelf = self else { return }
            if error == nil {
                
                //to remove the spinner at design time
                DispatchQueue.main.async {
                    //remove spinner
                    UIViewController.removingLoading(spinner: spinner)
                }
                
                // it is used to chache the username and email locally with this key
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(email, forKey: "email")
                
                print("welcome to database")
                
                if let uid = Auth.auth().currentUser?.uid {
                    
                    strongSelf.db.collection(K.FUser.users).document(uid).setData([
                        K.FUser.name : username,
                        K.FUser.email : email,
                        K.FUser.dob : "_",
                        K.FUser.phone : "_",
                        K.FUser.query_asked : 0,
                        K.FUser.total_likes : 0,
                        K.FUser.total_views : 0,
                        K.FUser.profileimg : "_",
                        K.FUser.about : [
                            K.FAbout.achievements : "_",
                            K.FAbout.contribution : 0,
                            K.FAbout.tags : [" " , " "],
                            K.FAbout.projects : [" ", " "],
                            K.FAbout.profileLinks : [
                                K.FProfileLinks.codechef : "_",
                                K.FProfileLinks.codeforces : "_",
                                K.FProfileLinks.github : "_"
                            ]
                        ]
                    ]) { error in
                        if error != nil {
                            print(" There was issue with the database ")
                        }
                        else
                        {
                            print("sucessfully")
                        }
                    }
                    
                }
            }
            else if let error = error {
                
                DispatchQueue.main.async {
                    UIViewController.removingLoading(spinner: spinner)
                }
                                   
                let alert = Helper.loginSignError(error: error , title: "Login" )
                print("error to database")
                DispatchQueue.main.async {
                    strongSelf.present(alert ,animated: true ,completion: nil)
                }
            }
        }
    }
    
}
