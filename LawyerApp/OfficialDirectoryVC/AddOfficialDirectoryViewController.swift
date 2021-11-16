//
//  AddOfficialDirectoryViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 21/10/2021.
//

import UIKit

class AddOfficialDirectoryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var designationView: UIView!
    @IBOutlet weak var contactNumberView: UIView!
    @IBOutlet weak var officeAddressView: UIView!
    @IBOutlet weak var btnAddView: UIView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtOfficeAddress: UITextView!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnCancel.applyCircledViewToButttons()
        
        self.btnAddView.setCornerRadiusToView()
        self.contentView.setCornerRadiusToView()
        
        self.fullNameView.setCornerRadiusToView()
        self.fullNameView.setBorderColorToView()
        
        self.designationView.setCornerRadiusToView()
        self.designationView.setBorderColorToView()
        
        self.contactNumberView.setCornerRadiusToView()
        self.contactNumberView.setBorderColorToView()
        
        self.officeAddressView.setCornerRadiusToView()
        self.officeAddressView.setBorderColorToView()
        
        self.txtContactNumber.keyboardType = .numberPad
        self.txtContactNumber.delegate = self
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    //MARK: - TouchScreenFunction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           let touch = touches.first
           if touch?.view != self.contentView
           { self.dismiss(animated: true, completion: nil) }
       }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtContactNumber  {
            
            let maxLength = 11
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        return true
    }

}
