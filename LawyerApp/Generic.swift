//
//  Generic.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import Foundation
import Alamofire

class Generic {
    
    static func setToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    static func getToken() -> String {
        if let token = UserDefaults.standard.string(forKey: "token") {
            return token
        }
        return ""
    }
    
    static func setAdminValue(token: String) {
        UserDefaults.standard.set(token, forKey: "admin")
    }
    
    static func getAdminValue() -> String {
        if let adminValue = UserDefaults.standard.string(forKey: "admin") {
            return adminValue
        }
        return ""
    }
    
    
}

let spinnerView = SpinnerViewController()

var currentUser: Int?
var adminValue: Bool?
var loginUserID: Int?
