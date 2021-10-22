//
//  UIButton.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func applyCircledViewToButttons() {
        
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func setBorderColorToBtns() {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8391239047, green: 0.8392685056, blue: 0.8391147852, alpha: 1)
    }
    
    func setCornerRadiusToButton() {
        
        self.layer.cornerRadius = 5
    }
}
