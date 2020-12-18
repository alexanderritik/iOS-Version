//
//  Protocol.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 06/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation

protocol ProfileSettingDelegate: class {
//    func profileImageDidTouch()
    func profileSettingDidTouch()
}


protocol MenuControllerDelegate: class {

    func didSelectMenuItem(named: String)
}
