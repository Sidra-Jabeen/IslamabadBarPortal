//
//  GenericModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import Foundation

struct GenericResponseModel <T : Codable> : Codable {
    
    var desc: String?
    var success: Bool?
    var users: T?
    var code: String?
    var user: SignInResponseModel?
    
    enum CodingKeys: String, CodingKey {
        
        case desc = "desc"
        case success = "success"
        case users = "users"
        case code = "code"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
//        users = try values.decodeIfPresent(T.self, forKey: .users)
        users = try values.decodeIfPresent(T.self, forKey: .users)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        user = try values.decodeIfPresent(SignInResponseModel.self, forKey: .user)
    }
}
