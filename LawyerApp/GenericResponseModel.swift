//
//  GenericModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import Foundation

struct GenericResponseModel <T : Codable> : Codable {
    
    var desc: String?
    var success: Bool?
    var users: [T]?
    var code: String?
    var user: T?
    var questions: [T]?
    var question: T?
    var barAnnouncements: [T]?
    var memberAnnouncements: [T]?
    
    enum CodingKeys: String, CodingKey {
        
        case desc = "desc"
        case success = "success"
        case users = "users"
        case code = "code"
        case user = "user"
        case questions = "questions"
        case question = "question"
        case barAnnouncements = "barAnnouncements"
        case memberAnnouncements = "memberAnnouncements"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        users = try values.decodeIfPresent([T].self, forKey: .users)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        question = try values.decodeIfPresent(T.self, forKey: .question)
        questions = try values.decodeIfPresent([T].self, forKey: .questions)
        barAnnouncements = try values.decodeIfPresent([T].self, forKey: .barAnnouncements)
        memberAnnouncements = try values.decodeIfPresent([T].self, forKey: .memberAnnouncements)
        
        if values.contains(.user) {
            user = try values.decodeIfPresent(T.self, forKey: .user)
        } else {
            user = nil
        }
    }

        
    }
