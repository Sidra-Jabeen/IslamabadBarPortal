//
//  SignInServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation

class SignInServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<SignInResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<SignInResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class SignInViewController -> Error \(err)")
            }
        })
        
    }
}
