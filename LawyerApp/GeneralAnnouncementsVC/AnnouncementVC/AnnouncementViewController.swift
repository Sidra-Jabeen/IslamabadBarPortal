//
//  AnnouncementViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import QuickLook

class PreviewItem: NSObject, QLPreviewItem {
    var previewItemURL: URL?
}

class AnnouncementViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QLPreviewControllerDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var lblAnnounceBy: UILabel!
    @IBOutlet weak var lbAnnounceAt: UILabel!
    @IBOutlet weak var lblBarTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var attachmentsCollection: UICollectionView!
    
    //MARK: - Propertities
    
    var strtitle: String?
    var strdescription: String?
    var anouncedBy: String?
    var anouncedAt: String?
    var barTitle: String?
    var userId: Int?
    var bitValue = false
    var arrAttachmentResponse = [AttachmentResponse]()
    let previewController = QLPreviewController()
    var previewItems: [PreviewItem] = []
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblBarTitle.text = self.barTitle
        
        self.attachmentsCollection.register(UINib(nibName: "UIAttachmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UIAttachmentCollectionViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        intForSearchFilter = nil
        intForSetAscDes = nil
        self.callGetAnnouncementDetailApi()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    //MARK: - HandGestures Function
    
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

    @IBAction func tappedOnBack(_sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
        return self.arrAttachmentResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let tmpCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIAttachmentCollectionViewCell", for: indexPath) as! UIAttachmentCollectionViewCell
        
        let strURL = self.arrAttachmentResponse[indexPath.row].attachmentUrl ?? ""
        if strURL.contains(".pdf") {
//            let url = URL(string: "\(Constant.imageDownloadURL)\(strURL)")
            tmpCell.imgPostQuestion.image = UIImage(named: "document")
//            tmpCell.imgPostQuestion.kf.setImage(with: url, placeholder: UIImage(named: "document"))
        } else {
            let url = URL(string: "\(Constant.imageDownloadURL)\(strURL)")
            tmpCell.imgPostQuestion.kf.setImage(with: url, placeholder: UIImage(named: "empty"))
        }
        
        tmpCell.btnAdd.isHidden = true
        tmpCell.btnRemove.isHidden = true
//            tmpCell.btnRemove.tag = indexPath.row
        //self.arrayForImages[indexPath.row - 1]
//            tmpCell.btnRemove.addTarget(self, action: #selector(onClickRemoveImage), for: .touchUpInside)
        return tmpCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let quickLookViewController = QLPreviewController()
        quickLookViewController.dataSource = self
        quickLookViewController.currentPreviewItemIndex = indexPath.item
        present(quickLookViewController, animated: true)

//        let strURL = self.arrAttachmentResponse[indexPath.row].attachmentUrl
//        let url = URL(string: "\(Constant.imageDownloadURL)\(strURL ?? "")")!
//        quickLook(url: url)
    }
    
    func quickLook(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                //  in case of failure to download your data you need to present alert to the user
                self.presentAlertController(with: error?.localizedDescription ?? "Failed to download the pdf!!!")
                return
            }
            // you neeed to check if the downloaded data is a valid pdf
            guard
                let httpURLResponse = response as? HTTPURLResponse
//                let mimeType = httpURLResponse.mimeType,
//                mimeType.hasSuffix("pdf")
            else {
//                print((response as? HTTPURLResponse)?.mimeType ?? "")
//                self.presentAlertController(with: "the data downloaded it is not a valid pdf file")
                return
            }
            do {
                // rename the temporary file or save it to the document or library directory if you want to keep the file
                let suggestedFilename = httpURLResponse.suggestedFilename
                var previewURL = FileManager.default.temporaryDirectory.appendingPathComponent(suggestedFilename ?? "")
                try data.write(to: previewURL, options: .atomic)   // atomic option overwrites it if needed
                previewURL.hasHiddenExtension = true
                let previewItem = PreviewItem()
                previewItem.previewItemURL = previewURL
                self.previewItems.append(previewItem)
                print(self.previewItems)
//                DispatchQueue.main.async {
////                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                    self.previewController.delegate = self
//                    self.previewController.dataSource = self
//                    self.previewController.currentPreviewItemIndex = 0
//                    self.present(self.previewController, animated: true)
//                 }
            } catch {
                print(error)
                return
            }
        }.resume()
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func presentAlertController(with message: String) {
         // present your alert controller from the main thread
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    
    //MARK: - CallingApiFunction
    
    func callGetAnnouncementDetailApi() {
        
        if self.bitValue {
            
            if  Connectivity.isConnectedToInternet {
                self.startAnimation()
                let dataModel = GeneralAnnouncementDetailsRequestModel(source: "2", memberAnnouncement: GeneralAnnouncementDetails(memberAnnouncementId: self.userId ?? 0))
                let url = Constant.memGetAnnounceDetailsEP
                let services = GeneralAnnouncementDetailServices()
                services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                    
                    self.stopAnimation()
                    let status = responseData.success ?? false
                    if status {
                        self.lblTitle.text = responseData.memberAnnouncement?.title
                        self.txtDesc.text = responseData.memberAnnouncement?.description
                        self.lbAnnounceAt.text = responseData.memberAnnouncement?.announcedAt
                        self.lblAnnounceBy.text = responseData.memberAnnouncement?.announcedBy
                        let strURL = responseData.memberAnnouncement?.announcedByProfile
                        let url = URL(string: "\(Constant.imageDownloadURL)\(strURL ?? "")")
                        self.imgProfile.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
                        self.arrAttachmentResponse = responseData.memberAnnouncement?.attachments ?? []
                        print(self.arrAttachmentResponse)
                        self.previewItems.removeAll()
                        for item in self.arrAttachmentResponse {
                            if let url = URL(string: "\(Constant.imageDownloadURL)\(item.attachmentUrl ?? "")") {
                                
                                self.quickLook(url: url)
                            }
                        }
                        self.attachmentsCollection.reloadData()
                        
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    }
                }
            } else {
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
            }
        }
        else {
            
            if  Connectivity.isConnectedToInternet {
                self.startAnimation()
                let dataModel = AnnouncementDetailsRequestModel(source: "2", barAnnouncement: Details(barAnnouncementId: self.userId ?? 0))
                let url = Constant.barGetAnnounceDetailsEP
                let services = BarAnnouncementDetailServices()
                services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                    
                    self.stopAnimation()
                    let status = responseData.success ?? false
                    if status {
                        self.lblTitle.text = responseData.barAnnouncement?.title
                        self.txtDesc.text = responseData.barAnnouncement?.description
                        self.lbAnnounceAt.text = responseData.barAnnouncement?.announcedAt
                        self.lblAnnounceBy.text = responseData.barAnnouncement?.announcedBy
                        let strURL = responseData.barAnnouncement?.announcedByProfile
                        let url = URL(string: "\(Constant.imageDownloadURL)\(strURL ?? "")")
                        self.imgProfile.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
                        self.arrAttachmentResponse = responseData.barAnnouncement?.attachments ?? []
                        print(self.arrAttachmentResponse)
                        for item in self.arrAttachmentResponse {
                            if let url = URL(string: "\(Constant.imageDownloadURL)\(item.attachmentUrl ?? "")") {
                                
                                self.quickLook(url: url)
                            }
                        }
                        self.attachmentsCollection.reloadData()
                    } else {
                        self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    }
                }
            } else {
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
            }
        }


    }
    
}

// MARK: - QLPreviewControllerDataSource
extension AnnouncementViewController: QLPreviewControllerDataSource {
  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
      self.previewItems.count
  }
    

  func previewController(
    _ controller: QLPreviewController,
    previewItemAt index: Int
  ) -> QLPreviewItem {
//      let url =
//      self.arrAttachmentResponse[index].attachmentUrl as NSURL
      self.previewItems[index]
//      let strURL = self.arrAttachmentResponse[index].attachmentUrl
//      return URL(string: "\(Constant.imageDownloadURL)\(strURL ?? "")")! as QLPreviewItem
  }
}


//extension URL {
//    var hasHiddenExtension: Bool {
//        get { (try? resourceValues(forKeys: [.hasHiddenExtensionKey]))?.hasHiddenExtension == true }
//        set {
//            var resourceValues = URLResourceValues()
//            resourceValues.hasHiddenExtension = newValue
//            try? setResourceValues(resourceValues)
//        }
//    }
//}
