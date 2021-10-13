//
//  Generic.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import Foundation

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
}

let spinnerView = SpinnerViewController()
