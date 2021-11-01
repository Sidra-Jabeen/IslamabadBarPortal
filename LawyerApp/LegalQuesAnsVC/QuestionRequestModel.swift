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

struct QuesResponseModel: Codable {
    
    var qId: Int?
    var title: String?
    var description: String?
    var postedAt: String?
    var postedBy: String?
    var postedById: String?
    var postedByProfileUrl: String?
    var totalComments: String?
    
    enum CodingKeys: String, CodingKey {
        
        case qId = "id"
        case title = "title"
        case description = "description"
        case postedAt = "postedAt"
        case postedBy = "postedBy"
        case postedById = "postedById"
        case postedByProfileUrl = "postedByProfileUrl"
        case totalComments = "totalComments"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        qId = try values.decodeIfPresent(Int.self, forKey: .qId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        postedAt = try values.decodeIfPresent(String.self, forKey: .postedAt)
        postedBy = try values.decodeIfPresent(String.self, forKey: .postedBy)
        postedById = try values.decodeIfPresent(String.self, forKey: .postedById)
        postedByProfileUrl = try values.decodeIfPresent(String.self, forKey: .postedByProfileUrl)
        totalComments = try values.decodeIfPresent(String.self, forKey: .totalComments)

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
    
    var qId: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case qId = "qId"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        qId = try values.decodeIfPresent(Int.self, forKey: .qId)
    }
}


