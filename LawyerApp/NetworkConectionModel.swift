//
//  NetworkConectionModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 17/10/2021.
//

import Foundation
import Alamofire

struct Connectivity {
    
    static let sharedInstance = NetworkReachabilityManager()
    
    static var isConnectedToInternet: Bool {
        return self.sharedInstance?.isReachable ?? false
    }
}
