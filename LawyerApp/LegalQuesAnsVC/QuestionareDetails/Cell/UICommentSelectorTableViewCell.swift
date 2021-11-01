//
//  UICommentSelectorTableViewCell.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/25/21.
//

import UIKit

class UICommentSelectorTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnToday: UIButton!
    @IBOutlet weak var btnYesterday: UIButton!
    @IBOutlet weak var btnLastWeek: UIButton!
    
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var viewToday: UIView!
    @IBOutlet weak var viewYesterday: UIView!
    @IBOutlet weak var viewLastWeek: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
