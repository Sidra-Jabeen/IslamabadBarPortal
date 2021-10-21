//
//  GetAnnouncementDetailServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 19/10/2021.
//

import Foundation

class GeneralAnnouncementDetailServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<GeneralAnnouncementResponseDetailModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<GeneralAnnouncementResponseDetailModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class GeneralAnnouncementVC -> Error \(err)")
            }
        })
        
    }
}
