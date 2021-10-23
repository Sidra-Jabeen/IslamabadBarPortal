//
//  PostAttachmentViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 22/10/2021.
//

import UIKit

class PostAttachmentViewController: UIViewController {
    
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
    
    //MARK: - Propertities
    
    var bitForLisenceType = 0

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
    
    
    @IBAction func tappedOnUpload( _sender: UIButton) {
        
        if self.bitForLisenceType == 1 {
            
            self.callGetPostAnnouncementApi(type: 1)
            
        } else if self.bitForLisenceType == 2 {
            
            self.callGetPostAnnouncementApi(type: 2)
            
        } else if self.bitForLisenceType == 3 {
            
            self.callGetPostAnnouncementApi(type: 3)
            
        }
    }
    
    //MARK: - CallingApiFunctions
    
    func callGetPostAnnouncementApi(type: Int) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = PostAnnouncementRequestModel(source: "2", barAnnouncement: Announcement(title: self.txtTitle.text ?? "", description: self.txtDescription.text ?? "", type: "\(type)"))
            let url = "api/BarAnnouncement/PostAnnouncement"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    print("successssss")
                    
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
}
