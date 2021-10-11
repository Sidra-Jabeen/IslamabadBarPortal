//
//  UserTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var txtInfo: UITextField!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var btn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.viewFirstName.setCornerRadiusToView()
        self.viewFirstName.setBorderColorToView()
    }
    
}
