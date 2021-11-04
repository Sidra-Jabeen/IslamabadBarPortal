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
//        spinnerView.view.frame = view.frame
        spinnerView.view.frame.size.height = UIScreen.main.bounds.height
        spinnerView.view.frame.size.width = UIScreen.main.bounds.width
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
    }

    func stopAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
    
    func alertView(alertMessage : String, action: UIAlertAction) {
        
        let alert = UIAlertController(title: "Islamabad Bar Connect", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addAnimations(view: UIView, options : UIView.AnimationOptions, duration: TimeInterval = 0.5, delay: TimeInterval = 1) {
        
        view.alpha = 0.0
        view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            
            view.isHidden = false
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            view.alpha = 1.0
        })
    }
    
}
