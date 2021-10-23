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
        self.viewRegisterButn.layer.borderColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
        
        self.navigationController?.isNavigationBarHidden = true
        
        let postAQuesVC = PostAQuestionViewController()
        self.navigationController?.pushViewController(postAQuesVC, animated: true)
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
