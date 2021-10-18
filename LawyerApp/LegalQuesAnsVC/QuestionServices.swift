//
//  QuestionServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import Foundation

class QuestionServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<QuesResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<QuesResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class QuestionVC -> Error \(err)")
            }
        })
        
    }
}
