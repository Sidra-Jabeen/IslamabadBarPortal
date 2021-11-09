//
//  AppDelegate.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 08/10/2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.disabledToolbarClasses = [SignInViewController.self]
//        IQKeyboardManager.shared.disabledToolbarClasses = [SignUpViewController.self]
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide

        return true
    }

}

