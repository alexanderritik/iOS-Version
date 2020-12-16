//
//  answerDatabase.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 17/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class answerDatabase {
    
    //creating a shared delegate
    static let shared = answerDatabase()
    
    private let db = Firestore.firestore()
    
}

struct Answer {
    let upvote : Int
    let downvote : Int
    let userId : String
    let username : String
    let timestamp : String
    let content : String
}

extension answerDatabase {
    
    //MARK: fetch answer of particular question
    public func getAllAnswer(questionId : String){
        
    }
    
}
