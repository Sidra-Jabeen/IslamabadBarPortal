//
//  UIView.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import Foundation
import UIKit

extension UIView {
    
    func setCornerRadiusToView() {
        
        self.layer.cornerRadius = 5
    }
    
    func applyCircledView() {
        
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func setBorderColorToView() {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
    }
}
