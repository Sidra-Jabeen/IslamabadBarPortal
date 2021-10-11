//
//  SignUpViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class SignUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var viewCircledImage: UIView!
    @IBOutlet weak var signUpBtnView: UIView!
    @IBOutlet weak var tblRegistration: UITableView!
    
    var arrSignUpList = ["Full Name On Lisence","CNIC","Date of Birth","Profile Picture","Contact Number","Email","Lisence", "Lisence Type","Issue Date of Lower Court","Issue Date of High Court","Issue Date of Supreme Court","Office Address" ]
    var imagesBtns : [String] = [ "Layer 19", "id card", "layer1", "Group 98", "172517_phone_icon",  "3586360_email_envelope_mail_send_icon", "Group 98", "21", "layer1", "layer1", "layer1", "" ]
    

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
        tmpCell.txtInfo.placeholder = self.arrSignUpList[indexPath.row]
        tmpCell.btn.setImage(UIImage(named: self.imagesBtns[indexPath.row]), for: .normal)

        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    
}
