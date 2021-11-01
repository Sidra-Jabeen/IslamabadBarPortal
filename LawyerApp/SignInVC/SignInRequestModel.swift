//
//  SignRequestModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation

struct SignInRequestModel {

    let source: String
    let user: SignInUser

    var params: [String: Any] {
        return [
            "source": source,
            "user" : user.params
        ]
    }
}

struct SignInUser {
    
    let licenseNumber: String
    let password: String

    var params: [String: Any] {
        return [
            "licenseNumber": licenseNumber,
            "password" : password
        ]
    }
}


struct SignInResponseModel: Codable {
    
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
    var loginToken: String?
    var status: String?
    var profileUrl: String?
    var roleId: Int?
    var isAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "userId"
        case fullName = "fullName"
        case cnic = "cnic"
        case dob = "dob"
        case loginToken = "loginToken"
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
        case roleId = "roleId"
        case isAdmin = "isAdmin"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        cnic = try values.decodeIfPresent(String.self, forKey: .cnic)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        loginToken = try values.decodeIfPresent(String.self, forKey: .loginToken)
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
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
    }
}

