//
//  MemberCollectionViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.profileImage.layer.cornerRadius = 25
//        self.profileImage.layer.masksToBounds = false
//        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
//        self.profileImage.clipsToBounds = true
        self.profileImage.applyCircledView()
    }

}
