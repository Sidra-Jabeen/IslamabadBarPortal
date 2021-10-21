//
//  ProfileViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var lblFullNameOnLisence: UILabel!
    @IBOutlet weak var lblCnic: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblContactNo: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLisence: UILabel!
    @IBOutlet weak var lblOfficeAddress: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    //MARK: - Propertities
    
    var userID: SignInResponseModel?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.profileImage.applyCircledView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetProfileFunction()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

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
                        self.lblFullNameOnLisence.text = user?.fullName
                        self.lblCnic.text = user?.cnic
                        self.lblDob.text = user?.dob
                        self.lblContactNo.text = user?.contactNumber
//                        self.lblEmail.text = user.
                        self.lblLisence.text = user?.licenseNumber
                        self.lblOfficeAddress.text = user?.officeAddress
                        
                        print("success")
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "User Not Found")
                    }
                }
            } else {
            
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
}
