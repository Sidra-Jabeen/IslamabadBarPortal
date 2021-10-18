//
//  AnnouncementServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 16/10/2021.
//

import Foundation

class AnnouncementServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<AnnouncementResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<AnnouncementResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class AnnouncementVC -> Error \(err)")
            }
        })
        
    }
}
