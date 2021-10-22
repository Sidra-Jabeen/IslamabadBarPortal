//
//  ProfileViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var txtFullNameOnLisence: UITextField!
    @IBOutlet weak var txtCnic: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLisence: UITextField!
    @IBOutlet weak var txtOfficeAddress: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Propertities
    
    var userID: SignInResponseModel?
    var intForUpdateUser = 0
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.profileImage.applyCircledView()
        self.txtFullNameOnLisence.delegate = self
        self.txtCnic.delegate = self
        self.txtDob.delegate = self
        self.txtEmail.delegate = self
        self.txtLisence.delegate = self
        self.txtContactNo.delegate = self
        self.txtOfficeAddress.delegate = self
        self.scrollView.contentSize = (CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 100))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetProfileFunction()
    }
    
    //MARK: - HandGestureFunction
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnEdit( _sender: UIButton) {
        
        self.txtFullNameOnLisence.isUserInteractionEnabled = true
        self.txtCnic.isUserInteractionEnabled = true
        self.txtDob.isUserInteractionEnabled = true
        self.txtEmail.isUserInteractionEnabled = true
        self.txtLisence.isUserInteractionEnabled = true
        self.txtContactNo.isUserInteractionEnabled = true
        self.txtOfficeAddress.isUserInteractionEnabled = true
        if self.intForUpdateUser == 1 {
            self.callUpdateUserApi()
        }
        
    }
    
    //MARK: - UITextFieldDelegateFunction
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.btnEdit.setTitle("Save", for: .normal)
        self.intForUpdateUser = 1
    }

    //MARK: - CallingApiFunction
    
    func callGetProfileFunction() {
        
        if  Connectivity.isConnectedToInternet {
                
                startAnimation()
            let dataModel = ProfileRequestModel(source: "2", user: ProfileUser(userId: loginUserID ?? 0))
                let signUpUrl = "api/User/GetUserDetail"
                let services = ProfileServices()
                services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                    print(responseData)
                    self.stopAnimation()
                    let user = responseData.user
                    let status = responseData.success ?? false
                    if status {
                        let url = URL(string: user?.profileUrl ?? "")
                        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
                        self.lblMemberName.text = user?.fullName
                        self.txtFullNameOnLisence.text = user?.fullName
                        self.txtCnic.text = user?.cnic
                        self.txtDob.text = user?.dob
                        self.txtContactNo.text = user?.contactNumber
                        self.lblCourtName.text = user?.licenseType
                        self.txtLisence.text = user?.licenseNumber
                        self.txtOfficeAddress.text = user?.officeAddress
                        
                        print("success")
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "User Not Found")
                    }
                }
            } else {
            
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    func callUpdateUserApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = UpdateUser(Source: "2", userId: loginUserID, fullName: self.txtFullNameOnLisence.text, dob: self.txtDob.text, contactNumber: self.txtContactNo.text, email: self.txtEmail.text, profilePicture: nil, officeAddress: self.txtOfficeAddress.text)
            let updateProfileUrl = "api/User/UpdateUser"
            let services = ProfileServices()
            services.postMethod(urlString: updateProfileUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let response = responseData.success ?? false
                if response {
                    print("Success")
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    //                    self.arrayOfMembers.removeAll()
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
}
