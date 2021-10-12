//
//  SignUpRequestModel.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import Foundation



struct Request {
    
    let source: String
    let licenseFile: String
    let profileFile: String
    let user: User
    
    var params: [String: Any] {
        return [
            "source": source,
            "licenseFile": licenseFile,
            "profileFile" : profileFile,
            "user" : user.params
        ]
    }
}

struct User {
    
    let FULL_NAME: String
    let CNIC: String
    let LICENSE_NUMBER: String
    let CONTACT_NUMBER: String
    let EMAIL: String
    let OFFICE_ADDRESS: String
    let PASSWORD: String
    let LICENSE_TYPE: String
    let ISSUANCE_DATE_LOWER_COURT: String
    let ISSUANCE_DATE_HIGH_COURT: String
    let ISSUANCE_DATE_SUPREME_COURT: String
    
    var params: [String: Any] {
        return [
            "FULL_NAME": FULL_NAME,
            "CNIC": CNIC,
            "LICENSE_NUMBER" : LICENSE_NUMBER,
            "CONTACT_NUMBER" : CONTACT_NUMBER,
            "EMAIL": EMAIL,
            "OFFICE_ADDRESS": OFFICE_ADDRESS,
            "PASSWORD" : PASSWORD,
            "LICENSE_TYPE" : LICENSE_TYPE,
            "ISSUANCE_DATE_LOWER_COURT": ISSUANCE_DATE_LOWER_COURT,
            "ISSUANCE_DATE_HIGH_COURT": ISSUANCE_DATE_HIGH_COURT,
            "ISSUANCE_DATE_SUPREME_COURT" : ISSUANCE_DATE_SUPREME_COURT
        ]
    }
}

//struct User: Codable {
//
//    let useR_ID: Int
//    let fulL_NAME: String
//    let cnic: String
//    let dob: String
//    let licensE_NUMBER: String
//    let contacT_NUMBER: String
//    let email: String
//    let license: String
//    let licensE_TYPE: String
//    let issuancE_DATE_LOWER_COURT: String
//    let issuancE_DATE_HIGH_COURT: String
//    let issuancE_DATE_SUPREME_COURT: String
//    let officE_ADDRESS: String
//    let password: String
//    let logiN_TOKEN: String
//    let status: String
//    let profilE_PICTURE: String
//    let createD_BY: Int
//
//    var params: [String:Any] {
//        return [
//            "useR_ID": useR_ID,
//            "fulL_NAME" : fulL_NAME,
//            "cnic" : cnic,
//            "dob" : dob,
//            "licensE_NUMBER": licensE_NUMBER,
//            "contacT_NUMBER" : contacT_NUMBER,
//            "email" : email,
//            "license" : license,
//            "licensE_TYPE": licensE_TYPE,
//            "issuancE_DATE_LOWER_COURT" : issuancE_DATE_LOWER_COURT,
//            "issuancE_DATE_HIGH_COURT" : issuancE_DATE_HIGH_COURT,
//            "issuancE_DATE_SUPREME_COURT" : issuancE_DATE_SUPREME_COURT,
//            "officE_ADDRESS": officE_ADDRESS,
//            "password" : password,
//            "logiN_TOKEN" : logiN_TOKEN,
//            "status" : status,
//            "profilE_PICTURE" : profilE_PICTURE,
//            "createD_BY" : createD_BY
//        ]
//    }
    
    struct WeatherForecast {
        let date: String
        let temperatureC: Int
        let temperatureF: Int
        let summary: String
        
        var params: [String: Any] {
            return [
                "date": date,
                "temperatureC" : temperatureC,
                "temperatureF": temperatureF,
                "summary" : summary
            ]
        }
    }
    

