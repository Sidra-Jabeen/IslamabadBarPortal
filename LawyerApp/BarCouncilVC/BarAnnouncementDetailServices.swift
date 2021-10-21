//
//  BarAnnouncementDetailServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 20/10/2021.
//

import Foundation

class BarAnnouncementDetailServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<BarAnnouncementResponseDetailModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<BarAnnouncementResponseDetailModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class GeneralAnnouncementVC -> Error \(err)")
            }
        })
        
    }
}
