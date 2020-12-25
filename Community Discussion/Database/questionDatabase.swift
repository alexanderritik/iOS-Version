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
    let id : String
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
        
        let questionRef = db.collection(K.FQuestions.question).document()
        let questionID = questionRef.documentID
        
        let data = [
            K.FQuestions.questionId : questionID ,
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
            "questionID" : questionID,
            "timestamp" : question.timestamp
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
    public func getAllQuestionOfUser(id: String ,  completition : @escaping (Result< Question , Error>)->Void){
    
        
        let ref = db.collection(K.FUser.users).document(id).collection("questions").order(by: "timestamp")
        
        ref.getDocuments() { (snapshot, error) in
            
            if error == nil {
                
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    
                    if let sol = document.data() as? [String:Any] , document.exists {
                        self.getQuestionFromId(id: sol["questionID"] as! String) { (result) in
                            
                            switch result {
                            case .success(let data):
                                if let data = data as? Question {
                                    completition(.success(data))
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
    
    
    //MARK: Get question from question id
    public func getQuestionFromId(id: String , completition : @escaping (Result<Question, Error>)->Void) {
        
        db.collection(K.FQuestions.question).document(id).getDocument { (document, error) in
            
            if let document = document, document.exists {
                
                if let data = document.data() {
                    let id = data[K.FQuestions.questionId] as? String ?? "_"
                    let answerCount = data[K.FQuestions.answercount] as? Int ?? 0
                    let likes = data[K.FQuestions.likes] as? Int  ?? 0
                    let views = data[K.FQuestions.views] as? Int  ?? 0
                    let name = data[K.FQuestions.name] as? String  ?? "_"
                    let title = data[K.FQuestions.title] as? String  ?? "_"
                    let mainQuestion = data[K.FQuestions.mainQuestion] as? String  ?? "_"
                    let userId = data[K.FQuestions.userId] as? String  ?? "_"
                    let profileimg = data[K.FQuestions.profileimg] as? String  ?? "_"
                    let tags = data[K.FQuestions.tags] as? [String] ?? ["_"]
                    
                    let UploadTime = data[K.FQuestions.timestamp] as! Timestamp
                    let time = UploadTime.dateValue()
                    
                    let q1 = Question(id: id, answercount: answerCount, profileimg: profileimg, likes: likes, title: title, mainQuestion: mainQuestion, tags: tags, userId: userId, name: name, views: views, timestamp: time)
                    
//                    print(q1)
                    completition(.success(q1))
                    
                }
            }
        }
        
    }
    
    
    
}


