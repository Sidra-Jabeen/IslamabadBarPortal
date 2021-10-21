//
//  AddOfficialDirectoryViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 21/10/2021.
//

import UIKit

class AddOfficialDirectoryViewController: UIViewController {
    
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var designationView: UIView!
    @IBOutlet weak var contactNumberView: UIView!
    @IBOutlet weak var officeAddressView: UIView!
    @IBOutlet weak var btnAddView: UIView!

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtOfficeAddress: UITextView!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
