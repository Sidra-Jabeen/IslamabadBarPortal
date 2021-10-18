//
//  SignUpServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation

class SignUpServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<SignUpResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<SignUpResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class SignUpViewController -> Error \(err)")
            }
        })
        
    }
}

