//
//  UIAttachmentCollectionViewCell.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/22/21.
//

import UIKit

class UIAttachmentCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var imgPostQuestion: UIImageView!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnAdd.setTitle("", for: .normal)
//        self.btnRemove.setTitle("", for: .normal)
//        self.btnRemove.setImage(UIImage(named: "remove"), for: .normal)
    }

}
