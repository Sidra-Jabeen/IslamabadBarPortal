//
//  QuestionAnswerTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class QuestionAnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion: SelectableLabel!
    @IBOutlet weak var lblAnswer: SelectableLabel!
    @IBOutlet weak var lblUsr: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTotalComments: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.shadowOffset = CGSize(width: 0,height: 0)
        self.mainView.layer.shadowColor = UIColor.black.cgColor
        self.mainView.layer.shadowOpacity = 0.25
        self.mainView.layer.shadowRadius = 4
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
