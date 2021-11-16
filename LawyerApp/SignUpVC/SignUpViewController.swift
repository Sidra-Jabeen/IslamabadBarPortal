//
//  SignUpViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Alamofire
import DropDown
import SwiftUI

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, CalenderControllerDetegate, UITextViewDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewCircledImage: UIView!
    @IBOutlet weak var signUpBtnView: UIView!
    @IBOutlet weak var tblRegistration: UITableView!
    @IBOutlet weak var dateBarView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var pandulumImage: UIImageView!
    
    //MARK: - Propertities
    
    var pickerTextIndex = 0
    var calenderView: CalenderViewController?
    var selectedDateIndex = 0
    let validation = Validate()
    var bitForProifle = false
    var strDateOfBirth: String?
    var btnSelectionArray = [false, false, false]
    var cellArray : [(arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String)] = [
        ("Issue Date of Lower Court","dd-mm-yyyy","layer1","calender",false, ""),
        ("Issue Date of High Court","dd-mm-yyyy","layer1","calender",false, ""),
        ("Issue Date of Supreme Court","dd-mm-yyyy","layer1","calender",false, "")
    ]
    let photoPicker = UIImagePickerController()
    var mainArray: [(arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String)] = [
        ("Full Name On Lisence","Enter Full Name On Lisence","profile","text",true, ""),
        ("CNIC","Enter CNIC Number","id card","number",true, ""),
        ("Date of Birth","dd-mm-yyyy","layer1","calender",false, ""),
        ("Profile Picture","Upload Profile Picture","Group 98","photo library",false, ""),
        ("Lisence/HCR No.","Enter Lisence/HCR No","id card","text",true, ""),
        ("Contact Number 1","03xxxxxxxxx","172517_phone_icon","number",true, ""),
        ("Contact Number 2","03xxxxxxxxx","172517_phone_icon","number",true, ""),
        ("Email","Enter Email","3586360_email_envelope_mail_send_icon","email",true, ""),
        ("Password","Enter Password","lock","text",true, ""),
        ("Confirm Password","Enter Password","lock","text",true, ""),
        ("Lisence","Upload Lisence","Group 98","photo library",false, ""),
        ("Member Of","","","checkboxes",true, "")
    ]
    var objOfficeAddress : (arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String) = ("Office Address","","","text",true, "")
    var imagePicker = UIImagePickerController()
    var arrToString = [String]()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCircledImage.applyCircledView()
        self.signUpBtnView.setCornerRadiusToView()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.tblRegistration.showsVerticalScrollIndicator = false
        self.tblRegistration.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        self.tblRegistration.register(UINib(nibName: "MembersOfIslamabadTableViewCell", bundle: nil), forCellReuseIdentifier: "MembersOfIslamabadTableViewCell")
        self.tblRegistration.register(UINib(nibName: "IssuseDateTableViewCell", bundle: nil), forCellReuseIdentifier: "IssuseDateTableViewCell")
        self.tblRegistration.register(UINib(nibName: "HighCourtTableViewCell", bundle: nil), forCellReuseIdentifier: "HighCourtTableViewCell")
        self.tblRegistration.register(UINib(nibName: "SupremeCourtTableViewCell", bundle: nil), forCellReuseIdentifier: "SupremeCourtTableViewCell")
        self.tblRegistration.register(UINib(nibName: "OfficeAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "OfficeAddressTableViewCell")
        
        self.photoPicker.delegate = self
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                swipeLeft.direction = .right
                self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    //MARK: - HandGestures Method
    
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
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
//        self.callSignUpAPI()
        self.signUpAPi()
    }
    
    @IBAction func tappedOnDone( _sender: UIButton) {
        
        
    }
    
    //MARK: - UITableViewDelegate&UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if section == 0 {
            return mainArray.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row != 11 {
                let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
                let cellIndexData = mainArray[indexPath.row]
                tmpCell.btn.setImage(UIImage(named: cellIndexData.imagesBtns), for: .normal)
                tmpCell.btnTextFiled.tag = indexPath.row
                
                tmpCell.tag = indexPath.row
                
                tmpCell.lblInfo.text = cellIndexData.arrSignUpList
                
                tmpCell.txtInfo.placeholder = cellIndexData.arrPlaceHolderList
                tmpCell.txtInfo.tag = indexPath.row
                tmpCell.txtInfo.isSecureTextEntry = (indexPath.row == 8 || indexPath.row == 9)
                tmpCell.txtInfo.delegate = self
                tmpCell.txtInfo.text = cellIndexData.inputText
                if cellIndexData.arrSignUpList == "Contact Number 2" {
                    tmpCell.imgStar.image = UIImage(systemName: "")
                } else {
                    tmpCell.imgStar.image = UIImage(systemName: "staroflife.fill")
                }
                
                
                
                if cellIndexData.rowSelectedValue {
                    
                    tmpCell.txtInfo.isUserInteractionEnabled = true
                    tmpCell.btnTextFiled.isUserInteractionEnabled = false
                    
                    if self.mainArray[indexPath.row].arrOfTypes == "text" {
                        tmpCell.txtInfo.keyboardType = .alphabet
                    } else if self.mainArray[indexPath.row].arrOfTypes == "number" {
                        tmpCell.txtInfo.keyboardType = .numberPad
                    } else if self.mainArray[indexPath.row].arrOfTypes == "email" {
                        tmpCell.txtInfo.keyboardType = .emailAddress
                    } else if self.mainArray[indexPath.row].arrOfTypes == "calender" {
                        //                        self.calenderView = CalenderViewController()
                        //                        if let calender = self.calenderView {
                        //
                        //                            calender.modalPresentationStyle = .overCurrentContext
                        //                            calender.modalTransitionStyle = .crossDissolve
                        //                            calender.delegate = self
                        //                            self.present(calender, animated: true, completion: nil)
                        //                        }
                        //                        tmpCell.txtInfo.inputView = datePickerView.inputView
                        //                        tmpCell.txtInfo.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
                        //                        self.showDatePicker(index: self.selectedDateIndex )
                    }
                } else {
                    
                    tmpCell.txtInfo.isUserInteractionEnabled = false
                    tmpCell.btnTextFiled.isUserInteractionEnabled = true
                    tmpCell.btnTextFiled.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
                }
                
                //                if tmpCell.txtInfo.tag == self.intForTextfields {
                //
                //                    tmpCell.txtInfo.becomeFirstResponder()
                //                }
                return tmpCell
            } else {
                
                let tmpCell = tableView.dequeueReusableCell(withIdentifier: "MembersOfIslamabadTableViewCell", for: indexPath) as! MembersOfIslamabadTableViewCell
                tmpCell.btn1.tag = 0
                tmpCell.btn2.tag = 1
                tmpCell.btn3.tag = 2
                tmpCell.btn1.addTarget(self, action: #selector(tappedOnChkBox), for: .touchUpInside)
                tmpCell.btn2.addTarget(self, action: #selector(tappedOnChkBox), for: .touchUpInside)
                tmpCell.btn3.addTarget(self, action: #selector(tappedOnChkBox), for: .touchUpInside)
                
                tmpCell.img1.image = UIImage(named: self.btnSelectionArray[0] ? "Group 247" : "Circle")
                tmpCell.img2.image = UIImage(named: self.btnSelectionArray[1] ? "Group 247" : "Circle")
                tmpCell.img3.image = UIImage(named: self.btnSelectionArray[2] ? "Group 247" : "Circle")
                
                return tmpCell
            }
        }
        
        else if indexPath.section == 1 {
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "OfficeAddressTableViewCell", for: indexPath) as! OfficeAddressTableViewCell
            tmpCell.txtview.delegate = self
            return tmpCell
        }
        else {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "IssuseDateTableViewCell", for: indexPath) as! IssuseDateTableViewCell
            return tmpCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            if indexPath.row != 11 { return 70 } else { return 120 }
        }
        else if indexPath.section == 1 { return 80 }
        else { return 80 }
        
    }
    
    //MARK: - CellButtonsTarget
    
    @objc func tappedOnChkBox(sender: UIButton) {
        
        self.btnSelectionArray[sender.tag] = !self.btnSelectionArray[sender.tag]
        if self.btnSelectionArray[sender.tag] {
            
            self.mainArray.append(self.cellArray[sender.tag])
            self.arrToString.append("\(sender.tag+1)")
        } else {
            
            if sender.tag == 0 { self.mainArray.removeAll(where: ({$0.arrSignUpList == "Issue Date of Lower Court"}))}
            if sender.tag == 1 { self.mainArray.removeAll(where: ({$0.arrSignUpList == "Issue Date of High Court"})) }
            if sender.tag == 2 { self.mainArray.removeAll(where: ({$0.arrSignUpList == "Issue Date of Supreme Court"})) }
            
            self.arrToString.removeAll(where: ({$0 == "\(sender.tag+1)"}))
        }
        self.mainArray[11].inputText = self.convertArrayToString(arr: self.arrToString)
//        if sender.tag == 0 { self.mainArray[10].inputText = "1"}
//        if sender.tag == 1 { self.mainArray[10].inputText = "2"}
//        if sender.tag == 2 { self.mainArray[10].inputText = "3"}
        
        self.tblRegistration.reloadData()
    }
    
    func convertArrayToString(arr: [String]) -> String {
        
        var strValue = ""
        for (index, strItem) in arr.enumerated() {
//            if arr.count - 1 == index {
//                strValue = "\(strValue),\(strItem)"
//            } else
            if index == 0 {
                strValue = "\(strItem)"
            } else {
                strValue = "\(strValue),\(strItem)"
            }
        }
        return strValue
    }
    
    @objc func didTap(sender: UIButton) {
        
        if self.mainArray[sender.tag].arrOfTypes == "calender" {
            self.selectedDateIndex = sender.tag
            self.calenderView = CalenderViewController()
            if let calender = self.calenderView {
                
                calender.modalPresentationStyle = .overCurrentContext
                calender.modalTransitionStyle = .crossDissolve
                calender.delegate = self
                if self.mainArray[self.selectedDateIndex].arrSignUpList == "Issue Date of Lower Court" {
                    strDOB = self.mainArray[self.selectedDateIndex].inputText
                } else if self.mainArray[self.selectedDateIndex].arrSignUpList == "Issue Date of High Court" {
                    strDOB = self.mainArray[self.selectedDateIndex].inputText
                } else if self.mainArray[self.selectedDateIndex].arrSignUpList == "Issue Date of Supreme Court" {
                    strDOB = self.mainArray[self.selectedDateIndex].inputText
                } else if self.mainArray[self.selectedDateIndex].arrSignUpList == "Date of Birth" {
                    strDOB = self.mainArray[self.selectedDateIndex].inputText
                }
                self.present(calender, animated: true, completion: nil)
            }
            
        } else if self.mainArray[sender.tag].arrOfTypes == "photo library" {
            self.pickerTextIndex = sender.tag
            self.selectPhoto()
            
        }
    }
    
    //MARK: - UITextfieldDelegatesMethod
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        self.selectedDateIndex = textField.tag
//        textField.isSecureTextEntry = (textField.tag == 8 || textField.tag == 9)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag < self.mainArray.count {
            
            if self.mainArray[textField.tag].arrOfTypes != "calender" {
                self.mainArray[textField.tag].inputText = textField.text ?? ""
            }
            self.tblRegistration.reloadData()
        } else {
            
            print("Index Out Of Range")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {return true}
        if textField.tag == 0 { return string.isValidNameInput }
//        if textField.tag == 1 { return string.isValidCNICInput }
//        if textField.tag == 5 { return string.isValidNumberInput gd}
//        if textField.tag == 6 { return string.isValidNumberInput }
        if textField.tag == 7 {
            return string.isValidEmailInput }
        if textField.tag == 1 {

            let maxLength = 13
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return (string.isValidNumberInput && newString.length <= maxLength)
        }
        
        if textField.tag == 5  {

//            if {
//                
//            } else if {
//                
//            } else {
//                
//            }
            let maxLength = 11
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return (string.isValidNumberInput && newString.length <= maxLength)
        }

        if textField.tag == 6 {

            let maxLength = 13
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return (string.isValidNumberInput && newString.length <= maxLength)
        }
        
        if textField.tag == 4 {
            self.callVerifyLisence(text: textField.text ?? "")
//            if textField.text == "1112" {
//                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Already Exist")
//            }
        }
        

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - UITextViewDelegatesMethod
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        self.objOfficeAddress.inputText = textView.text
        self.tblRegistration.reloadData()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let validation = Validate()
        if textView.tag == 1 {
            return text.isValidAddressInput
        }
        return true
    }
    
    //MARK: - Calling API
    
    func signUpAPi() {
        
        let strLowerCourt = self.findOut(arrSignUpList: "Issue Date of Lower Court") ?? ""
        let strHigherCourt = self.findOut(arrSignUpList: "Issue Date of High Court") ?? ""
        let strsupremeCourt = self.findOut(arrSignUpList: "Issue Date of Supreme Court") ?? ""
        
        if !(self.mainArray[0].inputText.isEmpty) {
            if !(self.mainArray[1].inputText.isEmpty) && self.mainArray[1].inputText.count == 13 {
                if !(self.mainArray[2].inputText.isEmpty){
                    if self.validation.isValidDate(dateString: self.mainArray[2].inputText) {
                        if !(self.mainArray[3].inputText.isEmpty) {
                            if !(self.mainArray[4].inputText.isEmpty) {
                                if !(self.mainArray[5].inputText.isEmpty) && self.mainArray[5].inputText.count == 11 {
                                    if self.mainArray[5].inputText.starts(with: "03") {
                                        if (self.mainArray[6].inputText.isEmpty) || (!(self.mainArray[6].inputText.isEmpty) &&  self.mainArray[6].inputText.starts(with: "03")) {
                                        if !(self.mainArray[7].inputText.isEmpty) {
                                            if self.validation.isValidEmail(testStr: self.mainArray[7].inputText) {
                                                if !(self.mainArray[8].inputText.isEmpty) {
                                                    if !(self.mainArray[9].inputText.isEmpty) && (self.mainArray[8].inputText == self.mainArray[9].inputText) {
                                                        if !(self.mainArray[10].inputText.isEmpty) {
                                                            if !(self.mainArray[11].inputText.isEmpty) {
                                                            if strLowerCourt != "" || strHigherCourt != "" || strsupremeCourt != "" {
                                                                if strLowerCourt == "" && self.findOutForTextFields(arrSignUpList: "Issue Date of Lower Court") {
                                                                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Issue Date of Lower Court is missing.")
                                                                    return
                                                                }
                                                                
                                                                if strHigherCourt == "" && self.findOutForTextFields(arrSignUpList: "Issue Date of High Court") {
                                                                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Issue Date of Higher Court is missing.")
                                                                    return
                                                                }
                                                                
                                                                if strsupremeCourt == "" && self.findOutForTextFields(arrSignUpList: "Issue Date of Supreme Court") {
                                                                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Issue Date of Supreme Court is missing.")
                                                                    return
                                                                }
                                                                
                                                                if !(self.objOfficeAddress.inputText.isEmpty){
                                                                    self.signUPRequest()
                                                                } else{
                                                                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Enter Office Address")
                                                                }
                                                            }
                                                                else {
                                                                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Issue Date is missing.")
                                                            }
                                                        }
                                                            else {
                                                                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Lisence Type Required.")
                                                            }
                                                        }
                                                        else {
                                                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Upload Lisence")
                                                        }
                                                    } else {
                                                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Confirm Password Must be Equal to Password.")
                                                    }
                                                } else {
                                                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Enter Password")
                                                }
                                            } else {
                                                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Email is not in a right format.")
                                            }
                                        } else {
                                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Enter Email")
                                        }
                                    }
                                    else {

                                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Contact Number 2 Should Be Starts With 03.")
                                        }
                                } else {
                                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Contact Number Should Be Starts With 03.")
                                    }
                                }else {
                                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Contact Number Should Be 11 Digits")
                                }
                            } else {
                                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Enter Lisence Number")
                            }
                        } else {
                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Select Profile Picture")
                        }
                    }
                    else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "DOB should be greater than 18 years")
                    }
                }else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Enter Date Of Birth")
                }
            } else {
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "CNIC Should Be 13 Digits")
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Enter Full Name")
        }
    }
    
    func signUPRequest() {
        
        if  Connectivity.isConnectedToInternet {
            let file = SignUpAttachmentFileRequestModel(licenseFile: self.mainArray[10].inputText, profilePicture: self.mainArray[3].inputText)
            let dataModel = Request(Source: "2", fullName: self.mainArray[0].inputText, cnic: self.mainArray[1].inputText, licenseNumber: self.mainArray[4].inputText, contactNumber: self.mainArray[5].inputText, email: self.mainArray[7].inputText, officeAddress: self.objOfficeAddress.inputText, password: self.mainArray[8].inputText, licenseType: self.mainArray[11].inputText, issuanceDateLowerCourt: self.findOut(arrSignUpList: "Issue Date of Lower Court") ?? "", issuanceDateHighCourt: self.findOut(arrSignUpList: "Issue Date of High Court") ?? "", issuanceDateSupremeCourt: self.findOut(arrSignUpList: "Issue Date of Supreme Court") ?? "", dob: self.mainArray[2].inputText, secondaryContactNumber: self.mainArray[6].inputText)
            self.startAnimation()
            let signUpUrl = Constant.registrationEP
            let services = SignUpServices()
            services.postUploadMethod(files: file.params, urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                print(responseData)
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    //                                            self.mainArray.removeAll()
                    self.tblRegistration.reloadData()
                } else {
                    
                    self.showAlertForSignup(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    
                    //                                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "Something went wrong!")
                    
                    //                                            self.mainArray.removeAll()
                    self.tblRegistration.reloadData()
                }
            }
        }
        else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func callVerifyLisence(text: String) {
        
        if  Connectivity.isConnectedToInternet {
            
//            startAnimation()
            let dataModel = VerifyRequest(source: "2", user: LisenceNumber(licenseNumber: text))
            let loginUrl = Constant.verifyLisenceEP
            let services = SignInServices()
            services.postMethod(urlString: loginUrl, dataModel: dataModel.params) { (responseData) in
                print(responseData)
//                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
//                    let alert = UIAlertController(title: "Islmabad Bar Connect", message: responseData.desc ?? "", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
//                        self.mainArray[4].inputText = ""
//                        self.tblRegistration.reloadData()
//                //        self.navigationController?.popViewController(animated: true)
//
//                    }))
//                    self.present(alert, animated: true, completion: nil)
                    
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                } else {
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func callSignUpAPI() {
//        if  Connectivity.isConnectedToInternet {
//            let file = SignUpAttachmentFileRequestModel(licenseFile: self.mainArray[9].inputText, profilePicture: self.mainArray[3].inputText)
//            let dataModel = Request(Source: "2", fullName: self.mainArray[0].inputText, cnic: self.mainArray[1].inputText, licenseNumber: self.mainArray[4].inputText, contactNumber: self.mainArray[5].inputText, email: self.mainArray[7].inputText, officeAddress: self.objOfficeAddress.inputText, password: self.mainArray[8].inputText, licenseType: self.mainArray[10].inputText, issuanceDateLowerCourt: self.findOut(arrSignUpList: "Issue Date of Lower Court") ?? "", issuanceDateHighCourt: self.findOut(arrSignUpList: "Issue Date of High Court") ?? "", issuanceDateSupremeCourt: self.findOut(arrSignUpList: "Issue Date of Supreme Court") ?? "", dob: self.mainArray[2].inputText, secondaryContactNumber: self.mainArray[6].inputText)
//            let validation = Validate()
//            if validation.isValidName(testStr: dataModel.fullName) {
//                if validation.IsValidCNIC(cnicStr: dataModel.cnic) {
//                    if validation.isValidDate(dateString: dataModel.dob) {
//                        if validation.isValidPhone(testStr: dataModel.contactNumber) {
//                            if validation.isEmailValid(emailStr: dataModel.email) {
////                                if validation.isValidAddress(testStr: dataModel.officeAddress) {
//
//                                    self.startAnimation()
//                                let signUpUrl = Constant.registrationEP
//                                    let services = SignUpServices()
//                                    services.postUploadMethod(files: file.params, urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
//                                        print(responseData)
//                                        self.stopAnimation()
//                                        let status = responseData.success ?? false
//                                        if status {
//                                            self.showAlertForSignup(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
////                                            self.mainArray.removeAll()
//                                            self.tblRegistration.reloadData()
//                                        } else {
//
//                                            self.showAlertForSignup(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
//
////                                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "Something went wrong!")
//
////                                            self.mainArray.removeAll()
//                                            self.tblRegistration.reloadData()
//                                        }
//                                    }
////                                }
////                                else {self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Invalid Office Address")}
//
//                            } else{self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Invalid Email Address")}
//
//                        } else {self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Invalid Phone Number")}
//
//                    } else{self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Date should be in dd/MM/yyyy format")}
//
//                } else {self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Length Should be equal to 13 Numbers")}
//
//
//            } else { self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Invalid Name")}
//
//        } else {
//            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
//        }
        
    }
    
    //MARK: - Others
    
    func findOut(arrSignUpList: String) -> String? {
        
//        let value = self.mainArray.filter{$0.arrSignUpList == arrSignUpList}
//        let value = self.mainArray.filter({ $0.arrSignUpList == arrSignUpList}).map({ $0.arrSignUpList })
//        let input = self.mainArray[value].inputText
        if let idx = self.mainArray.firstIndex(where: { $0.arrSignUpList == arrSignUpList }) {
            let input = self.mainArray[idx].inputText
            return input
        }
        return ""
    }
    
    func findOutForTextFields(arrSignUpList: String) -> Bool {
        
//        let value = self.mainArray.filter{$0.arrSignUpList == arrSignUpList}
//        let value = self.mainArray.filter({ $0.arrSignUpList == arrSignUpList}).map({ $0.arrSignUpList })
//        let input = self.mainArray[value].inputText
        if let _ = self.mainArray.firstIndex(where: { $0.arrSignUpList == arrSignUpList }) {
//            let input = self.mainArray[idx].inputText
            
            return true
        }
        return false
    }
    
    func findInputTextValue() {
        
        
    }
    
    func showAlertForSignup(alertTitle : String, alertMessage : String) {
    let alert = UIAlertController(title: "Islmabad Bar Connect", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
//        self.navigationController?.popViewController(animated: true)
        
    }))
    self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageUrl = info[.imageURL] as? URL {
<<<<<<< HEAD
            _ = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
=======
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            if self.pickerTextIndex == 3 {
                self.profileImage.image = image
                self.pandulumImage.image = UIImage(named: "")
            }
            
>>>>>>> d723cdd0d1d38eb0165c0d14d46cafd81d51bab1
//            self.arrayForMedia.append((image,  imageUrl.absoluteString))
            self.mainArray[self.pickerTextIndex].inputText = imageUrl.absoluteString
        } else {
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            if self.pickerTextIndex == 3 {
                self.profileImage.image = image
                self.pandulumImage.image = UIImage(named: "")
            }
            let data = image.pngData()! as NSData
            
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending("/\(self.getRandomNumber()).png")
            data.write(toFile: localPath!, atomically: true)

            let photoURL = URL.init(fileURLWithPath: localPath!)
            print(photoURL)
            self.mainArray[self.pickerTextIndex].inputText = photoURL.absoluteString
//            self.arrayForMedia.append((image, photoURL.absoluteString))
        }
        self.photoPicker.dismiss(animated: true)
        self.tblRegistration.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    //MARK: - SetUpImagesPickerFunctions
    
    func getRandomNumber() -> String{
        
        let timeStamp: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        return "\(timeStamp)"
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
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio, height:size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio, height: size.height * widthRatio)
        }
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0, y:0, width:newSize.width, height:newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //Get image from source type
    
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourceType
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        }

    }
    
    
    //MARK: - CalenderControllerDetegate
    
    func didSelectDate(date: String, isClear: Bool) {
        
//        self.textTemp.text = date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        strDOB = date
        self.mainArray[self.selectedDateIndex].inputText = date
        self.tblRegistration.reloadData()
    }
}

