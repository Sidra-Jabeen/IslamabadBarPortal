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
    
    @IBOutlet weak var txtEnterFullNameOnLisence: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
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
        
//        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
//        self.navigationController?.pushViewController(dashboardVC, animated: true)
        self.callSignInAPI()
    }
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
        
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func callSignInAPI() {
        
        startAnimation()
        let dataModel = SignInRequestModel(source: "2", user: SignInUser(licenseNumber: self.txtEnterFullNameOnLisence.text ?? "", password: self.txtPassword.text ?? ""))
        let signUpUrl = "api/Account/Login"
        let services = SignInServices()
        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
            print(responseData)
            let user = responseData.user
            let token = user?.loginToken
            Generic.setToken(token: token ?? "")
            let status = responseData.success ?? false
            if status {
                let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
                self.navigationController?.pushViewController(dashboardVC, animated: true)
            }
        }
    }

}
