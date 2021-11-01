//
//  QuestionareServices.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/26/21.
//

import Foundation

class QuestionareServices: BaseServices {
    
    
    func getQuestionareDetails(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<QuestionDetailResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in

            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<QuestionDetailResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class QuestionVC -> Error \(err)")
            }
        })
    }
}
