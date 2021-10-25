//
//  PostAQuestionViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import AVKit
import MobileCoreServices

class PostAQuestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate {
    
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
    
    var arrayForMedia: [(UIImage, String)] = []
//    var arrayForImages: [UIImage] = []
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
        self.imagePicker.allowsEditing = true
        self.imagePicker.mediaTypes = ["public.image", "public.movie"]
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
        self.customCollection.reloadData()
    }
    
    //MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let videoURL = info[.imageURL] as? URL
        print(videoURL?.pathExtension ?? "Error in url")
        
        
//        let videoURL = info[.imageURL] as? NSURL
//        let filename = videoURL?.lastPathComponent
//
//        if videoURL != nil {
//            if videoURL?.pathExtension == "MOV" {
//                //                self.getThumbnailFromUrl(videoURL! as URL, { image in
//                //                    guard let url = videoURL?.absoluteString else { return }
//                //                    self.arrayForMedia.append((image!, url))
//                //                })
//                let thumbnailImage = self.generateThumbnail(videoUrl: videoURL!.absoluteString ?? "")
//                guard let url = videoURL?.absoluteString else { return }
//                self.arrayForMedia.append((thumbnailImage!, url))
//                //                self.generateThumbnail(for: <#T##AVAsset#>)
//            } else {
//                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//                guard let url = videoURL?.absoluteString else { return }
//                self.arrayForMedia.append((image, url))
//            }
//        } else {
//            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//            let data = image.pngData()! as NSData
//
//            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//            let localPath = documentDirectory?.appending("\(Date())")
//            data.write(toFile: localPath!, atomically: true)
//
//            let photoURL = URL.init(fileURLWithPath: localPath!)
//            print(photoURL)
//            //                self.arrayForMedia.append((image, videoURL?.absoluteString))
//        }
//
//        self.imagePicker.dismiss(animated: true)
//        self.attachmentsCollection.reloadData()
        
        
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
                let localPath = documentDirectory?.appending("/\(Date()).png")
                data.write(toFile: localPath!, atomically: true)

                let photoURL = URL.init(fileURLWithPath: localPath!)
                print(photoURL)
                self.arrayForMedia.append((image, photoURL.absoluteString))
            }
        }
        
        self.imagePicker.dismiss(animated: true)
        self.customCollection.reloadData()
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
}
