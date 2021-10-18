//
//  AnnouncementViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class AnnouncementViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var lblAnnounceBy: UILabel!
    @IBOutlet weak var lbAnnounceAt: UILabel!
    @IBOutlet weak var lblBarTitle: UILabel!
    
    var strtitle: String?
    var strdescription: String?
    var anouncedBy: String?
    var anouncedAt: String?
    var barTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = self.strtitle
        self.txtDesc.text = self.strdescription
        self.lbAnnounceAt.text = self.anouncedAt
        self.lblAnnounceBy.text = self.anouncedBy
        self.lblBarTitle.text = self.barTitle
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                swipeLeft.direction = .right
                self.view.addGestureRecognizer(swipeLeft)
        
        self.navigationController?.isNavigationBarHidden = true
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

    @IBAction func tappedOnBack(_sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
