//
//  LocalAuth.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import Foundation
import LocalAuthentication

open class LocalAuth: NSObject {

    public static let shared = LocalAuth()
    private override init() {}
    var laContext = LAContext()

    func canAuthenticate() -> Bool {
        var error: NSError?
        let hasTouchId = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return hasTouchId
    }

    func hasTouchId() -> Bool {
        if canAuthenticate() && laContext.biometryType == .touchID {
            return true
        }
        return false
    }

    func hasFaceId() -> Bool {
        if canAuthenticate() && laContext.biometryType == .faceID {
            return true
        }
        return false
    }
    
    func setupKeychainSecurity(name: String, passward: String) {
        
        var error: Unmanaged<CFError>?
        
        if #available(iOS 11.3, *) {
            
            guard let accessControl = SecAccessControlCreateWithFlags(
                kCFAllocatorDefault,
                kSecAttrAccessibleWhenUnlocked,
                .biometryCurrentSet, &error)
            else { return }

            var query: [String: Any] = [:]
            query[kSecClass as String] = kSecClassGenericPassword
            query[kSecAttrLabel as String] = "Aksa-SDS.LawyerApp" as CFString
            query[kSecAttrAccount as String] = name as CFString
            query[kSecValueData as String] = passward.data(using: .utf8)! as CFData
            query[kSecAttrAccessControl as String] = accessControl
            
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            status == noErr ? print(status) : print(noErr)
        }
    }
    
    func getKeychainAccesscontrol(name: String) -> String {
        
        var query = [String: Any]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecAttrAccount as String] = name as CFString
        query[kSecAttrLabel as String] = "Aksa-SDS.LawyerApp" as CFString
        query[kSecUseOperationPrompt as String] = "Login using your biometric credential" as CFString

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        if status == noErr {
            
            let password = String(data: queryResult as! Data, encoding: .utf8)!
            return password
        }
        return ""
    }
}
