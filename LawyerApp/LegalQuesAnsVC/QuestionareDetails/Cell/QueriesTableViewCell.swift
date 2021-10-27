//
//  QueriesTableViewCell.swift
//  LawyerApp
//
//  Created by Umair Yousaf on 15/10/2021.
//

protocol CustomCellUpdater {
    func updateTableView(comment:Int?)
}

protocol GrowingCellProtocol: AnyObject {
    func updateHeightOfRow(_ cell: QueriesTableViewCell, _ textView: UITextView)
}

import UIKit
import Stevia

class QueriesTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var viewReplyBtn: UIButton!
    @IBOutlet weak var scrollForSelectdContact: UIScrollView!
    @IBOutlet weak var cellContent: UIView!
    @IBOutlet weak var fileHeight: NSLayoutConstraint!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintCollection: NSLayoutConstraint!
    
    //MARK: - Variable
    
    var valid : Bool = false
    var delegate:CustomCellUpdater?
    weak var cellDelegate: GrowingCellProtocol?
//    var attachments : [CommentAttachment]?
//    var commentss : CommentElement?
    var arrayForAddContactController: [UIAttachmentSubViewController] = []
    var arrayForGroup: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func switchAction(_ sender: UIButton) {
        
        print(viewReplyBtn.tag)
        delegate?.updateTableView(comment: viewReplyBtn.tag)
    }
    
//    func configure(commentData:CommentElement){
//        labelUserName.text = commentData.commentBy
//        commentTextView.text = commentData.comment
//        labelTime.text = commentData.commentAt
//        
//    }
    
    func config() {
        
        if arrayForAddContactController.count > 0 {
            arrayForAddContactController.forEach { $0.view.removeFromSuperview() }
            arrayForAddContactController.removeAll()
        }
        
        var newItemViewController: UIAttachmentSubViewController!
        var prevItemViewController: UIAttachmentSubViewController?
        for _ in 0..<5 {//self.arrayForGroup.count
            
            newItemViewController = UIAttachmentSubViewController()
            scrollForSelectdContact.addSubview(newItemViewController)
            arrayForAddContactController.append(newItemViewController)
            newItemViewController.view.translatesAutoresizingMaskIntoConstraints = false
            scrollForSelectdContact.Height == 70
            newItemViewController.view.Width == 70
            newItemViewController.view.Top == scrollForSelectdContact.Top
            newItemViewController.view.Height == scrollForSelectdContact.Height
            if let contorller = prevItemViewController {
                newItemViewController.view.Leading == contorller.view.Trailing + 5
            } else {
                newItemViewController.view.Leading == scrollForSelectdContact.Leading + 0
            }
            prevItemViewController = newItemViewController
        }
        
        if newItemViewController != nil {
            newItemViewController.view.Trailing == scrollForSelectdContact.Trailing - 5
        }
    }
}

extension QueriesTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let deletate = cellDelegate {
            deletate.updateHeightOfRow(self, textView)
        }
    }
}
