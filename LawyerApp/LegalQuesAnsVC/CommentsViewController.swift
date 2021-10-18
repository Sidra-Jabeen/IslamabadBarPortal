//
//  CommentsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import UIKit

class CommentsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func onBackNavigation(_sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
