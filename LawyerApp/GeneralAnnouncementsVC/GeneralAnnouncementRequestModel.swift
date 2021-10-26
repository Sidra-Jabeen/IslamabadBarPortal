//
//  GeneralAnnouncementRequestModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 16/10/2021.
//

import Foundation

struct GeneralAnnouncementRequestModel {
    
    let source: String
    let pagination: PaginationModel
    let memberAnnouncement: GeneralAnnouncement?
    
    var params: [String: Any] {
        return [
            "source": source,
            "pagination" : pagination.params,
            "memberAnnouncement" : memberAnnouncement?.params as Any,
        ]
    }
}

struct GeneralAnnouncement {
    
    let memberAnnouncementId: Int?
    let toDate: String?
    let fromDate: String?
    let duration: String?
    
    var params: [String: Any] {
        return [

            "memberAnnouncementId" : memberAnnouncementId as Any,
            "toDate" : toDate as Any,
            "fromDate" : fromDate as Any,
            "duration" : duration as Any,
        ]
    }
}


struct GeneralAnnouncementRequestModel1 {
    
    let source: String
    let pagination: PaginationModel
    let memberAnnouncement: GeneralAnnouncement1
    
    var params: [String: Any] {
        return [
            "source": source,
            "pagination" : pagination.params,
            "memberAnnouncement" : memberAnnouncement,
        ]
    }
}

struct GeneralAnnouncement1 {
    
//    let memberAnnouncementId: Int
//    let startDate: String
//    let fromDate: String
    
//    var params: [String: Any] {
//        return [
//
//            "memberAnnouncementId" : memberAnnouncementId,
//            "startDate" : startDate,
//            "fromDate" : fromDate
//        ]
//    }
}

struct GeneralPostAnnouncementRequestModel {
    
    let source: String
    let memberAnnouncement: MemberAnnouncements
    
    var params: [String: Any] {
        return [
            "source": source,
            "memberAnnouncement" : memberAnnouncement.params
        ]
    }
}


struct MemberAnnouncements {
    
    let title: String
    let description: String
    
    var params: [String: Any] {
        return [
            "title": title,
            "description": description,
        ]
    }
}


struct GeneralPostAttachmentFileRequestModel {
    
    let attachmentFile: String
    
    var params: [String: String] {
        return [
            "attachmentFile" : attachmentFile
        ]
    }
}

struct GeneralPostDataRequestModel {
    
    let announcementId: String
    let type: String
    
    var params: [String: String] {
        return [
            "announcementId": announcementId,
            "type" : type
        ]
    }
}


struct GeneralAnnouncementDetailsRequestModel {
    
    let source: String
    let memberAnnouncement: GeneralAnnouncementDetails
    
    var params: [String: Any] {
        return [
            "source": source,
            "memberAnnouncement" : memberAnnouncement.params
        ]
    }
}


struct GeneralAnnouncementDetails {
    
    let memberAnnouncementId: Int
    
    var params: [String: Any] {
        return [
            "memberAnnouncementId": memberAnnouncementId
        ]
    }
}


struct GeneralAnnouncementResponseModel: Codable {
    
    var memberAnnouncementId: Int?
    var title: String?
    var description: String?
    var announcedBy: String?
    var announcedAt: String?
    var announcedByProfile: String?
    var type: String?
    var typeNames: String?
    
    enum CodingKeys: String, CodingKey {
        
        case memberAnnouncementId = "memberAnnouncementId"
        case title = "title"
        case description = "description"
        case announcedBy = "announcedBy"
        case announcedAt = "announcedAt"
        case announcedByProfile = "announcedByProfile"
        case type = "type"
        case typeNames = "typeNames"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        memberAnnouncementId = try values.decodeIfPresent(Int.self, forKey: .memberAnnouncementId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        announcedBy = try values.decodeIfPresent(String.self, forKey: .announcedBy)
        announcedAt = try values.decodeIfPresent(String.self, forKey: .announcedAt)
        announcedByProfile = try values.decodeIfPresent(String.self, forKey: .announcedByProfile)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        typeNames = try values.decodeIfPresent(String.self, forKey: .typeNames)

    }
}

struct GeneralAnnouncementResponseDetailModel: Codable {
    
    var memberAnnouncementId: Int?
    var title: String?
    var description: String?
    var announcedBy: String?
    var announcedAt: String?
    var announcedByProfile: String?
    var attachments: [AttachmentResponse]?
    
    enum CodingKeys: String, CodingKey {
        
        case memberAnnouncementId = "memberAnnouncementId"
        case title = "title"
        case description = "description"
        case announcedBy = "announcedBy"
        case announcedAt = "announcedAt"
        case announcedByProfile = "announcedByProfile"
        case attachments = "attachments"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        memberAnnouncementId = try values.decodeIfPresent(Int.self, forKey: .memberAnnouncementId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        announcedBy = try values.decodeIfPresent(String.self, forKey: .announcedBy)
        announcedAt = try values.decodeIfPresent(String.self, forKey: .announcedAt)
        announcedByProfile = try values.decodeIfPresent(String.self, forKey: .announcedByProfile)
        attachments = try values.decodeIfPresent([AttachmentResponse].self, forKey: .attachments)

    }
}

struct AttachmentResponse: Codable {
    
    var id: Int?
    var announcementId: Int?
    var type: Int?
    var attachmentUrl: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case announcementId = "announcementId"
        case type = "type"
        case attachmentUrl = "announcedBy"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        announcementId = try values.decodeIfPresent(Int.self, forKey: .announcementId)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        attachmentUrl = try values.decodeIfPresent(String.self, forKey: .attachmentUrl)
    }
}
