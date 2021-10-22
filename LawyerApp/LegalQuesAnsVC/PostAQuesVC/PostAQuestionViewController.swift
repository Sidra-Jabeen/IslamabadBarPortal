//
//  PostAQuestionViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class PostAQuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var descriptionBorderView: UIView!
    @IBOutlet weak var attachmentBorderView: UIView!
    @IBOutlet weak var writeSomethingView: UIView!
    @IBOutlet weak var uploadButnView: UIView!
    @IBOutlet weak var postQuesView: UIView!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPostAQuestion: UIButton!
    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var txtwriteSomething: UITextField!
    
    @IBOutlet weak var customCollection: UICollectionView!
    
    //MARK: - Variable
    
    var arrayForImages: [UIImage] = []
    var imagePicker = UIImagePickerController()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.borderView.setCornerRadiusToView()
        self.borderView.setBorderColorToView()
        self.descriptionBorderView.setCornerRadiusToView()
        self.descriptionBorderView.setBorderColorToView()
        self.uploadButnView.setCornerRadiusToView()
        self.attachmentBorderView.setBorderColorToView()
        self.attachmentBorderView.setCornerRadiusToView()
        self.writeSomethingView.setCornerRadiusToView()
//        self.postQuesView.setCornerRadiusToView()
        self.btnCancel.layer.cornerRadius = self.btnCancel.frame.size.height / 2
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
        
        self.imagePicker.delegate = self
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.customCollection.register(UINib(nibName: "UIAttachmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UIAttachmentCollectionViewCell")
    }
    
    //MARK: - IBAction
    
    @IBAction func tappedOnCancel( _sender: UIButton) {

        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    //MARK: - TableView Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = ((customCollection.frame.size.width / 3) - 15)
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.arrayForImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tmpCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIAttachmentCollectionViewCell", for: indexPath) as! UIAttachmentCollectionViewCell
        if indexPath.section == 0 {
            
            tmpCell.btnAdd.isHidden = false
            tmpCell.btnRemove.isHidden = true
            tmpCell.imgPostQuestion.image = UIImage(named: "camera")
            tmpCell.btnAdd.addTarget(self, action: #selector(onClickGetImage), for: .touchUpInside)
        } else {
            
            tmpCell.btnAdd.isHidden = true
            tmpCell.btnRemove.isHidden = false
            tmpCell.btnRemove.tag = indexPath.row
            tmpCell.imgPostQuestion.image = self.arrayForImages[indexPath.row]
            tmpCell.btnRemove.addTarget(self, action: #selector(onClickRemoveImage), for: .touchUpInside)
        }
        return tmpCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        self.arrayForImages.append(image)
        self.imagePicker.dismiss(animated: true)
        self.customCollection.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
    //MARK: - Others
    
    @objc func onClickGetImage(_ sender: UIButton) {
        
        if arrayForImages.count <= 5 {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func onClickRemoveImage(_ sender: UIButton) {
        
        self.arrayForImages.remove(at: sender.tag)
        self.customCollection.reloadData()
    }
}
