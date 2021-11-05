//
//  AbusiveWordModels.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 01/11/2021.
//

import Foundation

struct AbusiveRequestModel {

    let source: String
    let abuseWord: String

    var params: [String: Any] {
        return [
            "source": source,
            "abuseWord" : abuseWord
        ]
    }
}
