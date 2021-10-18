//
//  MembersOfIslamabadTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import UIKit

class MembersOfIslamabadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtfield: UITextField!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    

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
