//
//  QuestionRequestModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import Foundation

struct QuestionRequestModel {
    
    let source: String
    let pagination: PaginationModel
    
    var params: [String: Any] {
        return [
            "source": source,
            "pagination" : pagination.params
        ]
    }
}

struct SearchQuestionRequestModel {
    
    let pagination: PaginationModel
    let question: SearchQuestion
    let source: String
    let user: LoginUser
    
    var params: [String: Any] {
        return [
            
            "pagination" : pagination.params,
            "question": question.params,
            "source" : source,
            "user" : user.params
        ]
    }
}

struct SearchQuestion {
    
    let isLoadMore: Bool
    let id: Int
    let title: String
    
    var params: [String: Any] {
        return [
            "isLoadMore": isLoadMore,
            "id" : id,
            "title" : title
        ]
    }
}

struct LoginUser {
    
    let licenseNumber: String
    let password: String
    
    var params: [String: Any] {
        return [
            "licenseNumber": licenseNumber,
            "password" : password
        ]
    }
}


struct QuesResponseModel: Codable {
    
    var id: Int?
    var title: String?
    var description: String?
    var censoredTitle: String?
    var censoredDescription: String?
    var postedAt: String?
    var postedBy: String?
    var postedById: String?
    var postedByProfileUrl: String?
    var totalComments: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case description = "description"
        case censoredTitle = "censoredTitle"
        case censoredDescription = "censoredDescription"
        case postedAt = "postedAt"
        case postedBy = "postedBy"
        case postedById = "postedById"
        case postedByProfileUrl = "postedByProfileUrl"
        case totalComments = "totalComments"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        censoredTitle = try values.decodeIfPresent(String.self, forKey: .censoredTitle)
        censoredDescription = try values.decodeIfPresent(String.self, forKey: .censoredDescription)
        postedAt = try values.decodeIfPresent(String.self, forKey: .postedAt)
        postedBy = try values.decodeIfPresent(String.self, forKey: .postedBy)
        postedById = try values.decodeIfPresent(String.self, forKey: .postedById)
        postedByProfileUrl = try values.decodeIfPresent(String.self, forKey: .postedByProfileUrl)
        totalComments = try values.decodeIfPresent(String.self, forKey: .totalComments)

    }
}

struct QuestionPostAttachmentRequestModel {
    
    let attachmentFile: String
    
    var params: [String: String] {
        return [
            "attachmentFile" : attachmentFile
        ]
    }
}

struct QuestionPostDataRequestModel {
    
    let questionId: String
    let type: String
    
    var params: [String: String] {
        return [
            "questionId": questionId,
            "type" : type
        ]
    }
}

struct PostQuestionRequestModel {
    
    let source: String
    let question: Question
    
    var params: [String: Any] {
        return [
            "source": source,
            "question" : question.params
        ]
    }
}

struct Question {
    
    let title: String
    let description: String
    
    var params: [String: Any] {
        return [
            "title": title,
            "description" : description
        ]
    }
}

struct PostQuesResponseModel: Codable {
    
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
}


