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

    var approveUsersArray = [String]()
    var tblApprovals: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnCancel.layer.cornerRadius = self.btnCancel.frame.size.height / 2
        self.centerView.setCornerRadiusToView()
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        self.tblApprovals?.reloadData()
    }

    @IBAction func tappedOnBlockUser(_sender: UIButton) {
        
        
    }
    
}
