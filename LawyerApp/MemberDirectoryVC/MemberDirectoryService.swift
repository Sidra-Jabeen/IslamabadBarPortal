//
//  MemberDirectoryService.swift
//  LawyerApp
//
//  Created by Umair Yousaf on 13/10/2021.
//

import Foundation

class MemberDirectoryService: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping ([String: Any]) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
            completion(responseData)
        })
        
    }
}
