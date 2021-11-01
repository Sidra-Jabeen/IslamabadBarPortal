//
//  QuestionAnswerTableViewCell.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class QuestionAnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblUsr: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTotalComments: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(data: QuesResponseModel) {
        
        self.lblUsr.text = data.postedBy
        self.lblTime.text = data.postedAt
        self.lblAnswer.text = data.description
        self.lblQuestion.text = data.title
        self.lblTotalComments.text = data.totalComments
    }
    
}
