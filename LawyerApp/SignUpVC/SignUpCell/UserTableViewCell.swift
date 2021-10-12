//
//  UserTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import DropDown

class UserTableViewCell: UITableViewCell, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, SignUpControllerDelegate {
    
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var txtInfo: UITextField!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txtfield: UITextField!
    
    let dropDown = DropDown()
    let dropDownValues = ["Issue Date of Lower Court","Issue Date of High Court","Issue Date of Supreme Court"]
    var imagePicker = UIImagePickerController()
    var values: String?
    let signup = SignUpViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.viewFirstName.setCornerRadiusToView()
        self.viewFirstName.setBorderColorToView()
        self.txtfield.delegate = self
        self.signup.delegate = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
//        self.clickedOnTextField()
        didSelectItem(txt: textField, view: self.signup)
        return true
    }
    
    func didSelectItem(txt: UITextField, view: UIViewController) {
        
        if self.values == "text" {
            
            txt.keyboardType = .alphabet
        }
        else if self.values == "number" {
            
            txt.keyboardType = .numberPad
        }
        else if self.values == "calender" {
            
            txt.keyboardType = .numberPad
        }
        else if self.values == "photo library" {
            txt.isEnabled = false
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                view.present(imagePicker, animated: true, completion: nil)
            }
        } else if self.values == "dropdown" {
            self.txtfield.isEnabled = false
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
    
    func clickedOnTextField() {
        
        if self.values == "text" {
            
            self.txtfield.keyboardType = .alphabet
        }
        else if self.values == "number" {
            
            self.txtfield.keyboardType = .numberPad
        }
        else if self.values == "calender" {
            
            self.txtfield.keyboardType = .numberPad
        }
        else if self.values == "calender" {
            
            self.txtfield.keyboardType = .numberPad
        }
        else if self.values == "photo library" {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//                self.present(imagePicker, animated: true, completion: nil)
            }
        } else if self.values == "dropdown" {
            
//            btnGender.setTitle("Select Gender", for: .normal)
            self.txtfield.placeholder = "Select"
            dropDown.anchorView = self.txtfield
            dropDown.dataSource = dropDownValues
            dropDown.direction = .bottom
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
//                self.gender = item
//                self.btnGender.setTitle(self.dropDownValues[index], for: .normal)
                self.dropDown.hide()
            }
            dropDown.show()
            
        }
    }
}

