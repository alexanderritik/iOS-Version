//
//  FirestoreReferenceManager.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 09/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    //creating a shared delegate
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}
