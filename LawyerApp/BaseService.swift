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
        
        let strURL = "http://10.250.10.221/IsbBarPortal.Api/\(urlString)"
        guard let url = URL(string: strURL) else {
            print("Error: cannot create URL")
            return
        }
        let token = Generic.getToken()
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
                    
                    let jsonSting = "{\"success\":false,\"code\":\"401\",\"desc\":\"Your session has been expired\",\"data\":null}"
                    completion(Data(jsonSting.utf8))
                    break
                    
                }
                
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

