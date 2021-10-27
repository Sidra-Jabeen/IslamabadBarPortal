//
//  AnnouncementModels.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 16/10/2021.
//

import Foundation

struct AnnouncementRequestModel {
    
    let source: String
    let pagination: PaginationModel
    let barAnnouncement: BarAnnouncement?
    
    var params: [String: Any] {
        return [
            "source": source,
            "pagination" : pagination.params,
            "barAnnouncement" : barAnnouncement?.params as Any,
        ]
    }
}

struct BarAnnouncement {
    
    let barAnnouncementId: Int?
    let toDate: String?
    let fromDate: String?
    let duration: String?
    
    var params: [String: Any] {
        return [
            "barAnnouncementId": barAnnouncementId as Any,
            "toDate" : toDate as Any,
            "fromDate" : fromDate as Any,
            "duration" : duration as Any
        ]
    }
}

struct PostAnnouncementRequestModel {
    
    let source: String
    let barAnnouncement: Announcement
    
    var params: [String: Any] {
        return [
            "source": source,
            "barAnnouncement" : barAnnouncement.params
        ]
    }
}

struct Announcement {
    
    let title: String
    let description: String
    let type: String
    
    var params: [String: Any] {
        return [
            "title": title,
            "description" : description,
            "type" : type
        ]
    }
}

struct PostAttachmentFileRequestModel {
    
    let attachmentFile: String
    
    var params: [String: String] {
        return [
            "attachmentFile" : attachmentFile
        ]
    }
}

struct PostDataRequestModel {
    
    let announcementId: String
    let type: String
    
    var params: [String: String] {
        return [
            "announcementId": announcementId,
            "type" : type
        ]
    }
}

struct AnnouncementDetailsRequestModel {
    
    let source: String
    let barAnnouncement: Details
    
    var params: [String: Any] {
        return [
            "source": source,
            "barAnnouncement" : barAnnouncement.params
        ]
    }
}


struct Details {
    
    let barAnnouncementId: Int
    
    var params: [String: Any] {
        return [
            "barAnnouncementId": barAnnouncementId
        ]
    }
}

struct BarAnnouncementResponseDetailModel: Codable {
    
    var barAnnouncementId: Int?
    var title: String?
    var description: String?
    var announcedBy: String?
    var announcedAt: String?
    var type: String?
    var announcedByProfile: String?
    var typeNames: String?
    var attachments: [AttachmentResponse]?
    
    enum CodingKeys: String, CodingKey {
        
        case barAnnouncementId = "barAnnouncementId"
        case title = "title"
        case description = "description"
        case announcedBy = "announcedBy"
        case announcedAt = "announcedAt"
        case type = "type"
        case announcedByProfile = "announcedByProfile"
        case typeNames = "typeNames"
        case attachments = "attachments"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        barAnnouncementId = try values.decodeIfPresent(Int.self, forKey: .barAnnouncementId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        announcedBy = try values.decodeIfPresent(String.self, forKey: .announcedBy)
        announcedAt = try values.decodeIfPresent(String.self, forKey: .announcedAt)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        announcedByProfile = try values.decodeIfPresent(String.self, forKey: .announcedByProfile)
        typeNames = try values.decodeIfPresent(String.self, forKey: .typeNames)
        attachments = try values.decodeIfPresent([AttachmentResponse].self, forKey: .attachments)

    }
}
                
struct BarAttachmentResponse: Codable {
    
    var id: Int?
    var announcementId: Int?
    var type: Int?
    var attachmentUrl: String?
    var isDocType: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case announcementId = "announcementId"
        case type = "type"
        case attachmentUrl = "attachmentUrl"
        case isDocType = "isDocType"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        announcementId = try values.decodeIfPresent(Int.self, forKey: .announcementId)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        attachmentUrl = try values.decodeIfPresent(String.self, forKey: .attachmentUrl)
        isDocType = try values.decodeIfPresent(String.self, forKey: .isDocType)
    }
}

struct AnnouncementResponseModel: Codable {
    
    var barAnnouncementId: Int?
    var title: String?
    var description: String?
    var announcedBy: String?
    var announcedAt: String?
    var announcedByProfile: String?
    var type: String?
    var typeNames: String?
    
    enum CodingKeys: String, CodingKey {
        
        case barAnnouncementId = "barAnnouncementId"
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
        barAnnouncementId = try values.decodeIfPresent(Int.self, forKey: .barAnnouncementId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        announcedBy = try values.decodeIfPresent(String.self, forKey: .announcedBy)
        announcedAt = try values.decodeIfPresent(String.self, forKey: .announcedAt)
        announcedByProfile = try values.decodeIfPresent(String.self, forKey: .announcedByProfile)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        typeNames = try values.decodeIfPresent(String.self, forKey: .typeNames)

    }
}
