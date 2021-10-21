//
//  OfficialDirectoryTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class OfficialDirectoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnphone: UIButton!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var lblContactNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.btnphone.layer.cornerRadius = self.btnphone.frame.size.height / 2
    }
    
}
