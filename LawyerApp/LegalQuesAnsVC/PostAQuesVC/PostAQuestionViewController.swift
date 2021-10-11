//
//  PostAQuestionViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class PostAQuestionViewController: UIViewController {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var writeSomethingView: UIView!
    @IBOutlet weak var uploadButnView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var postQuesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.borderView.setCornerRadiusToView()
        self.borderView.setBorderColorToView()
        self.uploadButnView.setCornerRadiusToView()
        self.writeSomethingView.setBorderColorToView()
        self.writeSomethingView.setCornerRadiusToView()
        self.postQuesView.setCornerRadiusToView()
        self.btnCancel.layer.cornerRadius = self.btnCancel.frame.size.height / 2
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
//
//        self.dismiss(animated: true, completion: nil)
//        self.view.removeFromSuperview()
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

}
