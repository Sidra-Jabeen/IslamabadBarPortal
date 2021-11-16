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
        
        let strURL = "\(Constant.baseURL)\(urlString)"
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
                if AFdata.response?.statusCode == 200 {
                    completion(data)
                }

            case .failure:
                
                if AFdata.response?.statusCode == 401 {
                    self.refreshToken(urlString: urlString, model: dataModel, completionHandler: { (data) in
                        completion(data)
                    })
                } else {
                    let jsonSting = "{\"success\":false,\"code\":\"9877\",\"desc\":\"Alamofire Request Failed\"}"
                    completion(Data(jsonSting.utf8))
                }
                
                break
            }
        }
    }
    
    func uploadMultipart(filesWithKeysToUpload: [String: String], textdataTobeSentWithKeys: [String: String], strUrl: String, completion: @escaping (Data) -> Void) {
        //Live http://203.215.160.148:9545/
    
        let urlString = "\(Constant.baseURL)\(strUrl)"
//        let urlString = "\(Constant.baseURL)\(strUrl)"
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
                
                if let url = URL(string: value) {
                    
                    multiPart.append(url, withName: key)
                    
                }
//                else {
//                    
//                    let jsonSting = "{\"success\":false,\"code\":\"567\",\"desc\":\"String failed to convert into url\"}"
//                    completion(Data(jsonSting.utf8))
//                    return
//                }
//                multiPart.append(url, withName: key)
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
                    
<<<<<<< HEAD
                    let jsonSting = "{\"success\":false,\"code\":\"9809\",\"desc\":\"Alamofire Request Error\"}"
=======
                    let jsonSting = "{\"success\":false,\"code\":\"9877\",\"desc\":\" Alamofire Request Failed\"}"
>>>>>>> fba5fa3a976f5c90378c6e1dc33e10b468c5553f
                    completion(Data(jsonSting.utf8))
                    break
                }
            })
    }
    
    
    func refreshToken(urlString: String, model: [String:Any] ,completionHandler: @escaping ((_ _data:Data ) -> Void)) {
        
        
        let strURL = "\(Constant.baseURL)\(Constant.refreshTokenEP)"
        guard let url = URL(string: strURL) else {
            print("Error: cannot create URL")
            return
        }
//        let token = Generic.getToken()
//        let headers: HTTPHeaders = [
//            .authorization(bearerToken: token)
//        ]
        let logToken = Generic.getToken()
        let refToken = Generic.getRefreshToken()
        let dataModel = RefreshToken(source: "2", user: Token(loginToken: logToken, refreshToken: refToken))
        
        AF.request(url, method: .post, parameters: dataModel.params, encoding: JSONEncoding.default, headers: nil).responseJSON { AFdata in
            
            switch AFdata.result {
            case .success:
                
                guard let data = AFdata.data else { return }
                if AFdata.response?.statusCode == 200 {
                    
                    do {
                        let responseModel = try JSONDecoder().decode(GenericResponseModel<SignInResponseModel>.self, from: data)
                        if responseModel.code == "00"{
                            
                            self.baseServicesPostMethod(urlString: urlString, dataModel: model) { data in
                                completionHandler(data)
                            }
                        } else {
                            completionHandler(data)
                        }
                        
                    }catch let err {
                        print("class BaseService Class -> Error \(err)")
                    }
                }
//                completion(data)
            case .failure:
                guard let data = AFdata.data else { return }
                if AFdata.response?.statusCode == 401 {
                    
                    completionHandler(data)
                } else {
                    let jsonSting = "{\"success\":false,\"code\":\"9877\",\"desc\":\"Refresh Token Request Failed\"}"
                    completionHandler(Data(jsonSting.utf8))
                }
                
                break
            }
        }
    }
}

