//
//  ApprovalRequestModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import Foundation

struct ApprovalRequestModel {
    
    let source: String
    let user: ApprovalUser

    var params: [String: Any] {
        return [
            "source": source,
            "user" : user.params
        ]
    }
}

struct ApprovalUser {
    
    let fullName: String
    let cnic: String
    let licenseNumber: String
    let contactNumber: String
    let email: String
    let licenseType: String
    let status: String
    
    var params: [String:Any] {
        return [
            "fullName": fullName,
            "cnic": cnic,
            "licenseNumber": licenseNumber,
            "contactNumber": contactNumber,
            "email": email,
            "licenseType": licenseType,
            "status": status
        ]
    }
}


//Request Model
//{
//  "source": "Postman",
//  "user": {
//       "fullName": "",
//        "cnic": "",
//        "licenseNumber": "",
//        "contactNumber": "",
//        "email": "",
//        "licenseType": "",
//        "status": "0"
//  }
//}
