//
//  SignInViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit
import IQKeyboardManagerSwift

class SignInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var viewCircleImage: UIView!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewSignInBtn: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnBiometric: UIButton!
    @IBOutlet weak var widthBiometric: NSLayoutConstraint!
    @IBOutlet weak var tblSignIn: UITableView!
    
    
    @IBOutlet weak var txtEnterFullNameOnLisence: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var cellArray : [(arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String)] = [
        ("Full Name On Lisence","Enter Full Name","layer1","calender",true, ""),
        ("Password","Enter Password","layer1","calender",true, ""),
        ("Issue Date of Supreme Court","dd/mm/yyyy","layer1","calender",true, "")
    ]
    var returnKeyHandler: IQKeyboardReturnKeyHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewFirstName.setCornerRadiusToView()
        self.viewPassword.setCornerRadiusToView()
        self.viewSignInBtn.setCornerRadiusToView()
        
        self.viewFirstName.setBorderColorToView()
        self.viewPassword.setBorderColorToView()
        
        self.txtPassword.delegate = self
        self.txtEnterFullNameOnLisence.delegate = self
        
        self.btnSignIn.layer.cornerRadius = 5
        
        self.viewCircleImage.applyCircledView()

        self.tblSignIn.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        self.tblSignIn.separatorStyle = .none
        self.txtEnterFullNameOnLisence.returnKeyType = UIReturnKeyType.next
        self.txtPassword.returnKeyType = UIReturnKeyType.done
        
        self.navigationController?.isNavigationBarHidden = true
        
        IQKeyboardManager.shared.enableAutoToolbar = true
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        tmpCell.selectionStyle = .none
        tmpCell.txtInfo.placeholder = cellArray[indexPath.row].arrPlaceHolderList
        tmpCell.lblInfo.text = cellArray[indexPath.row].arrSignUpList
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func authenticateUserTouchID() {
        
        BiometricsManager().authenticateUser(completion: { [weak self] (response) in
            switch response {
            case .failure:
               print("Failed")
//                UserDefaults.standard.set(nil, forKey: "isBiometricLogin")
//                UserDefaults.standard.removeObject(forKey: "isBiometricLogin")
//                UserDefaults.standard.set("0", forKey: "isBiometricLogin")

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
        else { self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Textfields Should Not Be Empty") }
        
    }
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
        
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            // move to the next text field
        case self.txtEnterFullNameOnLisence:
            self.txtPassword.becomeFirstResponder()
            // press the final button
        case self.txtPassword:
            self.view.hideKeyboard()
        default: break
        }
        return true
    }
    
    func callSignInAPI(lisenceNumber: String, password: String) {
        
        if  Connectivity.isConnectedToInternet {
                
                startAnimation()
                let dataModel = SignInRequestModel(source: "2", user: SignInUser(licenseNumber: lisenceNumber, password: password))
            let loginUrl = Constant.loginEP
                let services = SignInServices()
                services.postMethod(urlString: loginUrl, dataModel: dataModel.params) { (responseData) in
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
                        strLisenceNo = self.txtEnterFullNameOnLisence.text ?? ""
                        strPassword = self.txtPassword.text ?? ""
                        loginUserID = user?.userId
                        roleId = user?.roleId
                        strUserName = user?.fullName ?? ""
                        urlProfile = URL(string: "\(Constant.imageDownloadURL)\(responseData.user?.profileUrl ?? "")")
                        UserDefaults.standard.set(responseData.user?.licenseNumber, forKey: "lisenceNumber")
                        
                        if (UserDefaults.standard.string(forKey: "password") == nil) {
                            
                            UserDefaults.standard.set(self.txtPassword.text, forKey: "password")
                        } else if (UserDefaults.standard.string(forKey: "password") != nil) && self.txtPassword.text != "" {
                            
                            UserDefaults.standard.set(self.txtPassword.text, forKey: "password")
                        }
                       
                        self.navigationController?.pushViewController(dashboardVC, animated: true)
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "User Not Found")
                        self.txtEnterFullNameOnLisence.text = ""
                        self.txtPassword.text = ""
                    }
                    if user?.isAdmin ?? false {
                        Generic.setAdminValue(token: "0")
                    }
                }
            } else {
            
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }

}
