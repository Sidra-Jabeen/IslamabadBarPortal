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
