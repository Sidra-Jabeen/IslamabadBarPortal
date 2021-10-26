//
//  UIQuestionAttachmentTableViewCell.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/25/21.
//

import UIKit
import Stevia

class UIQuestionAttachmentTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var scrollForSelectdContact: UIScrollView!
    
    //MARK: - Variable
    
    var arrayForAddContactController: [UIAttachmentSubViewController] = []
    var arrayForGroup: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config() {
        
        if arrayForAddContactController.count > 0 {
            arrayForAddContactController.forEach { $0.view.removeFromSuperview() }
            arrayForAddContactController.removeAll()
        }
        
        var newItemViewController: UIAttachmentSubViewController!
        var prevItemViewController: UIAttachmentSubViewController?
        for i in 0..<5 {//self.arrayForGroup.count
            
            newItemViewController = UIAttachmentSubViewController()
            scrollForSelectdContact.addSubview(newItemViewController)
            arrayForAddContactController.append(newItemViewController)
            newItemViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            newItemViewController.view.Width == scrollForSelectdContact.Height
            newItemViewController.view.Top == scrollForSelectdContact.Top
            newItemViewController.view.Height == scrollForSelectdContact.Height
            if let contorller = prevItemViewController {
                newItemViewController.view.Leading == contorller.view.Trailing + 10
            } else {
                newItemViewController.view.Leading == scrollForSelectdContact.Leading + 0
            }
            prevItemViewController = newItemViewController
        }
        
        if newItemViewController != nil {
            newItemViewController.view.Trailing == scrollForSelectdContact.Trailing - 10
        }
    }
    
}
