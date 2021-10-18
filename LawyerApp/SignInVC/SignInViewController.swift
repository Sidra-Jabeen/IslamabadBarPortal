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
    @IBOutlet weak var btnBiometric: UIButton!
    @IBOutlet weak var widthBiometric: NSLayoutConstraint!
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.txtEnterFullNameOnLisence.text = ""
        self.txtPassword.text = ""
        if UserDefaults.standard.string(forKey: "isBiometricLogin") == "1" {
            
            self.widthBiometric.constant = 60
        } else {
            
            self.widthBiometric.constant = 0
        }
    }
    
    @IBAction func tappedOnBiometric( _sender: UIButton){
        
        self.authenticateUserTouchID()
    }
    
    func authenticateUserTouchID() {
        
        BiometricsManager().authenticateUser(completion: { [weak self] (response) in
            switch response {
            case .failure:
               print("Failed")
            case .success:
                print("Success")
                if let lisenceNo = UserDefaults.standard.string(forKey: "lisenceNumber"), let password = UserDefaults.standard.string(forKey: "password") {
                    self?.callSignInAPI(lisenceNumber: lisenceNo, password: password)
                    
            }
        }
        })
    }
    
    @IBAction func tappedOnSignIn( _sender: UIButton) {
        
//        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
//        self.navigationController?.pushViewController(dashboardVC, animated: true)
        if (self.txtEnterFullNameOnLisence.text != "") && (self.txtPassword.text != "") {
            
            self.callSignInAPI(lisenceNumber: self.txtEnterFullNameOnLisence.text ?? "", password: self.txtPassword.text ?? "")
        }
        else { self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "Textfields Should Not Be Empty") }
        
    }
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
        
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func callSignInAPI(lisenceNumber: String, password: String) {
        
        if  Connectivity.isConnectedToInternet {
                
                startAnimation()
                let dataModel = SignInRequestModel(source: "2", user: SignInUser(licenseNumber: lisenceNumber, password: password))
                let signUpUrl = "api/Account/Login"
                let services = SignInServices()
                services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                    print(responseData)
                    self.stopAnimation()
                    let user = responseData.user
                    let token = user?.loginToken
                    Generic.setToken(token: token ?? "")
                    let status = responseData.success ?? false
                    if status {
                        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
//                        dashboardVC.userId = responseData.user?.userId
                        dashboardVC.strLisenceNo = self.txtEnterFullNameOnLisence.text ?? ""
                        dashboardVC.password = self.txtPassword.text ?? ""
                        self.navigationController?.pushViewController(dashboardVC, animated: true)
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "User Not Found")
                        self.txtEnterFullNameOnLisence.text = ""
                        self.txtPassword.text = ""
                    }
                    if user?.isAdmin ?? false {
                        Generic.setAdminValue(token: "0")
                    }
                }
            } else {
            
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }
        
    }

}
