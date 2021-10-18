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
    
    //MARK: - Propertities
    
    var strCalenderPickerValueTest = ""
    var pickerTextIndex = 0
    var strImageName: String?
    var textTemp = UITextField()
    let calenderView = CalenderViewController()
    let arrayOfUserInfo = [String]()
    var courtCell: IssuseDateTableViewCell?
    var date: Date?
    var selectedDateIndex = 0
    var btnSelectionArray = [false, false, false]
    var cellArray : [(arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String)] = [
        ("Issue Date of Lower Court","dd/mm/yyyy","layer1","calender",true, ""),
        ("Issue Date of High Court","dd/mm/yyyy","layer1","calender",true, ""),
        ("Issue Date of Supreme Court","dd/mm/yyyy","layer1","calender",true, "")
    ]
    let photoPicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    
    var mainArray: [(arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String)] = [
        ("Full Name On Lisence","Enter Full Name On Lisence","profile","text",true, ""),
        ("CNIC","Enter CNIC Number","id card","number",true, ""),
        ("Date of Birth","dd/mm/yyyy","layer1","calender",true, ""),
        ("Lisence/HCR No.","Enter Lisence/HCR No","id card","text",true, ""),
        ("Contact Number 1","+92 xxx xxxxxxx","172517_phone_icon","number",true, ""),
        ("Contact Number 2","+92 xxx xxxxxxx","172517_phone_icon","number",true, ""),
        ("Email","Enter Email","3586360_email_envelope_mail_send_icon","text",true, ""),
        ("Password","Enter Password","Layer 19","text",true, ""),
        ("Lisence","Upload Lisence","Group 98","photo library",false, ""),
        ("Member Of","","","checkboxes",true, "")
    ]
    
    private lazy var datePickerView: DateTimePicker = {
        
        let picker = DateTimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (selectedDate) in
            print(selectedDate)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let strDate = formatter.string(from: selectedDate)
            self?.mainArray[self?.selectedDateIndex ?? 0].inputText = strDate
            self?.strCalenderPickerValueTest = strDate
            self?.tblRegistration.reloadData()
        }
        return picker
    }()
    
    var objOfficeAddress : (arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool, inputText: String) = ("Office Address","","","text",true, "")
    
    var counterForMembers: Int?
    var signUpArray = [String]()
    //    let validate = Validate()
    let dropDown = DropDown()
    let dropDownValues = ["Issue Date of Lower Court","Issue Date of High Court","Issue Date of Supreme Court"]
    var imagePicker = UIImagePickerController()
    var indexs = [Int]()
    
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
        self.calenderView.delegate = self
        self.photoPicker.delegate = self
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                swipeLeft.direction = .right
                self.view.addGestureRecognizer(swipeLeft)
        
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
    
    //MARK: - IBAction
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
        self.callSignUpAPI()
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
            print("test value calender: \(self.mainArray[indexPath.row].inputText) \(selectedDateIndex) \(strCalenderPickerValueTest)")
            if indexPath.row != 9 {
                let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
                let cellIndexData = mainArray[indexPath.row]
                
                //                tmpCell.values = cellIndexData.arrOfTypes
                tmpCell.btn.setImage(UIImage(named: cellIndexData.imagesBtns), for: .normal)
                tmpCell.btnTextFiled.tag = indexPath.row
                
                tmpCell.tag = indexPath.row
                
                tmpCell.lblInfo.text = cellIndexData.arrSignUpList
                
                tmpCell.txtInfo.placeholder = cellIndexData.arrPlaceHolderList
                tmpCell.txtInfo.tag = indexPath.row
                tmpCell.txtInfo.delegate = self
                tmpCell.txtInfo.text = cellIndexData.inputText
                
                if cellIndexData.rowSelectedValue {
                    
                    tmpCell.txtInfo.isUserInteractionEnabled = true
                    tmpCell.btnTextFiled.isUserInteractionEnabled = false
                    
                    if self.mainArray[indexPath.row].arrOfTypes == "text" {
                        tmpCell.txtInfo.keyboardType = .alphabet
                    } else if self.mainArray[indexPath.row].arrOfTypes == "number" {
                        tmpCell.txtInfo.keyboardType = .numberPad
                    } else if self.mainArray[indexPath.row].arrOfTypes == "calender" {
                        tmpCell.txtInfo.inputView = datePickerView.inputView
                    }
                } else {
                    
                    tmpCell.txtInfo.isUserInteractionEnabled = false
                    tmpCell.btnTextFiled.isUserInteractionEnabled = true
                    tmpCell.btnTextFiled.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
                }
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
    
    @objc func tappedOnChkBox(sender: UIButton) {
        
        self.btnSelectionArray[sender.tag] = !self.btnSelectionArray[sender.tag]
        if self.btnSelectionArray[sender.tag] {
            
            self.mainArray.append(self.cellArray[sender.tag])
        } else {
            
            if sender.tag == 0 { self.mainArray.removeAll(where: ({$0.arrSignUpList == "Issue Date of Lower Court"})) }
            if sender.tag == 1 { self.mainArray.removeAll(where: ({$0.arrSignUpList == "Issue Date of High Court"})) }
            if sender.tag == 2 { self.mainArray.removeAll(where: ({$0.arrSignUpList == "Issue Date of Supreme Court"})) }
        }
        
        
        self.tblRegistration.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.selectedDateIndex = textField.tag
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
        if textField.tag == 1 {
            
            let maxLength = 13
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        if textField.tag == 4  {
            
            let maxLength = 11
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        if textField.tag == 5 {
            
            let maxLength = 11
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        self.objOfficeAddress.inputText = textView.text
        self.tblRegistration.reloadData()
    }
    
    @objc func didTap(sender: UIButton) {
        
        if self.mainArray[sender.tag].arrOfTypes == "calender" {
//            self.showDatePicker(index: sender.tag)
            
        } else if self.mainArray[sender.tag].arrOfTypes == "photo library" {
            pickerTextIndex = sender.tag
//            showAlert()
            self.selectPhoto()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section == 0 {
            if indexPath.row != 9 { return 70 } else { return 120 }
        }
        else if indexPath.section == 1 { return 80 }
        else { return 80 }
        
    }
    
    //MARK: - SignUpControllerDelegate
    
    func didSelectItem(txt: UITextField, val: String) {
        
        if val == "text" {
            
            txt.keyboardType = .alphabet
        }
        else if val == "number" {
            
            txt.keyboardType = .numberPad
        }
        else if val == "calender" {
            
            //            self.showDatePicker(textfield: txt)
            
        }
        else if val == "photo library" {
            
//            showAlert()
            selectPhoto()
            
        } else if val == "dropdown" {
            txt.placeholder = "Select"
            dropDown.anchorView = txt
            dropDown.dataSource = dropDownValues
            dropDown.direction = .bottom
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.dropDown.hide()
            }
            dropDown.show()
            
        }
        
    }
    
    func selectedTextfield(index: Int, value: String) {
        
        print(index)
        print(value)
    }
    
    func showDatePicker(index: Int) {
        
        self.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let selectedDate = formatter.string(from: datePicker.date)
        self.mainArray[index].inputText = selectedDate
    }
    
    @objc func donedatePicker(){
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    //MARK: - Calling API
    
    func callSignUpAPI() {
        
        if  Connectivity.isConnectedToInternet {
            
            let dataModel = Request(Source: "2", licenseFile: "", profilePicture: "", fullName: self.mainArray[0].inputText, cnic: self.mainArray[1].inputText, licenseNumber: self.mainArray[3].inputText, contactNumber: self.mainArray[4].inputText, email: self.mainArray[6].inputText, officeAddress: self.objOfficeAddress.inputText, password: self.mainArray[7].inputText, licenseType: self.mainArray[8].inputText, issuanceDateLowerCourt: "", issuanceDateHighCourt: "", issuanceDateSupremeCourt: "", dob: self.mainArray[2].inputText)
            
//            if (dataModel.fullName != "") && (dataModel.cnic != "") && (dataModel.dob != "") && (dataModel.licenseNumber != "") && (dataModel.contactNumber != "")  && (dataModel.email != "") && (dataModel.password != "") && (dataModel.cnic != "") {
                
                let validation = Validate()
                if validation.isValidName(testStr: dataModel.fullName) {
                    if validation.IsValidCNIC(cnicStr: dataModel.cnic) {
                        if validation.isValidDate(dateString: dataModel.dob) {
                            if validation.isValidPhone(testStr: dataModel.contactNumber) {
                                if validation.isEmailValid(emailStr: dataModel.email) {
                                    if validation.isValidAddress(testStr: dataModel.officeAddress) {
                                        self.startAnimation()
                                        let signUpUrl = "api/Account/Registration"
                                        let services = SignUpServices()
                                        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                                            print(responseData)
                                            self.stopAnimation()
                                            let status = responseData.success ?? false
                                            if status {
                                                self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                                                self.mainArray.removeAll()
                                                self.tblRegistration.reloadData()
                                            } else {
                                                
                                                self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "Something went wrong!")
                                                
                                                self.mainArray.removeAll()
                                                self.tblRegistration.reloadData()
                                            }
                                        }
                                    } else {self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "InValid Office Address")}
                                    
                                } else{self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "InValid Date")}
                                
                            } else {self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "InValid Email")}
                            
                        } else{self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "InValid Contact Number")}
                        
                    } else {self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "Length Should be equal to 13 Numbers")}
                    
                    
                } else { self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "Invalid Name")}
                
                
//            } else {
//                self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "InValid Information")
//            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        if let url = info[.imageURL] as? NSURL else { return }
//        let filename = url.lastPathComponent
        
//        dismiss(animated: true) {
//
//            self.mainArray[self.pickerTextIndex].inputText = filename ?? ""
//            self.tblRegistration.reloadData()
//        }
        
        if let originalImage = info[.originalImage] as? UIImage {

//            self.ProfileImageView.contentMode = .scaleAspectFill
//            let newImage = self.ResizeImage(image: originalImage, targetSize: CGSize(width: 300 , height: 300))
//            self.ProfileImageView.image = newImage//originalImage
        }
        dismiss(animated: true, completion: {
            self.mainArray[self.pickerTextIndex].inputText = "image.jpg"
            self.tblRegistration.reloadData()
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Image Alert
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
//            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
//            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - CalenderControllerDetegate
    
    func didSelectDate(date: String) {
        
        self.textTemp.text = date
    }
    
    func alert(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
