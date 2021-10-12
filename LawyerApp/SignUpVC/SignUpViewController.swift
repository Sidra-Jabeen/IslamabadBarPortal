//
//  SignUpViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Alamofire
import DropDown

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    
    @IBOutlet weak var viewCircledImage: UIView!
    @IBOutlet weak var signUpBtnView: UIView!
    @IBOutlet weak var tblRegistration: UITableView!
    
    public var delegate: SignUpControllerDelegate?
    
    var arrSignUpList = ["Full Name On Lisence","CNIC","Date of Birth","Profile Picture","Contact Number","Email","Lisence", "Lisence Type","Issue Date of Lower Court","Issue Date of High Court","Issue Date of Supreme Court","Office Address" ]
    var arrPlaceHolderList = ["Full Name On Lisence","CNIC","Date of Birth","Profile Picture","Contact Number","Enter Email","Upload Lisence", "Select","dd/mm/yyyy","dd/mm/yyyy","dd/mm/yyyy","Office Address" ]
    var imagesBtns : [String] = [ "Layer 19", "id card", "layer1", "Group 98", "172517_phone_icon",  "3586360_email_envelope_mail_send_icon", "Group 98", "21", "layer1", "layer1", "layer1", "" ]
    var arrType = ["text","number","calender","photo library","number","text","text","dropdown","calender","calender","calender","text"]
//    let dropDown = DropDown()
//    let dropDownValues = ["Issue Date of Lower Court","Issue Date of High Court","Issue Date of Supreme Court"]
//    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewCircledImage.applyCircledView()
        self.signUpBtnView.setCornerRadiusToView()
        self.navigationController?.isNavigationBarHidden = true
        self.tblRegistration.showsVerticalScrollIndicator = false
        
        self.tblRegistration.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
    }
    
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrSignUpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        tmpCell.lblInfo.text = self.arrSignUpList[indexPath.row]
        tmpCell.txtInfo.placeholder = self.arrPlaceHolderList[indexPath.row]
        tmpCell.values = self.arrType[indexPath.row]
        tmpCell.txtfield.delegate = self
        tmpCell.btn.setImage(UIImage(named: self.imagesBtns[indexPath.row]), for: .normal)
        delegate?.didSelectItem(txt : tmpCell.txtfield, view: SignUpViewController())

        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    @IBAction func tappedOnSignUp( _sender: UIButton) {
        
        self.callSignUpAPI()
    }

    
    func callSignUpAPI() {
        
        let data = Request(source: "2", licenseFile: "", profileFile: "", user: User(FULL_NAME: "Sidra jabeen", CNIC: "3740599261522", LICENSE_NUMBER: "1234567", CONTACT_NUMBER: "1234567", EMAIL: "sidra.jabeen@gmail.com", OFFICE_ADDRESS: "abjawd akhgdhw", PASSWORD: "12345678", LICENSE_TYPE: "Lower Court", ISSUANCE_DATE_LOWER_COURT: "14/02/1998", ISSUANCE_DATE_HIGH_COURT: "14/02/1998", ISSUANCE_DATE_SUPREME_COURT: "14/02/1998"))
        let signUpUrl = "Account/Registeration"
        let services = SignUpServices()
        services.postMethod(urlString: signUpUrl, dataModel: data.params) { (responseData) in
            print(responseData)
        }
    }
    
    
}

protocol SignUpControllerDelegate {
    func didSelectItem( txt : UITextField, view: UIViewController)
}
