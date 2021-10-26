//
//  BaseService.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation
import Alamofire
import SwiftUI

class BaseServices {
    
    func baseServicesPostMethod(urlString: String, dataModel: [String:Any], completion: @escaping (Data) -> Void) {
        
        //http://10.250.10.139/IsbBarPortal.Api/
        //http://10.250.10.221/IsbBarPortal.Api/
        //http://172.16.1.228/IsbBarPortal/
        //http://10.250.10.139/ISBBar.APP/
        
        let strURL = "http://10.250.10.221:8083/IsbBarPortal.Api/\(urlString)"
        guard let url = URL(string: strURL) else {
            print("Error: cannot create URL")
            return
        }
        let token = Generic.getToken()
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        
        AF.request(url, method: .post, parameters: dataModel, encoding: JSONEncoding.default, headers: headers).responseJSON { AFdata in
            
            switch AFdata.result {
            case .success:
                
                guard let data = AFdata.data else { return }
                completion(data)
            case .failure:
                
                let jsonSting = "{\"success\":false,\"code\":\"401\",\"desc\":\"Alamofire Request Failed\"}"
                completion(Data(jsonSting.utf8))
                break
            }
        }
    }
    
    func uploadMultipart(filesWithKeysToUpload: [String: String], textdataTobeSentWithKeys: [String: String], strUrl: String, completion: @escaping (Data) -> Void) {
        //Live http://203.215.160.148:9545/
        let urlString = "http://10.250.10.221:8083/IsbBarPortal.Api/\(strUrl)"
//        let requestBinUrl = "https://enkxdj9i9oy5f.x.pipedream.net/"
        let token = Generic.getToken()
        let headers: HTTPHeaders = [
            .authorization(bearerToken: token)
        ]
        let url = try! URLRequest(url: urlString, method: .post, headers: headers)
//        guard let url = URL(string: urlString) else {
//            print("Error: cannot create URL")
//            return
//        }
        
        AF.upload(multipartFormData: { multiPart in
            
            for (key, value) in filesWithKeysToUpload {
                
                guard let url = URL(string: value) else {
                    
                    let jsonSting = "{\"success\":false,\"code\":\"567\",\"desc\":\"String failed to convert into url\"}"
                    completion(Data(jsonSting.utf8))
                    return
                }
                multiPart.append(url, withName: key)
            }
            
            for (key, value) in textdataTobeSentWithKeys {
                
                if value == "" {
                    continue
                } else {
                    multiPart.append(value.data(using: .utf8)!, withName: key)
                }
            }
            
        }, with: url)
            .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
                
                switch data.result {
                case .success:
                    do {
                        
                        guard let data = data.data else { return }
                        completion(data)
                    }
                case .failure:
                    
                    let jsonSting = "{\"success\":false,\"code\":\"401\",\"desc\":\" Alamofire Request Failed\"}"
                    completion(Data(jsonSting.utf8))
                    break
                }
            })
    }
}

