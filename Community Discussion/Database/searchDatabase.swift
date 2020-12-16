//
//  searchDatabase.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 17/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class searchDatabase {
    
    //creating a shared delegate
    static let shared = searchDatabase()
    
    private let db = Firestore.firestore()
    
}

extension searchDatabase {
    
    //MARK: Search a username
    public func searchUser(){
        
    }
    
    //MARK: Search a question
    public func searchQuestion(){
        
    }
}



