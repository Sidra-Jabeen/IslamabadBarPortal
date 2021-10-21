//
//  OfficialDirectoryModels.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 21/10/2021.
//

import Foundation

struct OfficialDirectoryRequestModel {
    
    let source: String
    let pagination: PaginationModel
    let OfficialDirectory: OfficialModel?
    
    var params: [String: Any] {
        return [
            "source": source,
            "pagination" : pagination.params,
            "OfficialDirectory" : OfficialDirectory?.params as Any,
        ]
    }
}

struct OfficialModel {
    
    let fullName: String?
    let memberOff: String?
    
    var params: [String: Any] {
        return [

            "fullName" : fullName as Any,
            "memberOff" : memberOff as Any,
        ]
    }
}

struct OfficialDirectoryResponseModel: Codable {
    
    var directoryId: Int?
    var fullName: String?
    var designation: String?
    var contactNumber: String?
    var officeAddress: String?
    var memberOff: String?
    
    enum CodingKeys: String, CodingKey {
        
        case directoryId = "directoryId"
        case fullName = "fullName"
        case designation = "designation"
        case contactNumber = "contactNumber"
        case officeAddress = "officeAddress"
        case memberOff = "memberOff"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        directoryId = try values.decodeIfPresent(Int.self, forKey: .directoryId)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        designation = try values.decodeIfPresent(String.self, forKey: .designation)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        officeAddress = try values.decodeIfPresent(String.self, forKey: .officeAddress)
        memberOff = try values.decodeIfPresent(String.self, forKey: .memberOff)

    }
}
