//
//  ProfileViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Kingfisher

class ProfileViewController: QLViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, CalenderControllerDetegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var txtFullNameOnLisence: UITextField!
    @IBOutlet weak var txtCnic: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtContactNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLisenceNo: UITextField!
    @IBOutlet weak var txtOfficeAddress: UITextField!
    @IBOutlet weak var txtIssueDate: UITextField!
    @IBOutlet weak var txtIssueHighDate: UITextField!
    @IBOutlet weak var txtIssueSupremeDate: UITextField!
    @IBOutlet weak var txtLisenceType: UITextField!
    @IBOutlet weak var txtLisence: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var lisenceImage: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnEditProfileImage: UIImageView!
    @IBOutlet weak var btnsView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var lowerCHeight: NSLayoutConstraint!
    @IBOutlet weak var highCHeight: NSLayoutConstraint!
    @IBOutlet weak var supremeCHeight: NSLayoutConstraint!
    @IBOutlet weak var lblLowerCHeight: NSLayoutConstraint!
    @IBOutlet weak var lblHighCHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSupremeCHeight: NSLayoutConstraint!
    @IBOutlet weak var topLowerCHeight: NSLayoutConstraint!
    @IBOutlet weak var topHighCHeight: NSLayoutConstraint!
    @IBOutlet weak var topSupremeCHeight: NSLayoutConstraint!
    
    //MARK: - Propertities
    
    var userID: SignInResponseModel?
    var profileUser: ProfileResponseModel?
    var intForUpdateUser = 0
    let photoPicker = UIImagePickerController()
    var strProfileImage: String? = nil
    var intUserValue = 0
    var calenderView: CalenderViewController?
    var bitForViewBtns = false
    var bitForViewProfile = false
    var profileUrl: String?
    var lisenceUrl: String?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.profileImage.applyCircledView()
        self.highCHeight.constant = 0
        self.lowerCHeight.constant = 0
        self.supremeCHeight.constant = 0
        self.lblHighCHeight.constant = 0
        self.lblLowerCHeight.constant = 0
        self.lblSupremeCHeight.constant = 0
        self.txtFullNameOnLisence.delegate = self
        self.txtCnic.delegate = self
        self.txtDob.delegate = self
        self.txtEmail.delegate = self
        self.txtLisence.delegate = self
        self.txtContactNo.delegate = self
        self.txtOfficeAddress.delegate = self
        self.txtIssueDate.delegate = self
        self.txtLisenceNo.delegate = self
        self.txtLisenceType.delegate = self
        self.btnEditProfileImage.isHidden = true
        self.photoPicker.delegate = self
        self.scrollView.contentSize = (CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 100))
        if self.intUserValue != loginUserID {
            self.btnEdit.isHidden = true
        }
        
        if self.bitForViewBtns {
            self.btnsView.isHidden = false
        }
        self.callGetProfileFunction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.callGetProfileFunction()
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
        self.txtDob.isUserInteractionEnabled = true
        self.txtEmail.isUserInteractionEnabled = true
        self.txtContactNo.isUserInteractionEnabled = true
        self.txtOfficeAddress.isUserInteractionEnabled = true
        self.btnProfile.isHidden = false
        self.btnProfile.isUserInteractionEnabled = true
        self.btnEdit.isHidden = true
        self.btnEdit.isUserInteractionEnabled = false
        self.btnSave.isUserInteractionEnabled = true
        self.btnSave.isHidden = false
//        self.btnEditProfileImage.isHidden = false
        
//        self.alertView(alertMessage: "Save Changes", action: <#T##UIAlertAction#>)
        
    }
    
    @IBAction func tappedOnSave( _sender: UIButton) {
      

        self.callUpdateUserApi()
        self.btnEdit.isHidden = false
        self.btnEdit.isUserInteractionEnabled = true
        self.btnSave.isUserInteractionEnabled = false
        self.btnSave.isHidden = true
//        if self.intForUpdateUser == 1 {
//            self.callUpdateUserApi()
//        }
        
    }
    
    @IBAction func tappedOnEditProfile( _sender: UIButton) {
        
        self.selectPhoto()
    }
    
    @IBAction func tappedOnApproved( _sender: UIButton) {
        
        self.callUpdateUsersApi(status: "2", id: self.intUserValue)
    }
    
    @IBAction func tappedOnRejected( _sender: UIButton) {
        
        self.callUpdateUsersApi(status: "3", id: self.intUserValue)
    }
    
    @IBAction func tappedOnViewLisence( _sender: UIButton) {
  
        
        let approveVC = UIImageViewController(nibName: "UIImageViewController", bundle: nil)
        let lisenceName = self.lisenceUrl!
        approveVC.name = lisenceName
        self.navigationController?.pushViewController(approveVC, animated: true)
//        if let url = self.lisenceUrl {
//            self.getURL(url: url)
//        }
//        let approveVC = UIImageViewController(nibName: "UIImageViewController", bundle: nil)
//        self.navigationController?.pushViewController(approveVC, animated: true)
    }
    
    @IBAction func tappedOnProfileIcon( _sender: UIButton) {
        
//        if let url = self.profileUrl {
//            self.getURL(url: url)
//        }
        if self.bitForViewProfile {
            print("not showing...")
        } else {
            let approveVC = UIImageViewController(nibName: "UIImageViewController", bundle: nil)
            let profileName = self.profileUrl!
            approveVC.name = profileName
            self.navigationController?.pushViewController(approveVC, animated: true)
        }
        
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
        if textField == self.txtDob {
            self.calenderView = CalenderViewController()
            if let calender = self.calenderView {
                
                txtDob.endEditing(true)
                calender.modalPresentationStyle = .overCurrentContext
                calender.modalTransitionStyle = .crossDissolve
                calender.delegate = self
                self.present(calender, animated: true, completion: nil)
                
            }
        }
        if textField == self.txtContactNo {
            self.txtContactNo.keyboardType = .numberPad
        }
        
        if textField == self.txtEmail {
            self.txtContactNo.keyboardType = .emailAddress
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {return true}
        if textField == self.txtFullNameOnLisence { return string.isValidNameInput }
        if textField == self.txtEmail { return string.isValidEmailInput }
        if textField == self.txtOfficeAddress { return string.isValidAddressInput }
        if textField == self.txtContactNo {

            let maxLength = 11
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return (string.isValidNumberInput && newString.length <= maxLength)
        }
        return true
    }
    
    func didSelectDate(date: String, isClear: Bool) {
        self.txtDob.text = date
    }
    

    //MARK: - CallingApiFunction
    
    func callGetProfileFunction() {
        
        if  Connectivity.isConnectedToInternet {
                
                startAnimation()
            let dataModel = ProfileRequestModel(source: "2", user: ProfileUser(userId: self.intUserValue))
                let signUpUrl = "api/User/GetUserDetail"
                let services = ProfileServices()
                services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                    print(responseData)
                    self.stopAnimation()
                    let user = responseData.user
                    let status = responseData.success ?? false
                    if status {
                        let profileName = (user?.profileUrl as! NSString).lastPathComponent
                        
                        let url = URL(string: "\(Constant.imageDownloadURL)\(user?.profileUrl ?? "")")
                        let resource = ImageResource(downloadURL: url!, cacheKey: profileName)
                        self.profileImage.kf.setImage(with: resource)
                        self.lblMemberName.text = user?.fullName
                        self.txtFullNameOnLisence.text = user?.fullName
                        self.txtCnic.text = user?.cnic
                        self.txtDob.text = user?.dob
                        self.txtContactNo.text = user?.contactNumber
                        self.lblCourtName.text = user?.licenseType
                        self.txtLisenceType.text = user?.licenseType
                        self.txtLisence.text = user?.licenseUrl
                        self.profileUrl = profileName
                        let lisenceName = (user?.licenseUrl as! NSString).lastPathComponent
                        let urlOfLisence = URL(string: "\(Constant.imageDownloadURL)\(user?.licenseUrl ?? "")")
                        let lisenceResource = ImageResource(downloadURL: urlOfLisence!, cacheKey: lisenceName)
                        self.lisenceImage.kf.setImage(with: lisenceResource)
                        self.lisenceUrl = lisenceName
                        self.txtLisenceNo.text = user?.licenseNumber
                        self.txtOfficeAddress.text = user?.officeAddress
                        self.txtIssueDate.text = user?.issuanceDateHighCourt
                        self.txtEmail.text = user?.email
                        
                        if user?.issuanceDateLowerCourt != "" {
                            self.lblLowerCHeight.constant = 20
                            self.lowerCHeight.constant = 50
                            self.topLowerCHeight.constant = 25
                            self.txtIssueDate.text = user?.issuanceDateLowerCourt
                        } else {
                            self.topLowerCHeight.constant = 0
                            self.lblLowerCHeight.constant = 0
                            self.lowerCHeight.constant = 0
                        }
                        if user?.issuanceDateHighCourt != "" {
                            self.lblHighCHeight.constant = 20
                            self.highCHeight.constant = 50
                            self.topHighCHeight.constant = 25
                            self.txtIssueHighDate.text = user?.issuanceDateHighCourt
                        } else {
                            self.topHighCHeight.constant = 0
                            self.lblHighCHeight.constant = 0
                            self.highCHeight.constant = 0
                        }
                        if user?.issuanceDateSupremeCourt != "" {
                            self.lblSupremeCHeight.constant = 20
                            self.supremeCHeight.constant = 50
                            self.topSupremeCHeight.constant = 25
                            self.txtIssueSupremeDate.text = user?.issuanceDateSupremeCourt
                        } else {
                            self.topSupremeCHeight.constant = 0
                            self.lblSupremeCHeight.constant = 0
                            self.supremeCHeight.constant = 0
                        }
                        print("success")
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "User Not Found")
                    }
                }
            } else {
            
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    func getURL(url: URL) {
        
        self.previewItems.removeAll()
        self.quickLook(url: url) { _ in
            DispatchQueue.main.async {
                self.showPreview(index: 0)
            }
            
        }
        
//        self.showPreview(index: 0)
    }
    
    func callUpdateUserApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let file = ProfileAttachmentFileRequestModel(profilePicture: self.strProfileImage ?? "")
            let dataModel = UpdateUser(Source: "2", userId: "\(loginUserID ?? 0)", fullName: self.txtFullNameOnLisence.text ?? "", dob: self.txtDob.text ?? "", contactNumber: self.txtContactNo.text ?? "", email: self.txtEmail.text ?? "", officeAddress: self.txtOfficeAddress.text ?? "")
            let updateProfileUrl = "api/User/UpdateUser"
            let services = ProfileServices()
            services.postUploadMethod(files: file.params, urlString: updateProfileUrl, dataModel: dataModel.params, completion: { (responseData) in
                self.stopAnimation()
                let status = responseData.success
                
                if status ?? false {
                    print("success")
                    self.txtFullNameOnLisence.isUserInteractionEnabled = false
                    self.txtDob.isUserInteractionEnabled = false
                    self.txtEmail.isUserInteractionEnabled = false
                    self.txtContactNo.isUserInteractionEnabled = false
                    self.txtOfficeAddress.isUserInteractionEnabled = false
                    self.btnProfile.isHidden = true
                    self.btnProfile.isUserInteractionEnabled = false
                    self.btnEdit.setTitle("Edit", for: .normal)
                    let urlUpdateProfile = URL(string: self.strProfileImage ?? "")
                    urlProfile = urlUpdateProfile
                    self.bitForViewProfile = true
                    strUserName = self.txtFullNameOnLisence.text ?? ""
                    
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                } else{
                    print("failed")
                    self.txtFullNameOnLisence.isUserInteractionEnabled = false
                    self.txtDob.isUserInteractionEnabled = false
                    self.txtEmail.isUserInteractionEnabled = false
                    self.txtContactNo.isUserInteractionEnabled = false
                    self.txtOfficeAddress.isUserInteractionEnabled = false
                    self.btnProfile.isHidden = true
                    self.btnProfile.isUserInteractionEnabled = false
                    self.btnEdit.setTitle("Edit", for: .normal)
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    
                }
            })
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func callUpdateUsersApi(status: String, id: Int) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AcceptRequestModel(source: "2", user: AcceptUser(status: status, userId: id, reason: "fail"))
            let signUpUrl = "api/User/UpdateUserStatus"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let response = responseData.success ?? false
                if response {
                    let alert = UIAlertController(title: "Islamabad Bar Connect", message: responseData.desc ?? "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
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
