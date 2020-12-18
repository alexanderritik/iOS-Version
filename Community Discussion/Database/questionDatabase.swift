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
    let answercount : Int
    let profileimg : String
    let likes : Int
    let title  :String
    let mainQuestion : String
    let tags  : [String]
    let userId : String
    let name : String
    let views : Int
    let timestamp : Date
}

extension questionDatabase {
    
    //MARK: To send question data to all the database
    public func sendQuestionToDatabase(question : Question , completion : @escaping (Result<Bool, Error>)->Void){
        
        
        let data = [
            K.FQuestions.answercount : question.answercount,
            K.FQuestions.likes : question.likes,
            K.FQuestions.mainQuestion : question.mainQuestion,
            K.FQuestions.name : question.name,
            K.FQuestions.profileimg : question.profileimg,
            K.FQuestions.tags : question.tags,
            K.FQuestions.timestamp : question.timestamp,
            K.FQuestions.title : question.title,
            K.FQuestions.userId : question.userId,
            K.FQuestions.views : question.views
            ] as [String : Any]
        
        
        let questionRef = db.collection(K.FQuestions.question).document()
        
        let questionID = questionRef.documentID
        
        // send to question database
        questionRef.setData(data, merge: true ){ (error) in
            if error == nil {
                print("sucess")
            }
        }
        
        // send to searchQuestion database
        db.collection("searchQuestion").addDocument(data: [
            "questionId" : questionID,
            "title" : question.title
        ]){ (error) in
            if error == nil {
                print("sucess")
            }
        }
        
        //send to user/questions database
        let qcollectId = db.collection(K.FUser.users).document(question.userId).collection("questions")
        qcollectId.addDocument(data: [
            "questionID" : questionID
        ]){ (error) in
            if error == nil {
                print("sucess")
            }
        }
        
    }
    
    //MARK: To fetch in search view controller
    public func searchQuestion(search  : String){
        
    }
    
    //MARK: fetch question of particular user all questions
    public func getAllQuestionOfUser(id: String){
        
        
        
    }
    
    
    
}

