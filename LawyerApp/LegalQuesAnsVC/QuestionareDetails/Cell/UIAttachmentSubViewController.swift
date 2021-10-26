//
//  UIAttachmentSubViewController.swift
//  LawyerApp
//
//  Created by Mubashir Mushir on 10/25/21.

import UIKit

class UIAttachmentSubViewController: UIViewController {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var btnType: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func config(data: JSON, check: Bool) {
//        btnType.isSelected = check
//        btnType.backgroundColor = UIColor(hex: check ? 0x59c9e0 : 0x3491c3, alpha: check ? 0.45 : 0.11)
//        btnType.setTitle(data["name"].stringValue, for: .normal)
//    }

}
