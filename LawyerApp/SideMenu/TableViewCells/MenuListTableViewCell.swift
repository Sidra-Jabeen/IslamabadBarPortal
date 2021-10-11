//
//  MenuListTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMenuItem: UIImageView!
    @IBOutlet weak var lblMenuItem: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
