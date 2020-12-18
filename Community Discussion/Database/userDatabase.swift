//
//  userDatabase.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 11/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class userDatabase {
    
    //creating a shared delegate
    static let shared = userDatabase()
    
    private let db = Firestore.firestore()
    
}

struct User {
    let query_asked : Int
    let phone: String
    let name: String
    let total_views: Int
    let email: String
    let profileimg: String
    let total_answer: Int
    let dob: String
    let about : About
}

struct About {
    let achievements : String
    let contribution : Int
    let profileLinks : ProfileLinks
    let projects : [String]
    let tags : [String]
}

struct ProfileLinks {
    let codechef : String
    let codeforces : String
    let github : String
}

public enum DatabaseErrors : Error {
    case failedToFetch
}


extension userDatabase {

    //MARK: get profile id user detail
    public func getUserDetail(completion : @escaping (Result<User, Error>)->Void){
    
        
        if let uid = Auth.auth().currentUser?.uid {
            
            let docRef = db.collection(K.FUser.users).document(uid)
            docRef.getDocument { (document, error) in
                
                if let document = document, document.exists {
//                    print(document.data())
                    if let data = document.data(){
                        
                        // user detail
                        guard let name = data[K.FUser.name] as? String else { return }
                        guard let answer = data[K.FUser.total_answer] as? Int else { return }
                        guard let views = data[K.FUser.total_views] as? Int else {return }
                        guard let query = data[K.FUser.query_asked] as? Int else { return }
                        guard let dob = data[K.FUser.dob] as? String else { return }
                        guard let phone = data[K.FUser.phone] as? String else { return }
                        guard let email = data[K.FUser.email] as? String else { return }
                        guard let profleImg = data[K.FUser.profileimg] as? String else { return }
                        
                        // about user
                        guard let about = data[K.FUser.about] as? [String:Any] else { return }
                        guard let aboutAchievment = about[K.FAbout.achievements] as? String else { return }
                        guard let aboutContribution = about[K.FAbout.contribution] as? Int else { return }
                        guard let aboutTags = about[K.FAbout.tags] as? [String] else { return}
                        guard let aboutProjects = about[K.FAbout.projects] as? [String] else { return }

                        // about user profile links
                        guard let profileLink = about[K.FAbout.profileLinks] as? [String:Any] else { return }
                        guard let profileLinksCC = profileLink[K.FProfileLinks.codechef] as? String else { return }
                        guard let profileLinksCF = profileLink[K.FProfileLinks.codeforces] as? String else { return }
                        guard let profileLinksGH = profileLink[K.FProfileLinks.github] as? String else { return }
                        
                        // it is used to chache the email locally with this key
                        UserDefaults.standard.set(name, forKey: "name")
                        UserDefaults.standard.set(uid, forKey: "uid")
                        
                        let profileLinkDetail = ProfileLinks(codechef: profileLinksCC, codeforces: profileLinksCF, github: profileLinksGH)
                        let userabout = About(achievements: aboutAchievment, contribution: aboutContribution, profileLinks: profileLinkDetail, projects: aboutProjects, tags: aboutTags)
                        
                        let userDetail = User(query_asked: query, phone: phone, name: name, total_views: views, email: email, profileimg: profleImg, total_answer : answer , dob: dob, about: userabout)
//                        print(userDetail)
                        
                        completion(.success(userDetail))
                    }
                    
                } else {
                    print("Document does not exist")
                    completion(.failure(DatabaseErrors.failedToFetch))
                }
            }
        }
        
    }
}
