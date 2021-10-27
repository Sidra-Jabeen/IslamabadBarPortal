//
//  AnnouncementViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class AnnouncementViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblBarTitle.text = self.barTitle
        
        self.attachmentsCollection.register(UINib(nibName: "UIAttachmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UIAttachmentCollectionViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetAnnouncementDetailApi()
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
        
        let strURL = self.arrAttachmentResponse[indexPath.row].attachmentUrl
        let url = URL(string: "http://203.215.160.148:9545/documents/\(strURL ?? "")")
        tmpCell.imgPostQuestion.kf.setImage(with: url, placeholder: UIImage(named: ""))
        tmpCell.btnAdd.isHidden = true
        tmpCell.btnRemove.isHidden = true
//            tmpCell.btnRemove.tag = indexPath.row
        //self.arrayForImages[indexPath.row - 1]
//            tmpCell.btnRemove.addTarget(self, action: #selector(onClickRemoveImage), for: .touchUpInside)
        return tmpCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
                        let url = URL(string: "http://203.215.160.148:9545/documents/\(strURL ?? "")")
                        self.imgProfile.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
                        self.arrAttachmentResponse = responseData.memberAnnouncement?.attachments ?? []
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
                let url = Constant.memGetAnnounceDetailsEP
                let services = BarAnnouncementDetailServices()
                services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                    
                    self.stopAnimation()
                    let status = responseData.success ?? false
                    if status {
                        self.lblTitle.text = responseData.barAnnouncement?.title
                        self.txtDesc.text = responseData.barAnnouncement?.description
                        self.lbAnnounceAt.text = responseData.barAnnouncement?.announcedAt
                        self.lblAnnounceBy.text = responseData.barAnnouncement?.announcedBy
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
