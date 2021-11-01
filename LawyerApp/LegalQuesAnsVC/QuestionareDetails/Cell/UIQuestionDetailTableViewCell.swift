//
//  UIQuestionDetailTableViewCell.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/25/21.
//

import UIKit

class UIQuestionDetailTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPostedAt: UILabel!
    @IBOutlet weak var lblPostedBy: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
