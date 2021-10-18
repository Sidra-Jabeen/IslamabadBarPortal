//
//  PostQuestionsServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import Foundation

class PostQuestionsServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<PostQuesResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<PostQuesResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class PostQuestionVC -> Error \(err)")
            }
        })
        
    }
}
