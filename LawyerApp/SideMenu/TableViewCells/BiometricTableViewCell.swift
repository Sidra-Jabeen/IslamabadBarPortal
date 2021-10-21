//
//  BiometricTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 19/10/2021.
//

import UIKit

class BiometricTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var bioSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
