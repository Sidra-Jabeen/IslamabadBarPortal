//
//  MenberDirectoryResponeModel.swift
//  LawyerApp
//
//  Created by Umair Yousaf on 13/10/2021.
//

import Foundation

struct MenberDirectoryResponeModel {
    
    
    let code: String
    let desc: String
    let success: String
    let user: memberDirectoryUser
    
    var params: [String:Any] {
        return [
            "code": code,
            "desc": desc,
            "success": success,
            "user": user.params
        ]
    }
    
}

struct memberDirectoryUser {
    
    let userId: Int
    let fullName: String
    let cnic: String
    let dob: String
    let licenseNumber: String
    let contactNumber: String
    let licenseType: String
    let issuanceDateLowerCourt: String
    let issuanceDateHighCourt: String
    let issuanceDateSupremeCourt: String
    let officeAddress: String
    let profileUrl: String
    let isAdmin: Bool
    
    var params: [String:Any] {
        return [
            "userId": userId,
            "fullName": fullName,
            "cnic": cnic,
            "dob": dob,
            "licenseNumber": licenseNumber,
            "contactNumber": contactNumber,
            "licenseType": licenseType,
            "issuanceDateLowerCourt":issuanceDateLowerCourt,
            "issuanceDateHighCourt": issuanceDateHighCourt,
            "issuanceDateSupremeCourt": issuanceDateSupremeCourt,
            "officeAddress": officeAddress,
            "profileUrl": profileUrl,
            "isAdmin": isAdmin
        ]
    }
}
