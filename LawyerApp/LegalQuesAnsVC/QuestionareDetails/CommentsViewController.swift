//
//  CommentsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - IBOutlet
    @IBOutlet weak var customTableView: UITableView!
    
    //MARK: - Variable
    
    var arrayQuestionAttachment: [(String, Bool)] = [("",false)]
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customTableView.register(UINib(nibName: "UIQuestionDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "UIQuestionDetailTableViewCell")
        self.customTableView.register(UINib(nibName: "UIQuestionAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "UIQuestionAttachmentTableViewCell")
        self.customTableView.register(UINib(nibName: "UICommentSelectorTableViewCell", bundle: nil), forCellReuseIdentifier: "UICommentSelectorTableViewCell")
        self.customTableView.register(UINib(nibName: "QueriesTableViewCell", bundle: nil), forCellReuseIdentifier: "QueriesTableViewCell")
    }
    
    //MARK: - IBAction

    @IBAction func onBackNavigation(_sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 145
        } else if indexPath.section == 1 {
            return 125//self.arrayQuestionAttachment.count > 0 ? 125 : 0
        } else if indexPath.section == 2 {
            return 40
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 && self.arrayQuestionAttachment[section - 3].1 ? self.arrayQuestionAttachment.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UIQuestionDetailTableViewCell", for: indexPath) as! UIQuestionDetailTableViewCell
            tmpCell.selectionStyle = .none
            return tmpCell
        } else if indexPath.section == 1 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UIQuestionAttachmentTableViewCell", for: indexPath) as! UIQuestionAttachmentTableViewCell
            tmpCell.config()
            tmpCell.selectionStyle = .none
            return tmpCell
        } else if indexPath.section == 2 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UICommentSelectorTableViewCell", for: indexPath) as! UICommentSelectorTableViewCell
            tmpCell.selectionStyle = .none
            return tmpCell
        } else {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "QueriesTableViewCell", for: indexPath) as! QueriesTableViewCell
            tmpCell.cellDelegate = self
            tmpCell.selectionStyle = .none
            tmpCell.viewReplyBtn.isHidden = true
            tmpCell.config()
            
            if indexPath.row == 0 {
                
                tmpCell.leadingConst.constant = 20
                tmpCell.viewReplyBtn.isHidden = false
                tmpCell.viewReplyBtn.tag = indexPath.section - 3
                tmpCell.viewReplyBtn.setTitle(self.arrayQuestionAttachment[indexPath.section - 3].1 ? "Hide Replies" : "View Replies", for: .normal)
                tmpCell.viewReplyBtn.addTarget(self, action: #selector(onClickShowHideReply(_:)), for: .touchUpInside)
                return tmpCell
            }
            
            tmpCell.leadingConst.constant = 75
            return tmpCell
        }
    }
    
    //MARK: - Others
    
    @objc func onClickShowHideReply(_ sender: UIButton) {
        
        self.arrayQuestionAttachment[sender.tag].1 = !self.arrayQuestionAttachment[sender.tag].1
        self.customTableView.reloadData()
    }
    
}

extension CommentsViewController: GrowingCellProtocol {
    
    func updateHeightOfRow(_ cell: QueriesTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = customTableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            customTableView?.beginUpdates()
            customTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = customTableView.indexPath(for: cell) {
                customTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
