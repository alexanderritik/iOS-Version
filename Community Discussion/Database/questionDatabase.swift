//
//  questionDatabase.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 17/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class questionDatabase {
    
    //creating a shared delegate
    static let shared = questionDatabase()
    
    private let db = Firestore.firestore()
    
}

struct Question {
    let answerCount : Int
    let imgUrl : String
    let likes : Int
    let title  :String
    let mainQuestion : String
    let tags  : [String]
    let userId : String
    let username : String
    let views : String
    let timestamp : String
}

extension questionDatabase {
    
    //MARK: To send question data to all the database
    public func sendQuestionToDatabase(question : Question){
        
        // send to question database
            
        
        // send to searchQuestion database
        
        
        //send to user/questions database
        
        
    }
    
    //MARK: To fetch in search view controller
    public func searchQuestion(search  : String){
        
    }
    
    //MARK: fetch question of particular user all questions
    public func getAllQuestionOfUser(id: String){
        
    }
    
    
    
}

