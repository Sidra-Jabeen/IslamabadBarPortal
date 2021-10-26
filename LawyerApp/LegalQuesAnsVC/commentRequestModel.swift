//
//  commentRequestModel.swift
//  Comments
//
//  Created by Umair Yousaf on 22/10/2021.
//



struct commentRequestModel {
    let pagination : pagination
    let source : String
    let question : question
    
    var params: [String: Any] {
        
        return [
            "source": source,
            "pagination" : pagination,
            "question" : question
        ]
    }
    
}

struct pagination {
    let limit:Int
    let offset:Int
    
    var params: [String: Any] {
        return [
            "limit": limit,
            "offset" : offset
        ]
    }
}

struct question {
    let id : Int
    var params: [String: Any] {
        return [
            
            "id": id
        ]
    }

}
