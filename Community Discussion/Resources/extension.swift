//
//  extension.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 11/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import UIKit

// to add spinner
extension UIViewController {
     
    class func displayLoading(withView: UIView) -> UIView{
        
        //to make cover all cuurent view
        let spinnerView = UIView.init(frame: withView.frame)
        
        spinnerView.backgroundColor = UIColor.clear
        
        let ActvitySpinner = UIActivityIndicatorView.init(style: .medium)
        
        ActvitySpinner.startAnimating()
        
        ActvitySpinner.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ActvitySpinner)
            
            withView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removingLoading(spinner : UIView) {
        
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
        
    }
    
}
