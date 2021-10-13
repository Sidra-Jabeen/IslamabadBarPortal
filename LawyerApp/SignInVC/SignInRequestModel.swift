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
    var loginToken: String?
    var isAdmin: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case userId = "userId"
        case loginToken = "loginToken"
        case isAdmin = "isAdmin"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        loginToken = try values.decodeIfPresent(String.self, forKey: .loginToken)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
    }
}

