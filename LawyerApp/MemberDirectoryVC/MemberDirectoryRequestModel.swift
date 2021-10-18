//
//  MemberDirectryRequestModel.swift
//  LawyerApp
//
//  Created by Umair Yousaf on 13/10/2021.
//

struct MemberDirectoryRequestModel {

    let source: String
    let user: GetUsers

    var params: [String: Any] {
        return [
            "source": source,
            "user" : user.params
        ]
    }
}

struct GetUsers {
    
    let fullName: String
    let cnic: String
    let licenseNumber: String
    let contactNumber: String
    let email: String
    let licenseType: String
    let status: String

    var params: [String: Any] {
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
