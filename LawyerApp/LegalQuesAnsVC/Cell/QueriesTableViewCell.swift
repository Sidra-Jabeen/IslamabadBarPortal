//
//  QueriesTableViewCell.swift
//  LawyerApp
//
//  Created by Umair Yousaf on 15/10/2021.
//
protocol CustomCellUpdater {

    func updateTableView(comment:Int?)
}

import UIKit

class QueriesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var valid : Bool = false
    var delegate:CustomCellUpdater?
    
    @IBOutlet weak var viewReplyBtn: UIButton!
    var attachments : [CommentAttachment]?
    var commentss : CommentElement?
    
    @IBAction func switchAction(_ sender: UIButton) {
        
        print(viewReplyBtn.tag)
        
        delegate?.updateTableView(comment: viewReplyBtn.tag)

    }
    
    
    
    @IBOutlet weak var cellContent: UIView!
    @IBOutlet weak var fileHeight: NSLayoutConstraint!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var fileCollectionView: UICollectionView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraintCollection: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  print(attachments?.count)
        fileCollectionView.delegate = self
        fileCollectionView.dataSource = self
        self.fileCollectionView.register(UINib.init(nibName: "FileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FileCollectionViewCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(commentData:CommentElement){
        labelUserName.text = commentData.commentBy
        commentTextView.text = commentData.comment
        labelTime.text = commentData.commentAt
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = fileCollectionView.dequeueReusableCell(withReuseIdentifier: "FileCollectionViewCell", for: indexPath) as! FileCollectionViewCell
        let img = attachments![indexPath.row]
        cell.configure(data: img)
       // //cell.fileImageView.image = UIImage(named: attachments![indexPath.row].attachmentURL!)
        return cell
    }
    
    
}
