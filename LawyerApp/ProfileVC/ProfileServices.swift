//
//  ProfileServices.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 20/10/2021.
//

import Foundation

class ProfileServices: BaseServices {
    
    
    func postMethod(urlString: String, dataModel: [String:Any], completion: @escaping (GenericResponseModel<ProfileResponseModel>) -> Void) {
        
        baseServicesPostMethod(urlString: urlString, dataModel: dataModel, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<ProfileResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class SignInViewController -> Error \(err)")
            }
        })
        
    }
    
    func postUploadMethod(files: [String: String] ,urlString: String, dataModel: [String: String], completion: @escaping (GenericResponseModel<ProfileResponseModel>) -> Void) {
        
        uploadMultipart(filesWithKeysToUpload: files, textdataTobeSentWithKeys: dataModel, strUrl: urlString, completion: {(responseData) in
//            completion(responseData)
            do {
                let responseModel = try JSONDecoder().decode(GenericResponseModel<ProfileResponseModel>.self, from: responseData)
                completion(responseModel)
            } catch let err {
                print("class GeneralAnnouncementVC -> Error \(err)")
            }
        })
        
    }
}
