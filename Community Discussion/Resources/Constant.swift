//
//  Constant.swift
//  Community Discussion
//
//  Created by Ritik Srivastava on 11/12/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import Foundation

struct K {
    
    struct FUser {
        static let users = "users"
        static let dob = "dob"
        static let answerId = "answerId"
        static let email = "email"
        static let name = "name"
        static let phone = "phone"
        static let profileimg = "profileimg"
        static let query_asked = "query_asked"
        static let total_answer = "total_answer"
        static let total_views = "total_views"
        static let about = "about"
        static let questions = "questions"
    }
    
    struct FAbout {
        static let achievements = "achievements"
        static let contribution = "contribution"
        static let profileLinks = "profileLinks"
        static let tags = "tags"
        static let projects = "projects"
    }
    
    struct FProfileLinks {
        static let codechef = "codechef"
        static let codeforces = "codeforces"
        static let github = "github"
    }
    
    struct FQuestions {
        static let questionId = "questionId"
        static let question = "question"
        static let answercount = "answercount"
        static let  likes = "likes"
        static let  mainQuestion = "mainQuestion"
        static let  name = "name"
        static let  profileimg = "profileimg"
        static let  timestamp = "timestamp"
        static let  tags = "tags"
        static let  title = "title"
        static let  userId = "userId"
        static let  views = "views"
    }
    
    struct FAnswers {
        static let answer = "answer"
        static let content = "content"
        static let  downvote = "downvote"
        static let  upvote = "upvote"
        static let  name = "name"
        static let  userdId = "userId"
        static let  timestamp = "timestamp"
        static let questionId = "questionID"
    }
    
}
