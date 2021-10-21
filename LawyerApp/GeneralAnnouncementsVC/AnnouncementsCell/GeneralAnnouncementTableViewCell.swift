//
//  GeneralAnnouncementTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class GeneralAnnouncementTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var announcemementView: UIView!
    @IBOutlet weak var lblAnounceTitle: UILabel!
    @IBOutlet weak var lblAnounceBy: UILabel!
    @IBOutlet weak var lblAnounceAt: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.announcemementView.layer.shadowOffset = CGSize(width: 0,height: 0)
        self.announcemementView.layer.shadowColor = UIColor.black.cgColor
        self.announcemementView.layer.shadowOpacity = 0.25
        self.announcemementView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
