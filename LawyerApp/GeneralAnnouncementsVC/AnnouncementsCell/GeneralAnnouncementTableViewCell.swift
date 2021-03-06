//
//  GeneralAnnouncementTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class GeneralAnnouncementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var announcemementView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        self.announcemementView.layer.shadowOffset = CGSize(width: 0,height: 0)
        self.announcemementView.layer.shadowColor = UIColor.black.cgColor
        self.announcemementView.layer.shadowOpacity = 0.25
        self.announcemementView.layer.shadowRadius = 4
    }
    
}
