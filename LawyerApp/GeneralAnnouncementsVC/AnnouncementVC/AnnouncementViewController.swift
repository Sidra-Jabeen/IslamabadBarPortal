//
//  AnnouncementViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class AnnouncementViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var lblAnnounceBy: UILabel!
    @IBOutlet weak var lbAnnounceAt: UILabel!
    @IBOutlet weak var lblBarTitle: UILabel!
    
    //MARK: - Propertities
    
    var strtitle: String?
    var strdescription: String?
    var anouncedBy: String?
    var anouncedAt: String?
    var barTitle: String?
    var userId: Int?
    var bitValue = false
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.lblTitle.text = self.strtitle
//        self.txtDesc.text = self.strdescription
//        self.lbAnnounceAt.text = self.anouncedAt
//        self.lblAnnounceBy.text = self.anouncedBy
        self.lblBarTitle.text = self.barTitle
        
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
    
    //MARK: - CallingApiFunction
    
    func callGetAnnouncementDetailApi() {
        
        if self.bitValue {
            
            if  Connectivity.isConnectedToInternet {
                self.startAnimation()
                let dataModel = GeneralAnnouncementDetailsRequestModel(source: "2", memberAnnouncement: GeneralAnnouncementDetails(memberAnnouncementId: self.userId ?? 0))
                let url = "api/MemberAnnouncement/GetAnnouncementDetail"
                let services = GeneralAnnouncementDetailServices()
                services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                    
                    self.stopAnimation()
                    let status = responseData.success ?? false
                    if status {
                        self.lblTitle.text = responseData.memberAnnouncement?.title
                        self.txtDesc.text = responseData.memberAnnouncement?.description
                        self.lbAnnounceAt.text = responseData.memberAnnouncement?.announcedAt
                        self.lblAnnounceBy.text = responseData.memberAnnouncement?.announcedBy                } else {
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
                let url = "api/BarAnnouncement/GetAnnouncementDetail"
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
