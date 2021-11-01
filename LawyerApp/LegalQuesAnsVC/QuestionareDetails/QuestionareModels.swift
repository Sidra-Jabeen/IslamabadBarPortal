//
//  QuestionareModels.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/26/21.
//

import Foundation

struct QuestionareRequestModel {
    
    var pagination : Pagination
    var source : String
    var question : QuestionModel
    
    var params: [String: Any] {
        
        return [
            "source": source as Any,
            "pagination" : pagination.params as Any,
            "question" : question.params as Any
        ]
    }
    
}

struct Pagination {
    
    let limit:Int
    let offset:Int
    
    var params: [String: Any] {
        return [
            "limit": limit,
            "offset" : offset
        ]
    }
}

struct QuestionModel {
    
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
    let questionDetail: QuestionDetailResponseModel?
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

struct QuestionDetailResponseModel: Codable {
    
    let qId: Int?
    let title: String?
    let description: String?
    let postedAt: String?
    let postedBy: String?
    let postedById: String?
    let postedByProfileUrl: String?
    let questionAttachments: [QuestionareAttachment]?

    enum CodingKeys: String, CodingKey {
        
        case qId = "qId"
        case title = "title"
        case description = "description"
        case postedAt = "postedAt"
        case postedBy = "postedBy"
        case postedById = "postedById"
        case postedByProfileUrl = "postedByProfileUrl"
        case questionAttachments = "questionAttachments"
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
        questionAttachments = try values.decodeIfPresent([QuestionareAttachment].self, forKey: .questionAttachments)
    }
}

struct QuestionareAttachment: Codable {
    
    let questionAttachmentId: Int?
    let attachmentUrl: String?

    enum CodingKeys: String, CodingKey {
        
        case questionAttachmentId = "questionAttachmentId"
        case attachmentUrl = "attachmentUrl"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        questionAttachmentId = try values.decodeIfPresent(Int.self, forKey: .questionAttachmentId)
        attachmentUrl = try values.decodeIfPresent(String.self, forKey: .attachmentUrl)
    }
}

struct GetCommentModel: Codable {
    
    let comment: [GetCommentDetailsModel]?
    
    enum CodingKeys: String, CodingKey {
        case comment = "comment"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comment = try values.decodeIfPresent([GetCommentDetailsModel].self, forKey: .comment)
    }
    
}

struct GetCommentDetailsModel: Codable {
    
    let commentId: Int?
    let parentCommentId: Int?
    let questionId: Int?
    let comment: String?
    let commentBy: String?
    let commentById: String?
    let commentAt: String?
    let commentByUrl: String?
    let replyToId: Int?
    let replyToName: String?
    let commentReplies: [GetCommentDetailsModel]?
    let commentAttachments: [CommentAttachmentModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case commentId = "commentId"
        case parentCommentId = "parentCommentId"
        case questionId = "questionId"
        case comment = "comment"
        case commentBy = "commentBy"
        case commentById = "commentById"
        case commentAt = "commentAt"
        case commentByUrl = "commentByUrl"
        case replyToId = "replyToId"
        case replyToName = "replyToName"
        case commentReplies = "commentReplies"
        case commentAttachments = "commentAttachments"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        commentId = try values.decodeIfPresent(Int.self, forKey: .commentId)
        parentCommentId = try values.decodeIfPresent(Int.self, forKey: .parentCommentId)
        questionId = try values.decodeIfPresent(Int.self, forKey: .questionId)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        commentBy = try values.decodeIfPresent(String.self, forKey: .commentBy)
        commentById = try values.decodeIfPresent(String.self, forKey: .commentById)
        commentAt = try values.decodeIfPresent(String.self, forKey: .commentAt)
        commentByUrl = try values.decodeIfPresent(String.self, forKey: .commentByUrl)
        replyToId = try values.decodeIfPresent(Int.self, forKey: .replyToId)
        replyToName = try values.decodeIfPresent(String.self, forKey: .replyToName)
        commentReplies = try values.decodeIfPresent([GetCommentDetailsModel].self, forKey: .commentReplies)
        commentAttachments = try values.decodeIfPresent([CommentAttachmentModel].self, forKey: .commentAttachments)
    }
    
}

struct CommentAttachmentModel: Codable {
    
    let questionAttachmentId: Int?
    let commentId: Int?
    let attachmentUrl: String?

    enum CodingKeys: String, CodingKey {
        
        case questionAttachmentId = "questionAttachmentId"
        case commentId = "commentId"
        case attachmentUrl = "attachmentUrl"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        questionAttachmentId = try values.decodeIfPresent(Int.self, forKey: .questionAttachmentId)
        attachmentUrl = try values.decodeIfPresent(String.self, forKey: .attachmentUrl)
        commentId = try values.decodeIfPresent(Int.self, forKey: .commentId)
    }
}
