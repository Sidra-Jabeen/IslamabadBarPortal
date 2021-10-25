//
//  ProfileViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
    @IBOutlet weak var btnProfile: UIButton!
    
    //MARK: - Propertities
    
    var userID: SignInResponseModel?
    var intForUpdateUser = 0
    let photoPicker = UIImagePickerController()
    var strProfileImage = ""
    
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
        self.photoPicker.delegate = self
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
        self.txtFullNameOnLisence.textColor = UIColor.black
        self.txtCnic.isUserInteractionEnabled = true
        self.txtCnic.textColor = UIColor.black
        self.txtDob.isUserInteractionEnabled = true
        self.txtDob.textColor = UIColor.black
        self.txtEmail.isUserInteractionEnabled = true
        self.txtEmail.textColor = UIColor.black
        self.txtLisence.isUserInteractionEnabled = true
        self.txtLisence.textColor = UIColor.black
        self.txtContactNo.isUserInteractionEnabled = true
        self.txtContactNo.textColor = UIColor.black
        self.txtOfficeAddress.isUserInteractionEnabled = true
        self.txtOfficeAddress.textColor = UIColor.black
        self.btnProfile.isUserInteractionEnabled = true
        
        if self.intForUpdateUser == 1 {
//            self.callUpdateUserApi()
            self.callUpdateUserApi()
        }
        
    }
    
    @IBAction func tappedOnEditProfile( _sender: UIButton) {
        
        self.selectPhoto()
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let url = info[.imageURL] as? NSURL
//        let filename = url?.lastPathComponent
        let strUrl = url?.absoluteString
        self.strProfileImage = strUrl ?? ""
        if let originalImage = info[.originalImage] as? UIImage {
            self.profileImage.image = originalImage//originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func selectPhoto() {
        
        photoPicker.allowsEditing = true
        let alertcontroller: UIAlertController = UIAlertController(title: "Upload Picture", message: "", preferredStyle: .alert)
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture From Gallery", style: .default) { action -> Void in
            self.photoPicker.sourceType = .photoLibrary
            self.present(self.photoPicker, animated: true, completion: nil)
        }
        alertcontroller.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture From Camera", style: .default) { action -> Void in
            self.photoPicker.sourceType = .camera
            self.present(self.photoPicker, animated: true, completion: nil)
        }
        alertcontroller.addAction(choosePictureAction)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            // self.userprofileimage.image = UIImage(named: "Group-29 ")!;
            //ProfileViewController.Userprofileimage =  UIImage(named: "Group-29")!;
            alertcontroller.dismiss(animated: false, completion: nil)
        }
        alertcontroller.addAction(cancelAction)
        self.present(alertcontroller, animated: true, completion: nil)
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
                        let url = URL(string: "http://203.215.160.148:9545/documents/\(user?.profileUrl ?? "")")
                        self.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
                        self.lblMemberName.text = user?.fullName
                        self.txtFullNameOnLisence.text = user?.fullName
                        self.txtCnic.text = user?.cnic
                        self.txtDob.text = user?.dob
                        self.txtContactNo.text = user?.contactNumber
                        self.lblCourtName.text = user?.licenseType
                        self.txtLisence.text = user?.licenseNumber
                        self.txtOfficeAddress.text = user?.officeAddress
                        self.txtEmail.text = user?.email
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
            let file = ProfileAttachmentFileRequestModel(profilePicture: self.strProfileImage)
            let dataModel = UpdateUser(Source: "2", userId: "\(loginUserID ?? 0)", fullName: self.txtFullNameOnLisence.text ?? "", dob: self.txtDob.text ?? "", contactNumber: self.txtContactNo.text ?? "", email: self.txtEmail.text ?? "", officeAddress: self.txtOfficeAddress.text ?? "")
            let updateProfileUrl = "api/User/UpdateUser"
            let services = ProfileServices()
            services.postUploadMethod(files: file.params, urlString: updateProfileUrl, dataModel: dataModel.params, completion: { (responseData) in
                self.stopAnimation()
                let status = responseData.success
                
                if status ?? false {
                    print("success")
                    self.txtFullNameOnLisence.isUserInteractionEnabled = false
                    self.txtFullNameOnLisence.textColor = UIColor.placeholderText
                    self.txtCnic.isUserInteractionEnabled = false
                    self.txtCnic.textColor = UIColor.placeholderText
                    self.txtDob.isUserInteractionEnabled = false
                    self.txtDob.textColor = UIColor.placeholderText
                    self.txtEmail.isUserInteractionEnabled = false
                    self.txtEmail.textColor = UIColor.placeholderText
                    self.txtLisence.isUserInteractionEnabled = false
                    self.txtLisence.textColor = UIColor.placeholderText
                    self.txtContactNo.isUserInteractionEnabled = false
                    self.txtContactNo.textColor = UIColor.placeholderText
                    self.txtOfficeAddress.isUserInteractionEnabled = false
                    self.txtOfficeAddress.textColor = UIColor.placeholderText
                    self.btnEdit.setTitle("Edit", for: .normal)
                } else{
                    print("failed")
                }
            })
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
}
