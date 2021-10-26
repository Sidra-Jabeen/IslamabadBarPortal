//
//  PostAttachmentViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 22/10/2021.
//

import UIKit
import AVKit
import MobileCoreServices

class PostAttachmentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate , UITextViewDelegate, UITextFieldDelegate {
    
    //MARK: - IBOutltes
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var viewAttachment: UIView!
    @IBOutlet weak var viewPostButton: UIView!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var lblTitleCount: UILabel!
    @IBOutlet weak var lblDescriptionCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var attachmentsCollection: UICollectionView!
    
    @IBOutlet weak var heightOfAnnounByView: NSLayoutConstraint!
    //MARK: - Propertities
    
    var bitForLisenceType = 0
    var arrayForMedia: [(UIImage, String)] = []
    var imagePicker = UIImagePickerController()
    var strTitle = ""
    var height = 0

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewTitle.setBorderColorToView()
        self.viewTitle.setCornerRadiusToView()
        
        self.viewDescription.setBorderColorToView()
        self.viewDescription.setCornerRadiusToView()
        
        self.viewAttachment.setBorderColorToView()
        self.viewAttachment.setCornerRadiusToView()
        
        self.viewPostButton.setCornerRadiusToView()
        
        self.txtTitle.delegate = self
        self.txtDescription.delegate = self
        self.updateCharacterCount()
        
//        self.lblTitle.text = self.strTitle
        self.heightOfAnnounByView.constant = CGFloat(self.height)
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.mediaTypes = ["public.image", "public.movie"]
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.attachmentsCollection.register(UINib(nibName: "UIAttachmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UIAttachmentCollectionViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.img1.image = UIImage(named: "Group 247")
        self.img2.image = UIImage(named: "Circle")
        self.img3.image = UIImage(named: "Circle")
    }
    
    //MARK: - HandGesturesFunction
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedOnDistrictLower( _sender: UIButton) {
        
        self.bitForLisenceType = 3
        self.img1.image = UIImage(named: "Group 247")
        self.img2.image = UIImage(named: "Circle")
        self.img3.image = UIImage(named: "Circle")
    }

    @IBAction func tappedOnDistrictHigh( _sender: UIButton) {
        
        self.bitForLisenceType = 2
        self.img1.image = UIImage(named: "Circle")
        self.img2.image = UIImage(named: "Group 247")
        self.img3.image = UIImage(named: "Circle")
    }
    
    @IBAction func tappedOnDistrictSupreme( _sender: UIButton) {
        
        self.bitForLisenceType = 1
        self.img1.image = UIImage(named: "Circle")
        self.img2.image = UIImage(named: "Circle")
        self.img3.image = UIImage(named: "Group 247")
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnUpload( _sender: UIButton) {
        
        if self.bitForLisenceType == 1 {
            
            self.callGetPostAnnouncementApi(type: 1)
            
        } else if self.bitForLisenceType == 2 {
            
            self.callGetPostAnnouncementApi(type: 2)
            
        } else if self.bitForLisenceType == 3 {
            
            self.callGetPostAnnouncementApi(type: 3)
            
        } else if self.strTitle == "General Announcements" {
            
            self.callGeneralPostAnnouncementApi()
        }
    }
    
    //MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = ((self.attachmentsCollection.frame.size.width / 3) - 10)
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + self.arrayForMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tmpCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIAttachmentCollectionViewCell", for: indexPath) as! UIAttachmentCollectionViewCell
        if indexPath.row == 0 {
            
            tmpCell.btnAdd.isHidden = false
            tmpCell.btnRemove.isHidden = true
            tmpCell.imgPostQuestion.image = UIImage(named: "add-image")
            tmpCell.btnAdd.addTarget(self, action: #selector(onClickGetImage), for: .touchUpInside)
        } else {
            
            tmpCell.btnAdd.isHidden = true
            tmpCell.btnRemove.isHidden = false
            tmpCell.btnRemove.tag = indexPath.row
            tmpCell.imgPostQuestion.image = self.arrayForMedia[indexPath.row - 1].0 //self.arrayForImages[indexPath.row - 1]
            tmpCell.btnRemove.addTarget(self, action: #selector(onClickRemoveImage), for: .touchUpInside)
        }
        return tmpCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - DocumentPicker Delegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        self.arrayForMedia.append((UIImage(named: "document")!, urls[0].absoluteString))
        self.attachmentsCollection.reloadData()
    }
    
    //MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let videoURL = info[.imageURL] as? URL
        print(videoURL?.pathExtension ?? "Error in url")
        if let videoURL = info[.mediaURL] as? URL {

            let thumbnailImage = self.generateThumbnail(videoUrl: videoURL.absoluteString)
            self.arrayForMedia.append((thumbnailImage!, videoURL.absoluteString))
        } else if let imageUrl = info[.imageURL] as? URL {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.arrayForMedia.append((image,  imageUrl.absoluteString))
        } else {
            
            if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType == (kUTTypeMovie as String), let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) {

                UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                let data = image.pngData()! as NSData
                
                let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                let localPath = documentDirectory?.appending("/\(self.getRandomNumber()).png")
                data.write(toFile: localPath!, atomically: true)

                let photoURL = URL.init(fileURLWithPath: localPath!)
                print(photoURL)
                self.arrayForMedia.append((image, photoURL.absoluteString))
            }
        }
        
        self.imagePicker.dismiss(animated: true)
        self.attachmentsCollection.reloadData()
    }
    
    func getRandomNumber() -> String{
        
        let timeStamp: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        return "\(timeStamp)"
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        
        let photoURL = URL.init(fileURLWithPath: videoPath)
        let thumbnailImage = self.generateThumbnail(videoUrl: photoURL.absoluteString)
        self.arrayForMedia.append((thumbnailImage!, videoPath))
        self.attachmentsCollection.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
    @objc private func didSaveVideo(videoPath: String, error: NSError, contextInfo: Any) {
        
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
//        if self.descTextView.text.isEmpty {
//            self.descTextView.text = "Enter description"
//            self.descTextView.textColor = UIColor.lightGray
//        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if(textView == self.txtDescription){
               return textView.text.count +  (text.count - range.length) <= 4000
            }
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
     }
    
    // MARK: - UITextViewDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let summaryCount = self.txtTitle.text?.count
        self.lblTitleCount.text = "\((0) + (summaryCount ?? 0))"
        if !(textField.text?.isEmpty ?? true){
            return textField.text!.count +  (string.count - range.length) <= 400
        }
        return true
    }
    
    // MARK: - Others

    func updateCharacterCount() {
        
        let summaryCount = self.txtDescription.text.count
        self.lblDescriptionCount.text = "\((0) + summaryCount)/4000"
    }
    
    //MARK: - Others
    
    @objc func onClickGetImage(_ sender: UIButton) {
        
        if arrayForMedia.count < 5 {
            self.showAlert()
        }
    }
    
    @objc func onClickRemoveImage(_ sender: UIButton) {
        
        self.arrayForMedia.remove(at: sender.tag - 1)
        self.attachmentsCollection.reloadData()
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Media Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in

            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Document file", style: .default, handler: {(action: UIAlertAction) in
            let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText), String(kUTTypeContent), String(kUTTypeItem), String(kUTTypeData)], in: .import)
            documentPicker.delegate = self
            self.present(documentPicker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func generateThumbnail(videoUrl: String) -> UIImage? {

        do {
            let url                                         = URL(string: videoUrl)
            let asset                                       = AVURLAsset(url: url!)
            let imageGenerator                              = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform   = true
            let cgImage                                     = try imageGenerator.copyCGImage(at: CMTime(seconds: 2.0, preferredTimescale: 60),
                                                                                             actualTime: nil)

            return UIImage(cgImage: cgImage)

        } catch {

            print(error.localizedDescription)
            return nil
        }
    }
    
    func generateThumbnail(for asset:AVAsset) -> UIImage? {
        
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 2)
        let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        if img != nil {
            let frameImg  = UIImage(cgImage: img!)
           return frameImg
        }
        return nil
    }
    
    fileprivate func getThumbnailFromUrl(_ url: URL, _ completion: @escaping ((_ image: UIImage?)->Void)) {

        DispatchQueue.main.async {
            let asset = AVAsset(url: url)
            let assetImgGenerate = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true

            let time = CMTimeMake(value: 2, timescale: 1)
            do {
                let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: img)
                completion(thumbnail)
            } catch {
                print("Error :: ", error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    //MARK: - CallingApiFunctions
    
    //MARK: - BarPostAttachment
    func callGetPostAnnouncementApi(type: Int) {
        
        
        if  Connectivity.isConnectedToInternet {
            if self.txtTitle.text != "" {
                if self.txtDescription.text != "" {
                    self.startAnimation()
                    let dataModel = PostAnnouncementRequestModel(source: "2", barAnnouncement: Announcement(title: self.txtTitle.text ?? "", description: self.txtDescription.text ?? "", type: "\(type)"))
                    let url = "api/BarAnnouncement/PostAnnouncement"
                    let services = AnnouncementServices()
                    services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                        let status = responseData.success ?? false
                        if status {
                            print("successssss")
                            let announceID = responseData.barAnnouncement?.barAnnouncementId
                            print(announceID ?? 0)
                            if self.arrayForMedia.count > 0 {
                                
                                self.uploadFiles(barId: "\(announceID ?? 0)", type: "1", index: 0)
                            }
                        } else {
                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                        }
                    }
                } else{
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Description should not be Empty!")
                }
            } else{
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Title should not be Empty!")
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    func uploadFiles(barId: String, type: String, index: Int) {
        
            if  Connectivity.isConnectedToInternet {
//                self.startAnimation()
                let attachmentModel = PostAttachmentFileRequestModel(attachmentFile: arrayForMedia[index].1)
                let dataModel = PostDataRequestModel(announcementId: barId, type: type)
                let url = "api/BarAnnouncement/PostAttachement"
                let services = AnnouncementServices()
                services.postUploadMethod(files: attachmentModel.params, urlString: url, dataModel: dataModel.params, completion: { (responseData) in
                    
                    let status = responseData.success
                    if status ?? false {
                        let index = index+1
                        if index < self.arrayForMedia.count {
                            self.uploadFiles(barId: barId, type: type, index: index)
                        } else {
                            self.stopAnimation()
                            let alert = UIAlertController(title: "Islmabad Bar Connect", message: responseData.desc ?? "", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else{
                        self.stopAnimation()
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "Error")
                    }
                    
                })
            } else {
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
            }
    }
    
    
    //MARK: - MemberPostAttachment
    
    func callGeneralPostAnnouncementApi() {
        
        if  Connectivity.isConnectedToInternet {
            if self.txtTitle.text != "" {
                if self.txtDescription.text != "" {
                    self.startAnimation()
                    let dataModel = GeneralPostAnnouncementRequestModel(source: "2", memberAnnouncement: MemberAnnouncements(title: self.txtTitle.text ?? "", description: self.txtDescription.text ?? ""))
                    let url = "api/MemberAnnouncement/PostAnnouncement"
                    let services = GeneralAnnouncementServices()
                    services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                        
//                        self.stopAnimation()
                        let status = responseData.success ?? false
                        if status {
                            print("successssss")
                            let memberID = responseData.memberAnnouncement?.memberAnnouncementId
                            print(memberID ?? 0)
                            if self.arrayForMedia.count > 0 {
                                
                                self.uploadGeneralFiles(barId: "\(memberID ?? 0)", type: "2", index: 0)
                            }
                        } else {
                            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                        }
                    }
                } else{
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Description should not be Empty!")
                }
            } else{
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Title should not be Empty!")
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    func uploadGeneralFiles(barId: String, type: String, index: Int) {
            if  Connectivity.isConnectedToInternet {
//                self.startAnimation()
                let attachmentModel = PostAttachmentFileRequestModel(attachmentFile: arrayForMedia[index].1)
                let dataModel = PostDataRequestModel(announcementId: barId, type: type)
                let url = "api/MemberAnnouncement/PostAttachement"
                let services = GeneralAnnouncementServices()
                services.postUploadMethod(files: attachmentModel.params, urlString: url, dataModel: dataModel.params, completion: { (responseData) in
                    
                    let status = responseData.success
                    if status ?? false {
                        let index = index+1
                        if index < self.arrayForMedia.count {
                            self.uploadGeneralFiles(barId: barId, type: type, index: index)
                        } else {
                            self.stopAnimation()
                            let alert = UIAlertController(title: "Islmabad Bar Connect", message: responseData.desc ?? "", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else{
                        self.stopAnimation()
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "Error")
                    }
                })
            } else {
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
            }
    }
    
}
