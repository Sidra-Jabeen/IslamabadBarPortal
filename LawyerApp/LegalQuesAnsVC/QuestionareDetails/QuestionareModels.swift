//
//  QuestionareModels.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/26/21.
//

import Foundation

struct commentRequestModel {
    
    let pagination : pagination
    let source : String
    let question : question
    
    var params: [String: Any] {
        
        return [
            "source": source,
            "pagination" : pagination,
            "question" : question
        ]
    }
    
}

struct pagination {
    
    let limit:Int
    let offset:Int
    
    var params: [String: Any] {
        return [
            "limit": limit,
            "offset" : offset
        ]
    }
}

struct question {
    
    let id : Int
    
    var params: [String: Any] {
        return [
            "id": id
        ]
    }
}

struct CommentResponseModel: Codable {
    
    let code: String?
    let desc: String?
    let comment: CommentResponseModelComment?
    let questionDetail: QuestionDetail?
}

struct CommentResponseModelComment: Codable {
    
    let comments: [CommentElement]?
}

struct CommentElement: Codable {
    
    let commentID: Int?
    let parentCommentID: Int?
    let questionID: Int?
    let comment: String?
    let commentBy: String?
    let commentByID: String?
    let commentAt: String?
    let commentByURL: String?
    let replyToID: Int?
    let replyToName: String?
    let commentReplies: [CommentElement]?
    let commentAttachments: [CommentAttachment]?

    enum CodingKeys: String, CodingKey {
        
        case commentID = "commentId"
        case parentCommentID = "parentCommentId"
        case questionID = "questionId"
        case comment, commentBy
        case commentByID = "commentById"
        case commentAt
        case commentByURL = "commentByUrl"
        case replyToID = "replyToId"
        case replyToName, commentReplies, commentAttachments
    }
}

struct CommentAttachment: Codable {
    
    let questionAttachmentID: Int?
    let commentID: Int?
    let attachmentURL: String?

    enum CodingKeys: String, CodingKey {
        
        case questionAttachmentID = "questionAttachmentId"
        case commentID = "commentId"
        case attachmentURL = "attachmentUrl"
    }
}

struct QuestionDetail: Codable {
    
    let qID: Int?

    enum CodingKeys: String, CodingKey {
        case qID = "qId"
    }

}
