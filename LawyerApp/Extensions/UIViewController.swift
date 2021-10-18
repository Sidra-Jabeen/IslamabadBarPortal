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
    
    func showAlert(alertTitle : String, alertMessage : String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
