

import Foundation

// MARK: - CommentResponseModel
struct CommentResponseModel: Codable {
    let code: String?
    let desc: String?
    let comment: CommentResponseModelComment?
    let questionDetail: QuestionDetail?
}

// MARK: - CommentResponseModelComment
struct CommentResponseModelComment: Codable {
    let comments: [CommentElement]?
}

// MARK: - CommentElement

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

// MARK: - CommentAttachment
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

// MARK: - QuestionDetail
struct QuestionDetail: Codable {
    let qID: Int?

    enum CodingKeys: String, CodingKey {
        case qID = "qId"
    }
}





///  Comments
////
////  Created by Umair Yousaf on 22/10/2021.
////
//
//struct CommentResponseModel : Codable{
//
//    let code:String?
//    let desc:String?
//
//    let comment: [comment]?
//
//}
//
//struct comment : Codable{
//
//    let comments:[comments]?
//}
//struct comments:Codable {
//    let commentId:Int?
//    let parentCommentId:Int?
//    let questionId:Int?
//    let comment:String?
//    let commentBy:String?
//    let commentById:String?
//    let commentByUrl:String?
//    let replyToId:Int?
//    let replyToName:String?
//    let commentReplies:[commentReplies]?
//}
//struct commentReplies:Codable {
//    let commentId:Int?
//    let parentCommentId:Int?
//    let questionId:Int?
//    let comment:String?
//    let commentBy:String?
//    let commentById:String?
//    let commentAt:String?
//    let commentByUrl:String?
//    let replyToId:Int?
//    let replyToName:String?
////    let commentAttachments:[commentAttachments]?
//}
//
////struct commentAttachments:Codable {
////    let questionAttachmentId:Int?
////    let commentId:Int?
////    let attachmentUrl:String?
////}
//
//
//
//
//
