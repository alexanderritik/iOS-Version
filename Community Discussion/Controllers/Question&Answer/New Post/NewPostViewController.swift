//
//  NewPostViewController.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 25/10/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

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
