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
    
    var memberAnnouncementId: Int?
    var title: String?
    var description: String?
    var announcedBy: String?
    var announcedAt: String?
    
    enum CodingKeys: String, CodingKey {
        
        case memberAnnouncementId = "memberAnnouncementId"
        case title = "title"
        case description = "description"
        case announcedBy = "announcedBy"
        case announcedAt = "announcedAt"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        memberAnnouncementId = try values.decodeIfPresent(Int.self, forKey: .memberAnnouncementId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        announcedBy = try values.decodeIfPresent(String.self, forKey: .announcedBy)
        announcedAt = try values.decodeIfPresent(String.self, forKey: .announcedAt)

    }
}


struct AnnouncementResponseModel: Codable {
    
    var barAnnouncementId: Int?
    var title: String?
    var description: String?
    var announcedBy: String?
    var announcedAt: String?
    
    enum CodingKeys: String, CodingKey {
        
        case barAnnouncementId = "barAnnouncementId"
        case title = "title"
        case description = "description"
        case announcedBy = "announcedBy"
        case announcedAt = "announcedAt"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        barAnnouncementId = try values.decodeIfPresent(Int.self, forKey: .barAnnouncementId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        announcedBy = try values.decodeIfPresent(String.self, forKey: .announcedBy)
        announcedAt = try values.decodeIfPresent(String.self, forKey: .announcedAt)

    }
}
