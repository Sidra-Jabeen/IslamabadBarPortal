//
//  ApprovalRequestModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import Foundation

//{
//  "source": "Postman",
//  "Pagination" : {
//        "orderBy": "asc",
//        "limit": 10,
//        "offset" : 0
//  },
//  "user": {
//       "fullName": null,
//        "licenseType": null,
//        "status": "0"
//  }
//}

struct ApprovalRequestModel {
    
    let source: String
    let Pagination: PaginationModel
    let user: ApprovalUser?

    var params: [String: Any] {
        return [
            "source": source,
            "Pagination": Pagination.params,
            "user" : user?.params as Any,        ]
    }
}

struct ApprovalUser {
    
    let fullName: String?
    let cnic: String?
    let licenseNumber: String?
    let contactNumber: String?
    let licenseType: String?
    let status: String?
    
    var params: [String:Any] {
        return [
            "fullName": fullName as Any,
            "cnic": cnic as Any,
            "licenseNumber": licenseNumber as Any,
            "contactNumber": contactNumber as Any,
            "licenseType": licenseType as Any,
            "status": status as Any,
        ]
    }
}

struct PaginationModel {
    
    let orderBy: String?
    let limit: Int?
    let offset: Int?
    
    var params: [String:Any] {
        return [
            "orderBy": orderBy as Any,
            "limit": limit as Any,
            "offset": offset as Any
        ]
    }
}

struct AcceptRequestModel {
    
    let source: String
    let user: AcceptUser
    

    var params: [String: Any] {
        return [
            "source": source,
            "user" : user.params
        ]
    }
}

struct AcceptUser {
    
    let status: String
    let userId: Int
    let reason: String

    var params: [String: Any] {
        return [
            
            "status" : status,
            "userId" : userId,
            "reason" : reason
        ]
    }
}


struct AdminRequestModel {
    
    let source: String
    
    let user: RemoveAdminUser
    

    var params: [String: Any] {
        return [
            "source": source,
            "user" : user.params
        ]
    }
}

struct RemoveAdminUser {
    
    let userId: Int?
    let isAdmin: Bool?
    let roleId: Int?

    var params: [String: Any] {
        return [
            "userId" : userId as Any,
            "isAdmin" : isAdmin as Any,
            "roleId": roleId as Any
        ]
    }
}
