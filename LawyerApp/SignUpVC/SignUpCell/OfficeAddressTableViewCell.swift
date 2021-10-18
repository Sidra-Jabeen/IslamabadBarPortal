//
//  OfficeAddressTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import UIKit

class OfficeAddressTableViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var txtview: UITextView!
    @IBOutlet weak var viewFirstName: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.txtview.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.viewFirstName.setCornerRadiusToView()
        self.viewFirstName.setBorderColorToView()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if self.txtview.text.isEmpty {
            self.txtview.text = "Enter Office Address"
            self.txtview.textColor = UIColor.lightGray
        }
    }
}
