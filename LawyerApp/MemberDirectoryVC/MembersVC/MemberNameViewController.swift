//
//  MemberNameViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class MemberNameViewController: UIViewController {
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblLisenceDateOfHigh: UILabel!
    @IBOutlet weak var lblLisenceDateOflower: UILabel!
    @IBOutlet weak var lblLisenceDateOfSupreme: UILabel!
    @IBOutlet weak var lblOfcAddress: UILabel!
    @IBOutlet weak var btnAccepted: UIButton!
    @IBOutlet weak var btnRejected: UIButton!
    @IBOutlet weak var btnRemoveAdmin: UIButton!
    @IBOutlet weak var btnMakeAAdmin: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var btnApprovedHeight: NSLayoutConstraint!
    @IBOutlet weak var btnRejectedHeight: NSLayoutConstraint!
    @IBOutlet weak var btnGiveApprovementHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var viewApprovalBtn: UIView!
    @IBOutlet weak var viewRejectedBtn: UIView!
    @IBOutlet weak var viewGiveApprovementBtn: UIView!

    var memberId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnCancel.layer.cornerRadius = self.btnCancel.frame.size.height / 2
        self.centerView.setCornerRadiusToView()
        self.navigationController?.isNavigationBarHidden = true
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
        self.btn1.setCornerRadiusToButton()
        self.btn2.setCornerRadiusToButton()
//        self.btnRejected.setCornerRadiusToButton()
        self.profileImage.applyCircledView()
        
//        self.btnMakeAAdmin.setCornerRadiusToButton()
//        self.viewApprovalBtn.setCornerRadiusToView()
//        self.viewRejectedBtn.setCornerRadiusToView()
    }
    
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    @IBAction func tappedOnAccept(_sender: UIButton) {
        
        
    }
    
    @IBAction func tappedOnReject(_sender: UIButton) {
        
        
    }
    
}
