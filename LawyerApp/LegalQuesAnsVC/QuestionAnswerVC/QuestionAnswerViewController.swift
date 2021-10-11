//
//  QuestionAnswerViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class QuestionAnswerViewController: UIViewController {
    
    @IBOutlet weak var writeSomethingView: UIView!
    @IBOutlet weak var btnShareView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.writeSomethingView.applyCircledView()
        self.btnShareView.applyCircledView()
        self.writeSomethingView.setBorderColorToView()
        
        
        self.navigationController?.isNavigationBarHidden = true
    }

}
