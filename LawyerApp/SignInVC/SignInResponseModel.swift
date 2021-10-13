//
//  SignInResponseModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation

struct SignInResponseModel {
    
    let code: String
    let desc: String
    let success: String
    let user: responseUser
    
    var params: [String:Any] {
        return [
            "code": code,
            "desc": desc,
            "success": success,
            "user": user.params
        ]
    }
    
}

struct responseUser {
    
    let userId: Int
    let loginToken: String
    let isAdmin: Bool
    
    var params: [String:Any] {
        return [
            "userId": userId,
            "loginToken": loginToken,
            "isAdmin": isAdmin
        ]
    }
}
