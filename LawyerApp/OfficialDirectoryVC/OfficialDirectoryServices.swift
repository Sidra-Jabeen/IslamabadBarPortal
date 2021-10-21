//
//  OfficialDirectoryServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 21/10/2021.
//

import Foundation

class OfficialDirectoryServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<OfficialDirectoryResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<OfficialDirectoryResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class OfficialVC -> Error \(err)")
            }
        })
        
    }
}
