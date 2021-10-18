//
//  MemberDirectoryModels.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import Foundation
//{"Pagination":{"limit":10,"offset":0,"orderBy":"asc"},"Source":"1","User":{"fullName":"ffdcg","licenseType":"3","status":"2"}}

struct MemberRequestModel {
    
    
    let Pagination: PaginationModel
    let source: String
    let user: MemberUser

    var params: [String: Any] {
        return [
            "Pagination": Pagination.params,
            "source": source,
            "user" : user.params
        ]
    }
}

struct MemberUser {
    
    let fullName: String
    let licenseType: String
    let status: String
    
    var params: [String:Any] {
        return [
            "fullName": fullName,
            "licenseType": licenseType,
            "status": status
        ]
    }
}
