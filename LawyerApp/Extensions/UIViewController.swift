//
//  UIViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func startAnimation() {
        
        addChild(spinnerView)
        spinnerView.view.frame = view.frame
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
    }

    func stopAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            spinnerView.willMove(toParent: nil)
            spinnerView.view.removeFromSuperview()
            spinnerView.removeFromParent()
        }
    }
}
