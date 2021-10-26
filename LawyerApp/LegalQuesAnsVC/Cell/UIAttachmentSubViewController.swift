//
//  UITypeSubViewController.swift
//  Aazir
//
//  Created by Waseem Khan on 23/08/2019.
//  Copyright © 2019 Waseem Khan. All rights reserved.
//

import UIKit

class UITypeSubViewController: UIViewController {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var btnType: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func config(data: JSON, check: Bool) {
        btnType.isSelected = check
        btnType.backgroundColor = UIColor(hex: check ? 0x59c9e0 : 0x3491c3, alpha: check ? 0.45 : 0.11)
        btnType.setTitle(data["name"].stringValue, for: .normal)
    }

}
