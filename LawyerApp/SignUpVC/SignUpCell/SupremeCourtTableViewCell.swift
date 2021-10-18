//
//  SupremeCourtTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import UIKit

class SupremeCourtTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtfield: UITextField!
    @IBOutlet weak var viewFirstName: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        self.viewFirstName.setCornerRadiusToView()
//        self.viewFirstName.setBorderColorToView()
    }
    
}
