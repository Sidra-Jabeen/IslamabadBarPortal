//
//  SignUpViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Alamofire
import DropDown

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, SignUpControllerDelegate, CalenderControllerDetegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewCircledImage: UIView!
    @IBOutlet weak var signUpBtnView: UIView!
    @IBOutlet weak var tblRegistration: UITableView!
    
    //MARK: - Propertities
    
    var strImageName: String?
    var textTemp = UITextField()
    let calenderView = CalenderViewController()
    let arrayOfUserInfo = [String]()
    
    var mainArray: [(arrSignUpList: String ,arrPlaceHolderList: String, imagesBtns: String, arrOfTypes: String ,rowSelectedValue: Bool)] = [
        ("Full Name On Lisence","Enter Full Name On Lisence","Layer 19","text",true),
        ("CNIC","Full CNIC Number","id card","number",true),
        ("Date of Birth","dd/mm/yyyy","layer1","calender",false),
        ("Profile Picture","Upload Profile Picture","Group 98","photo library",false),
        ("Contact Number","+92 xxx xxxxxxx","172517_phone_icon","number",true),
        ("Email","Enter Email","3586360_email_envelope_mail_send_icon","text",true),
        ("Lisence","Upload Lisence","Group 98","text",true),
        ("Lisence Type","Select","21","dropdown",false),
        ("Issue Date of Lower Court","dd/mm/yyyy","layer1","calender",false),
        ("Issue Date of High Court","dd/mm/yyyy","layer1","calender",false),
        ("Issue Date of Supreme Court","dd/mm/yyyy","layer1","calender",false),
        ("Office Address","Office Address","0","text",true)
    ]
    var signUpArray = [String]()
    
    let dropDown = DropDown()
    let dropDownValues = ["Issue Date of Lower Court","Issue Date of High Court","Issue Date of Supreme Court"]
    var imagePicker = UIImagePickerController()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewCircledImage.applyCircledView()
        self.signUpBtnView.setCornerRadiusToView()
        self.navigationController?.isNavigationBarHidden = true
        self.tblRegistration.showsVerticalScrollIndicator = false
        self.tblRegistration.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        self.calenderView.delegate = self
        
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
        
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let cellIndexData = mainArray[indexPath.row]
        tmpCell.lblInfo.text = cellIndexData.arrSignUpList
        tmpCell.txtInfo.placeholder = cellIndexData.arrPlaceHolderList
        tmpCell.delegate = self
        tmpCell.values = cellIndexData.arrOfTypes
        tmpCell.btn.setImage(UIImage(named: cellIndexData.imagesBtns), for: .normal)
        tmpCell.delegate = self
        tmpCell.btnTextFiled.tag = indexPath.row
        
        if cellIndexData.rowSelectedValue {
             
            tmpCell.txtInfo.isUserInteractionEnabled = true
            tmpCell.btnTextFiled.isUserInteractionEnabled = false
            didSelectItem(txt: tmpCell.txtInfo, val: tmpCell.values ?? "")
        } else {
            
            tmpCell.txtInfo.isUserInteractionEnabled = false
            tmpCell.btnTextFiled.isUserInteractionEnabled = true
            tmpCell.btnTextFiled.addTarget(self, action: #selector(didTap(sender:)), for: .touchUpInside)
        }
        
        return tmpCell
    }
    
    @objc func didTap(sender: UIButton) {
        
        let cell: UserTableViewCell = self.tblRegistration.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! UserTableViewCell
        self.textTemp = cell.txtInfo
        didSelectItem(txt: cell.txtInfo, val: cell.values ?? "")
        print("clicked")
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
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
            

                self.view.addSubview(calenderView.view)
        }
        else if val == "photo library" {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
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
        
//        self.arrayOfUserInfo.append(txt)
    }
    
    //MARK: - CallingAPiMethod
    
    func callSignUpAPI() {
        
        let dataModel = Request(Source: "2", licenseFile: "", profilePicture: "", fullName: "Sidra jabeen", cnic: "3740599261522", licenseNumber: "1234567", contactNumber: "1234567", email: "sidra.jabeen@gmail.com", officeAddress: "abjawd akhgdhw", password: "12345678", licenseType: "Lower Court", issuanceDateLowerCourt: "14/02/1998", issuanceDateHighCourt: "14/02/1998", issuanceDateSupremeCourt: "14/02/1998", dob: "14/02/1998")
        let signUpUrl = "api/Account/Registration"
        let services = SignUpServices()
        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
            print(responseData)
        }
    }
    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//
//        guard let url = editingInfo[.imageURL] as? NSURL else { return }
//          let filename = url.lastPathComponent!
//          print(filename)
//
//        dismiss(animated: true, completion: nil)
////        self.dismiss(animated: true, completion: { () -> Void in
////
////        })
////
////        self.strImageName = image.toPngString()
////        print( self.strImageName)
//    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let url = info[.imageURL] as? NSURL else { return }
        let filename = url.lastPathComponent!
        dismiss(animated: true) {
            self.strImageName = filename
            self.textTemp.text = self.strImageName
            print(filename)
        }
    }
    
    //MARK: - CalenderControllerDetegate
    
    func didSelectDate(date: String) {
        
        self.textTemp.text = date
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
