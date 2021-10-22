//
//  ProfileModels.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 20/10/2021.
//

import Foundation

struct ProfileRequestModel {

    let source: String
    let user: ProfileUser

    var params: [String: Any] {
        return [
            "source": source,
            "user" : user.params
        ]
    }
}

struct ProfileUser {
    
    let userId: Int

    var params: [String: Any] {
        return [
            "userId": userId,
        ]
    }
}

struct ProfileResponseModel: Codable {
    
    var userId: Int?
    var fullName: String?
    var cnic: String?
    var dob: String?
    var licenseNumber: String?
    var contactNumber: String?
    var licenseUrl: String?
    var licenseType: String?
    var issuanceDateLowerCourt: String?
    var issuanceDateHighCourt: String?
    var issuanceDateSupremeCourt: String?
    var officeAddress: String?
    var status: String?
    var profileUrl: String?
    var isAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "userId"
        case fullName = "fullName"
        case cnic = "cnic"
        case dob = "dob"
        case licenseNumber = "licenseNumber"
        case contactNumber = "contactNumber"
        case licenseUrl = "licenseUrl"
        case licenseType = "licenseType"
        case issuanceDateLowerCourt = "issuanceDateLowerCourt"
        case issuanceDateHighCourt = "issuanceDateHighCourt"
        case issuanceDateSupremeCourt = "issuanceDateSupremeCourt"
        case officeAddress = "officeAddress"
        case status = "status"
        case profileUrl = "profileUrl"
        case isAdmin = "isAdmin"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        cnic = try values.decodeIfPresent(String.self, forKey: .cnic)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        licenseNumber = try values.decodeIfPresent(String.self, forKey: .licenseNumber)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        licenseUrl = try values.decodeIfPresent(String.self, forKey: .licenseUrl)
        licenseType = try values.decodeIfPresent(String.self, forKey: .licenseType)
        issuanceDateLowerCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateLowerCourt)
        issuanceDateHighCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateHighCourt)
        issuanceDateSupremeCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateSupremeCourt)
        officeAddress = try values.decodeIfPresent(String.self, forKey: .officeAddress)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        profileUrl = try values.decodeIfPresent(String.self, forKey: .profileUrl)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
    }
}