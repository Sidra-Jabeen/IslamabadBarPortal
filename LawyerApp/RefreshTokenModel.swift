//
//  RefreshTokenModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/11/2021.
//

import Foundation

struct RefreshToken {
    
    let source: String?
    let user: Token?

    var params: [String: Any] {
        return [
            "source": source as Any,
            "user" : user?.params as Any
        ]
    }
}

struct Token {
    
    let loginToken: String?
    let refreshToken: String?

    var params: [String: Any] {
        return [
            "loginToken": loginToken as Any,
            "refreshToken" : refreshToken as Any
        ]
    }
}
