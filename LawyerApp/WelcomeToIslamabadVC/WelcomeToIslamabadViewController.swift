//
//  WelcomeToIslamabadViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit

class WelcomeToIslamabadViewController: UIViewController {

    @IBOutlet weak var viewSignButn: UIView!
    @IBOutlet weak var viewRegisterButn: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewSignButn.setCornerRadiusToView()
        self.viewRegisterButn.setCornerRadiusToView()
        
        self.viewRegisterButn.layer.borderWidth = 1.5
        self.viewRegisterButn.layer.borderColor = #colorLiteral(red: 0.7138625979, green: 0.5477802753, blue: 0.2631929815, alpha: 1)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func tappedOnSignIn( _sender: UIButton) {
        
        let signInVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func tappedOnRegister( _sender: UIButton) {
        
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }

}
