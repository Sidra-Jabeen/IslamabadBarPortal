//
//  BiometricsManager.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 17/10/2021.
//

import Foundation
import LocalAuthentication

extension LAContext: LAContextProtocol{}

protocol LAContextProtocol {
    func canEvaluatePolicy(_ : LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

enum BioError: Error {
    case General
    case NoEvaluate
}

class BiometricsManager {
    let context: LAContextProtocol
    
    init(context: LAContextProtocol = LAContext() ) {
        self.context = context
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
   
    func authenticateUser(completion: @escaping (Result<String, Error>) -> Void) {
        guard canEvaluatePolicy() else {
            completion( .failure(BioError.NoEvaluate) )
            return
        }
        
        let loginReason = "Log in with Biometrics"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
            if success {
                DispatchQueue.main.async {
                    // User authenticated successfully
                    completion(.success("Success"))
                }
            } else {
                switch evaluateError {
                default: completion(.failure(BioError.General))
                }

            }
        }
    }
}
