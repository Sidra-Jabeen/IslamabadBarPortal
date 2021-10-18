//
//  PostAnnouncementViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 16/10/2021.
//

import UIKit

class PostAnnouncementViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var titleBorderView: UIView!
    @IBOutlet weak var descBorderView: UIView!
    @IBOutlet weak var btnUploadView: UIView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var txtEnterTitle: UITextField!
    @IBOutlet weak var lblTitleCount: UILabel!
    @IBOutlet weak var lblDescriptionCount: UILabel!
    @IBOutlet weak var mainPostView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnCancel.layer.cornerRadius = self.btnCancel.frame.size.height / 2
        self.navigationController?.isNavigationBarHidden = true
        
        self.titleBorderView.setCornerRadiusToView()
        self.titleBorderView.setBorderColorToView()
        
        self.descBorderView.setCornerRadiusToView()
        self.descBorderView.setBorderColorToView()
        
        self.btnUpload.setCornerRadiusToButton()
        self.btnUploadView.setCornerRadiusToView()
        
        self.mainPostView.setCornerRadiusToView()
        
//        self.titleTextView.delegate = self
        self.txtEnterTitle.delegate = self
        self.descTextView.delegate = self
        
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
        
//        self.titleTextView.text = "Enter Title"
//        self.titleTextView.textColor = UIColor.lightGray
    
//        self.descTextView.text = "Enter description"
//        self.descTextView.textColor = UIColor.lightGray
        
        self.updateCharacterCount()
    }

    func updateCharacterCount() {
        
        let summaryCount = self.descTextView.text.count
        self.lblDescriptionCount.text = "\((0) + summaryCount)/4000"
    }
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
       
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
//        if self.descTextView.text.isEmpty {
//            self.descTextView.text = "Enter description"
//            self.descTextView.textColor = UIColor.lightGray
//        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if(textView == self.descTextView){
               return textView.text.count +  (text.count - range.length) <= 4000
            }
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
     }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let summaryCount = self.txtEnterTitle.text?.count
        self.lblTitleCount.text = "\((0) + (summaryCount ?? 0))"
        if !(textField.text?.isEmpty ?? true){
                    return textField.text!.count +  (string.count - range.length) <= 400
                }
                return true
//        self.lblTitleCount.text = newString
    }
    
    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        
//        let summaryCount = self.txtEnterTitle.text?.count
//        self.lblTitleCount.text = "\((0) + (summaryCount ?? 0))/400"
//    }
    
    
    // MARK: - Navigation
}
