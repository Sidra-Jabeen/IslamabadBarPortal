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

struct UpdateUser {
    
    let Source: String
    let userId: String
    let fullName: String
    let dob: String
    let contactNumber: String
    let email: String
    let officeAddress: String
    
    
    var params: [String: String] {
        return [
            "Source": Source,
            "userId": userId,
            "fullName": fullName,
            "dob": dob,
            "contactNumber": contactNumber,
            "email": email,
            "officeAddress": officeAddress,
        ]
    }
}

struct ProfileAttachmentFileRequestModel {
    
    let profilePicture: String
    
    var params: [String: String] {
        return [
            "profilePicture" : profilePicture
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
    var secondaryContactNumber: String?
    var email: String?
    var licenseUrl: String?
    var licenseType: String?
    var issuanceDateLowerCourt: String?
    var issuanceDateHighCourt: String?
    var issuanceDateSupremeCourt: String?
    var officeAddress: String?
    var status: String?
    var profileUrl: String?
    var isAdmin: Bool?
    var roleId: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "userId"
        case fullName = "fullName"
        case cnic = "cnic"
        case dob = "dob"
        case licenseNumber = "licenseNumber"
        case contactNumber = "contactNumber"
        case secondaryContactNumber = "secondaryContactNumber"
        case email = "email"
        case licenseUrl = "licenseUrl"
        case licenseType = "licenseType"
        case issuanceDateLowerCourt = "issuanceDateLowerCourt"
        case issuanceDateHighCourt = "issuanceDateHighCourt"
        case issuanceDateSupremeCourt = "issuanceDateSupremeCourt"
        case officeAddress = "officeAddress"
        case status = "status"
        case profileUrl = "profileUrl"
        case isAdmin = "isAdmin"
        case roleId = "roleId"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        cnic = try values.decodeIfPresent(String.self, forKey: .cnic)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        licenseNumber = try values.decodeIfPresent(String.self, forKey: .licenseNumber)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        secondaryContactNumber = try values.decodeIfPresent(String.self, forKey: .secondaryContactNumber)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        licenseUrl = try values.decodeIfPresent(String.self, forKey: .licenseUrl)
        licenseType = try values.decodeIfPresent(String.self, forKey: .licenseType)
        issuanceDateLowerCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateLowerCourt)
        issuanceDateHighCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateHighCourt)
        issuanceDateSupremeCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateSupremeCourt)
        officeAddress = try values.decodeIfPresent(String.self, forKey: .officeAddress)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        profileUrl = try values.decodeIfPresent(String.self, forKey: .profileUrl)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
    }
}
