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
        
        let data = Request(source: "2", licenseFile: "", profileFile: "", user: User(FULL_NAME: "Sidra jabeen", CNIC: "3740599261522", LICENSE_NUMBER: "1234567", CONTACT_NUMBER: "1234567", EMAIL: "sidra.jabeen@gmail.com", OFFICE_ADDRESS: "abjawd akhgdhw", PASSWORD: "12345678", LICENSE_TYPE: "Lower Court", ISSUANCE_DATE_LOWER_COURT: "14/02/1998", ISSUANCE_DATE_HIGH_COURT: "14/02/1998", ISSUANCE_DATE_SUPREME_COURT: "14/02/1998"))
        let signUpUrl = "Account/Registeration"
        let services = SignInServices()
        services.postMethod(urlString: signUpUrl, dataModel: data.params) { (responseData) in
            print(responseData)
        }
    }

}
