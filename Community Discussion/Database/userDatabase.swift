//
//  userDatabase.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 11/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import FirebaseAuth

class userDatabase {

    static var currentUserUid : String? = {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return uid
    }()
}
