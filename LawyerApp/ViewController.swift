//
//  ViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 08/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let welcomeVC = WelcomeToIslamabadViewController()
        self.navigationController?.pushViewController(welcomeVC, animated: true)
    }


}

