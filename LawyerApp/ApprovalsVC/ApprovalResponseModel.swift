//
//  ApprovalResponseModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import Foundation

struct ApprovalResponseModel {
    
    let desc: String
    let success: String
    let users: ResponseUsers
    let code: String
    
    var params: [String:Any] {
        return [
            "desc": desc,
            "success": success,
            "ResponseUsers": users.params,
            "code": code
        ]
    }
}
    
    struct ResponseUsers {
        
        let cnic: String
        let contactNumber: String
        let dob: String
        let fullName: String
        let isAdmin: String
        let issuanceDateHighCourt: String
        let issuanceDateLowerCourt: String
        let issuanceDateSupremeCourt: String
        let licenseNumber: String
        let licenseType: String
        let officeAddress: String
        let profileUrl: String
        let userId: String
        
        var params: [String:Any] {
            return [
                "cnic": cnic,
                "contactNumber": contactNumber,
                "dob": dob,
                "fullName": fullName,
                "isAdmin": isAdmin,
                "issuanceDateHighCourt": issuanceDateHighCourt,
                "issuanceDateLowerCourt": issuanceDateLowerCourt,
                "issuanceDateSupremeCourt": issuanceDateSupremeCourt,
                "licenseNumber": licenseNumber,
                "licenseType": licenseType,
                "officeAddress": officeAddress,
                "profileUrl": profileUrl,
                "userId": userId
            ]
        }
    }
