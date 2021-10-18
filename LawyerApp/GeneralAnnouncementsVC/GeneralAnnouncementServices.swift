//
//  GeneralAnnouncementServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 16/10/2021.
//

import Foundation

class GeneralAnnouncementServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<GeneralAnnouncementResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<GeneralAnnouncementResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class GeneralAnnouncementVC -> Error \(err)")
            }
        })
        
    }
}
