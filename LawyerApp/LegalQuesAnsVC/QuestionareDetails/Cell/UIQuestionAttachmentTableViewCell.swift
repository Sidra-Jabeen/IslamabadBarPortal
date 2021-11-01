//
//  UIQuestionAttachmentTableViewCell.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/25/21.
//

import UIKit
import Stevia

class UIQuestionAttachmentTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var customCollection: UICollectionView!
    
    //MARK: - Variable
    
    var arrayForAttachments: [QuestionareAttachment] = []
    var arrayForGroup: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.customCollection.register(UINib(nibName: "UIAttachmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UIAttachmentCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - CollectionView delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayForAttachments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tmpCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIAttachmentCollectionViewCell", for: indexPath) as! UIAttachmentCollectionViewCell
            
        tmpCell.btnAdd.isHidden = false
        tmpCell.btnRemove.isHidden = true
        tmpCell.btnRemove.tag = indexPath.row
        if let imageUrl = URL(string: "\(Constant.imageDownloadURL)\(self.arrayForAttachments[indexPath.row ].attachmentUrl ?? "")" ) {
            tmpCell.imgPostQuestion.kf.setImage(with: imageUrl, placeholder: UIImage(named: "empty"))
        } else {
            tmpCell.imgPostQuestion.image = UIImage(named: "no_image_placeholder")
        }
//            tmpCell.btnAdd.addTarget(self, action: #selector(onClickRemoveImage), for: .touchUpInside)
        return tmpCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func config() {
        self.customCollection.reloadData()
//
//        if arrayForAddContactController.count > 0 {
//            arrayForAddContactController.forEach { $0.view.removeFromSuperview() }
//            arrayForAddContactController.removeAll()
//        }
//
//        var newItemViewController: UIAttachmentSubViewController!
//        var prevItemViewController: UIAttachmentSubViewController?
//        for _ in 0..<5 {//self.arrayForGroup.count
//
//            newItemViewController = UIAttachmentSubViewController()
//            scrollForSelectdContact.addSubview(newItemViewController)
//            arrayForAddContactController.append(newItemViewController)
//            newItemViewController.view.translatesAutoresizingMaskIntoConstraints = false
//
//            newItemViewController.view.Width == scrollForSelectdContact.Height
//            newItemViewController.view.Top == scrollForSelectdContact.Top
//            newItemViewController.view.Height == scrollForSelectdContact.Height
//            if let contorller = prevItemViewController {
//                newItemViewController.view.Leading == contorller.view.Trailing + 10
//            } else {
//                newItemViewController.view.Leading == scrollForSelectdContact.Leading + 0
//            }
//            prevItemViewController = newItemViewController
//        }
//
//        if newItemViewController != nil {
//            newItemViewController.view.Trailing == scrollForSelectdContact.Trailing - 10
//        }
    }
    
}
