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
    public func sendQuestionToDatabase(question : Question , completion : @escaping (Result<Bool, Error>)->Void) {
        
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
        
        //update number of question
        db.collection(K.FUser.users).document(question.userId).setData([K.FUser.query_asked : FieldValue.increment(Int64(1))], merge: true)
        
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
            "questionId" : questionID,
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
    public func getAllQuestionOfUser(id: String ,  completition : @escaping (Result< Question , Error>)->Void) {
    
        
        let ref = db.collection(K.FUser.users).document(id).collection("questions").order(by: "timestamp", descending: true)
        
        ref.getDocuments() { (snapshot, error) in
            
            if error == nil {
                
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    
                    if let sol = document.data() as? [String:Any] , document.exists {
                        print(sol)
                        self.getQuestionFromId(id: sol["questionId"] as! String) { (result) in

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
    
    
    
    //MARK: fetch question in homeView Controller
    public func fetchQuestions() {

        let ref = db.collection(K.FQuestions.question).order(by: "timestamp" , descending: true).limit(to: 5)
        
        ref.addSnapshotListener() { (snapshot, error) in
            
            if error == nil {
                
                guard let snap = snapshot else { return }
                
                for document in snap.documents {
                    print(document.data())
                }
            }
            
            
        }
        
    }
    
    
    //like the post
    func likePost(questionID : String  , hit: Int , completition : @escaping (Result< Bool , Error>)->Void) {
        
        if let id = Auth.auth().currentUser?.uid {
            
        db.collection(K.FQuestions.question).document(questionID).collection("likes").document(id).getDocument { [weak self] (snapshot, error) in
            if error == nil {
                guard let snapshot = snapshot else { return }
                
                if let _ = snapshot.data() {
                    print("You already Like post")
                    completition(.success(true))
                }

                else if hit == 0 {
                    print("like is going done")
                    self?.db.collection(K.FQuestions.question).document(questionID).collection("likes").document(id).setData(["timestamp" : Date()])
                    
                    self?.db.collection(K.FQuestions.question).document(questionID).setData([K.FQuestions.likes : FieldValue.increment(Int64(1))], merge: true)
                    
                    completition(.success(false))
                    }
                
                }
            }
        }

    }
    
    
    //view the post
    func viewUniquePost(questionID : String , hit: Int  , completition : @escaping (Result< Bool , Error>)->Void) {
        guard let id = Auth.auth().currentUser?.uid  else { return }
        
        db.collection(K.FQuestions.question).document(questionID).collection("views").document(id).getDocument { [weak self] (snapshot, error) in
            if error == nil {
                guard let snapshot = snapshot else { return }
                
                if let _ = snapshot.data() {
                    print("You already views")
                    completition(.success(true))
                }
                
                
                else if hit == 0 {
                    print("views is going done")
                    self?.db.collection(K.FQuestions.question).document(questionID).collection("views").document(id).setData(["timestamp" : Date()])
                    
                    self?.db.collection(K.FQuestions.question).document(questionID).setData([K.FQuestions.views : FieldValue.increment(Int64(1))], merge: true)
                    completition(.success(true))
                }
                
                else {
                    print("You havenot views it " , questionID)
                    completition(.success(false))
                }
                
                
            }
        }
        
    }
        
    
    
}


