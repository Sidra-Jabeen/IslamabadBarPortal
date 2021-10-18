//
//  BaseService.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation
import Alamofire

class BaseServices {

    func baseServicesPostMethod(urlString: String, dataModel: [String:Any], completion: @escaping (Data) -> Void) {

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
                switch AFdata.result {
                case .success:
                    do {
                        guard let data = AFdata.data else { return }
                        completion(data)
                        
                        
                    } catch {
                        print("Error accured on base request")
                    }
                case .failure:
                    
                    
                    break
                    
                }
//                guard let data = AFdata.data else { return }
//                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? Data
//                else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
                
//                let decoder = JSONDecoder()
//                let data = try decoder.decode(GenericResponseModel<Data>.self, from: AFdata.data!)
//                print(data)
//                completion(data)
//                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//                    print("Error: Cannot convert JSON object to Pretty JSON data")
//                    return
//                }
//                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//                    print("Error: Couldn't print JSON in String")
//                    return
//                }
//                completion(jsonObject)
//                print(jsonObject)
//                if let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
//
//                    completion(jsonDictionary)
//                    print(jsonDictionary)
//                } else {
//                    print("This JSON is not a dictionary")
//                }
                
                
//                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any]
//                else {
//                    print("Error: Cannot convert data to JSON object")
//                    return
//                }
//                completion(jsonObject)
                
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
    
    func upload(image: Data, to url: Alamofire.URLRequestConvertible, params: [String: Any]) {
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            multiPart.append(image, withName: "file", fileName: "file.png", mimeType: "image/png")
        }, with: url)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
                //Do what ever you want to do with response
            })
    }
}

