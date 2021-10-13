//
//  BaseService.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation
import Alamofire

class BaseServices {

    func baseServicesPostMethod(urlString: String, dataModel: [String:Any], completion: @escaping ([String: Any]) -> Void) {

//    http://10.250.10.221/IsbBarPortal.Api/api/Account/Registration
//    http://10.250.10.139/ISBBar.APP/
        let strURL = "http://10.250.10.139/ISBBar.APP/\(urlString)"
        guard let url = URL(string: strURL) else {
            print("Error: cannot create URL")
            return
        }

//        // Convert model to JSON data

//        guard let jsonData = try? JSONSerialization.data(withJSONObject: dataModel) else {
//            print("Error: Trying to convert model to JSON data")
//            return
//        }
        let token = Generic.getToken()
//        let headers = ["Authorization" : "Bearer" + token]
        let headers: HTTPHeaders = [
                .authorization(bearerToken: token)
            ]
        
        AF.request(url, method: .post, parameters: dataModel, encoding: JSONEncoding.default, headers: headers).responseJSON { AFdata in
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                completion(jsonObject)
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
}

