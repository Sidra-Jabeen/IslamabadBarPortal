//
//  PostAQuestionViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import AVKit
import MobileCoreServices

protocol BackToQuestionVC {
    
    func callGetQuestionsApi()
}

class PostAQuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextViewDelegate, UITextFieldDelegate  {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var descriptionBorderView: UIView!
    @IBOutlet weak var attachmentBorderView: UIView!
    @IBOutlet weak var writeSomethingView: UIView!
    @IBOutlet weak var uploadButnView: UIView!
    @IBOutlet weak var postQuesView: UIView!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPostAQuestion: UIButton!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    
    @IBOutlet weak var lblTitleCount: UILabel!
    @IBOutlet weak var lblDescriptionCount: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var customCollection: UICollectionView!
    
    //MARK: - Variable
    
    var arrayForMedia: [(UIImage, String)] = []
//    var arrayForImages: [UIImage] = []
    var imagePicker = UIImagePickerController()
    public var delegate: BackToQuestionVC?
    
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
        
        self.txtTitle.delegate = self
        self.txtDescription.delegate = self
        self.updateCharacterCount()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.mediaTypes = ["public.image", "public.movie"]
        self.imagePicker.modalPresentationStyle = .fullScreen
        self.customCollection.register(UINib(nibName: "UIAttachmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UIAttachmentCollectionViewCell")
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnUpload( _sender: UIButton) {
        
        self.callGetPostQuestionApi()
    }
    
    
    //MARK: - TableView Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = ((customCollection.frame.size.width / 3) - 10)
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
            tmpCell.btnCancel.isHidden = true
            tmpCell.imgPostQuestion.image = UIImage(named: "add-image")
            tmpCell.btnAdd.addTarget(self, action: #selector(onClickGetImage), for: .touchUpInside)
        } else {
            
            tmpCell.btnAdd.isHidden = true
            tmpCell.btnCancel.isHidden = false
            tmpCell.btnCancel.tag = indexPath.row
            tmpCell.imgPostQuestion.image = self.arrayForMedia[indexPath.row - 1].0 //self.arrayForImages[indexPath.row - 1]
            tmpCell.btnCancel.addTarget(self, action: #selector(onClickRemoveImage), for: .touchUpInside)
        }
        return tmpCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: - DocumentPicker Delegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        self.arrayForMedia.append((UIImage(named: "document")!, urls[0].absoluteString))
        self.customCollection.reloadData()
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
        self.customCollection.reloadData()
    }
    
    func getRandomNumber() -> String{
        
        let timeStamp: NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        return "\(timeStamp)"
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    
    @objc private func didSaveVideo(videoPath: String, error: NSError, contextInfo: Any) {
        
    }
    
    //MARK: - Others

    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        
        let photoURL = URL.init(fileURLWithPath: videoPath)
        let thumbnailImage = self.generateThumbnail(videoUrl: photoURL.absoluteString)
        self.arrayForMedia.append((thumbnailImage!, videoPath))
        self.customCollection.reloadData()
    }
    
    @objc func onClickGetImage(_ sender: UIButton) {
        
        if arrayForMedia.count < 5 {
            self.showAlert()
        }
    }
    
    @objc func onClickRemoveImage(_ sender: UIButton) {
        
        self.arrayForMedia.remove(at: sender.tag - 1)
        self.customCollection.reloadData()
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
    
    func updateCharacterCount() {
        
        let summaryCount = self.txtDescription.text.count
        self.lblDescriptionCount.text = "\((0) + summaryCount)/4000"
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
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
    
    //MARK: - CallingApiFunction
    
    func callGetPostQuestionApi() {
        
        if  Connectivity.isConnectedToInternet {
            if self.txtTitle.text != "" {
                if self.txtDescription.text != "" {
                    self.startAnimation()
                    let dataModel = PostQuestionRequestModel(source: "2", question: Question(title: self.txtTitle.text ?? "", description: self.txtDescription.text ?? ""))
                    let url = Constant.postQuestionEP
                    let services = PostQuestionsServices()
                    services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                        let status = responseData.success ?? false
                        if status {
                            print("successssss")
                            let quesID = responseData.question?.id
                            print(quesID ?? 0)
                            if self.arrayForMedia.count > 0 {
                                
                                self.uploadFiles(quesId: "\(quesID ?? 0)", type: "1", index: 0)
                            }
                        } else {
                            let alert = UIAlertController(title: "Islamabad Bar Connect", message: responseData.desc ?? "", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
                                self.delegate?.callGetQuestionsApi()
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
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
    
    func uploadFiles(quesId: String, type: String, index: Int) {
        
            if  Connectivity.isConnectedToInternet {
//                self.startAnimation()
                let attachmentModel = QuestionPostAttachmentRequestModel(attachmentFile: arrayForMedia[index].1)
                let dataModel = QuestionPostDataRequestModel(questionId: quesId, type: type)
                let url = Constant.quesPostAttachmentEP
                let services = PostQuestionsServices()
                services.postUploadMethod(files: attachmentModel.params, urlString: url, dataModel: dataModel.params, completion: { (responseData) in
                    
                    let status = responseData.success
                    if status ?? false {
                        let index = index+1
                        if index < self.arrayForMedia.count {
                            self.uploadFiles(quesId: quesId, type: type, index: index)
                        } else {
                            self.stopAnimation()
                            let alert = UIAlertController(title: "Islamabad Bar Connect", message: responseData.desc ?? "", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
                                self.delegate?.callGetQuestionsApi()
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
