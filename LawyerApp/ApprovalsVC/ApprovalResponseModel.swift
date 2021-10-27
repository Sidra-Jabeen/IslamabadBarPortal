//
//  ApprovalResponseModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import Foundation

//struct ApprovalResponseModel {
//
//    let desc: String
//    let success: Bool
//    let users: [ResponseUsers]
//    let code: String
//
//    var params: [String:Any] {
//        return [
//            "desc": desc,
//            "success": success,
//            "ResponseUsers": users,
//            "code": code
//        ]
//    }
//}
//
//    struct ResponseUsers {
//
//        let cnic: String
//        let contactNumber: String
//        let dob: String
//        let fullName: String
//        let isAdmin: String
//        let issuanceDateHighCourt: String
//        let issuanceDateLowerCourt: String
//        let issuanceDateSupremeCourt: String
//        let licenseNumber: String
//        let licenseType: String
//        let officeAddress: String
//        let profileUrl: String
//        let userId: String
//        let PORDER_BY: String
//
//        var params: [String:Any] {
//            return [
//                "cnic": cnic,
//                "contactNumber": contactNumber,
//                "dob": dob,
//                "fullName": fullName,
//                "isAdmin": isAdmin,
//                "issuanceDateHighCourt": issuanceDateHighCourt,
//                "issuanceDateLowerCourt": issuanceDateLowerCourt,
//                "issuanceDateSupremeCourt": issuanceDateSupremeCourt,
//                "licenseNumber": licenseNumber,
//                "licenseType": licenseType,
//                "officeAddress": officeAddress,
//                "profileUrl": profileUrl,
//                "userId": userId,
//                "PORDER_BY": PORDER_BY,
//            ]
//        }
//    }


//struct ApprovalResponseModel: Codable {
//
//    var desc: String?
//    var success: Bool?
//    var users: [ResponseUsers]?
//    var code: String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case desc = "desc"
//        case success = "success"
//        case users = "users"
//        case code = "code"
//    }
//
//    init(from decoder: Decoder) throws {
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        desc = try values.decodeIfPresent(String.self, forKey: .desc)
//        success = try values.decodeIfPresent(Bool.self, forKey: .success)
//        users = try values.decodeIfPresent([ResponseUsers].self, forKey: .users)
//        code = try values.decodeIfPresent(String.self, forKey: .code)
//    }
//}

struct ResponseUsers: Codable {
    
    var cnic: String?
    var contactNumber: String?
    var secondaryContactNumber: String?
    var dob: String?
    var fullName: String?
    var isAdmin: Bool?
    var issuanceDateHighCourt: String?
    var issuanceDateLowerCourt: String?
    var issuanceDateSupremeCourt: String?
    var licenseNumber: String?
    var licenseUrl: String?
    var licenseType: String?
    var officeAddress: String?
    var profileUrl: String?
    var userId: Int?
    var status: String?
    var email: String?
    var roleId: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case cnic = "cnic"
        case contactNumber = "contactNumber"
        case secondaryContactNumber = "secondaryContactNumber"
        case dob = "dob"
        case fullName = "fullName"
        case isAdmin = "isAdmin"
        case issuanceDateHighCourt = "issuanceDateHighCourt"
        case issuanceDateLowerCourt = "issuanceDateLowerCourt"
        case issuanceDateSupremeCourt = "issuanceDateSupremeCourt"
        case licenseNumber = "licenseNumber"
        case licenseUrl = "licenseUrl"
        case licenseType = "licenseType"
        case officeAddress = "officeAddress"
        case profileUrl = "profileUrl"
        case userId = "userId"
        case status = "status"
        case email = "email"
        case roleId = "roleId"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cnic = try values.decodeIfPresent(String.self, forKey: .cnic)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        secondaryContactNumber = try values.decodeIfPresent(String.self, forKey: .secondaryContactNumber)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
        issuanceDateHighCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateHighCourt)
        issuanceDateLowerCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateLowerCourt)
        issuanceDateSupremeCourt = try values.decodeIfPresent(String.self, forKey: .issuanceDateSupremeCourt)
        licenseNumber = try values.decodeIfPresent(String.self, forKey: .licenseNumber)
        licenseUrl = try values.decodeIfPresent(String.self, forKey: .licenseUrl)
        licenseType = try values.decodeIfPresent(String.self, forKey: .licenseType)
        officeAddress = try values.decodeIfPresent(String.self, forKey: .officeAddress)
        profileUrl = try values.decodeIfPresent(String.self, forKey: .profileUrl)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
    }
}
