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
    let timestamp : Date
    let content : String
    let questionId: String
}

extension answerDatabase {
    
    //MARK: fetch answer of particular question
    public func getAllAnswer(questionId : String  , completion : @escaping (Result<Answer, Error>)->Void){
        
        db.collection(K.FQuestions.question).document(questionId).collection("answers").getDocuments { (snapshot, error) in
            
            if error == nil {
                
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    
                    if let sol = document.data() as? [String:Any] , document.exists {
                        self.getanswerFromId(id: sol["answerID"] as! String) { (result) in
                            
                            switch result {
                            case .success(let data):
                                if let data = data as? Answer {
                                    completion(.success(data))
                                }
                            case .failure(_):
                                print("error in questionId fetch")
                            }

                        }
                    }
                }

            }
            
        }
        
        
    }
    
    //MARK: Submit and answer to a question
    public func submitAnswer(answer : Answer , completion : @escaping (Result<Bool, Error>)->Void){
        
        let data = [
            K.FAnswers.content : answer.content,
            K.FAnswers.downvote : answer.downvote,
            K.FAnswers.upvote : answer.upvote,
            K.FAnswers.userdId : answer.userId,
            K.FAnswers.name : answer.username,
            K.FAnswers.timestamp : answer.timestamp,
            K.FAnswers.questionId : answer.questionId
            ] as [String : Any]
        
        
        let answerRef = db.collection(K.FAnswers.answer).document()
        
        let answerID = answerRef.documentID
        
        //update number of question
        db.collection(K.FQuestions.question).document(answer.questionId).setData([K.FQuestions.answercount : FieldValue.increment(Int64(1))], merge: true)
        
        //update user total answers
        db.collection(K.FUser.users).document(answer.userId).setData([K.FUser.total_answer : FieldValue.increment(Int64(1))], merge: true)
        
        ///submit to answer database
        answerRef.setData(data, merge: true ){ (error) in
            if error == nil {
                print("sucess")
            }
        }
        
        ///send to question/answers database
        let anscollectId = db.collection(K.FQuestions.question).document(answer.questionId).collection("answers")
        anscollectId.addDocument(data: [
            "answerID" : answerID,
            "timestamp" : answer.timestamp
        ]){ (error) in
            if error == nil {
                print("sucess")
            }
        }
        
        ///send to user/answers database
        let answercollectId = db.collection(K.FUser.users).document(answer.userId).collection("answers")
        answercollectId.addDocument(data: [
            "answerID" : answerID,
            "timestamp" : answer.timestamp
        ]){ (error) in
            if error == nil {
                print("sucess")
            }
        }
        
        
        completion(.success(true))
        
    }
    
    
    
    public func getanswerFromId(id: String ,completion : @escaping (Result<Answer, Error>)->Void){
        print(id)
        
        db.collection(K.FAnswers.answer).document(id).getDocument { (document, error) in
            
            if let document = document, document.exists {
                if let data = document.data() {
                    
                    let content = data[K.FAnswers.content] as? String ?? "_"
                    let downvote = data[K.FAnswers.downvote] as? Int ?? 0
                    let upvote = data[K.FAnswers.upvote] as? Int ?? 0
                    let name = data[K.FAnswers.name] as? String ?? "_"
                    let UploadTime = data[K.FAnswers.timestamp] as! Timestamp
                    let time = UploadTime.dateValue()
                    let userId = data[K.FAnswers.userdId] as? String ?? "_"
                    let questionID = data[K.FAnswers.questionId] as? String ?? "_"
                    
                    let ans = Answer(upvote: upvote, downvote: downvote, userId: userId, username: name, timestamp: time, content: content , questionId: questionID)
//                    print(ans)
                    completion(.success(ans))
                }
            }
        }
        
    }
    
}
