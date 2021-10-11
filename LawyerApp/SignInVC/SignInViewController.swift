//
//  SignInViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var viewCircleImage: UIView!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewSignInBtn: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewFirstName.setCornerRadiusToView()
        self.viewPassword.setCornerRadiusToView()
        self.viewSignInBtn.setCornerRadiusToView()
        
        self.viewFirstName.setBorderColorToView()
        self.viewPassword.setBorderColorToView()
        
        self.btnSignIn.layer.cornerRadius = 5
        
        self.viewCircleImage.applyCircledView()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tappedOnSignIn( _sender: UIButton) {
        
        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
        
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
