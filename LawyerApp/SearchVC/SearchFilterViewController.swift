//
//  SearchFilterViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class SearchFilterViewController: UIViewController {
    
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnSupremeCourt: UIButton!
    @IBOutlet weak var btnHighCourt: UIButton!
    @IBOutlet weak var btnLowerCourt: UIButton!
    @IBOutlet weak var btnSearchView: UIView!
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var btnCancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAll.applyCircledViewToButttons()
        self.btnSupremeCourt.applyCircledViewToButttons()
        self.btnHighCourt.applyCircledViewToButttons()
        self.btnLowerCourt.applyCircledViewToButttons()
        self.btnCancel.applyCircledViewToButttons()
        
        self.btnSupremeCourt.setBorderColorToView()
        self.btnHighCourt.setBorderColorToView()
        self.btnLowerCourt.setBorderColorToView()
        
        
        self.centerView.setCornerRadiusToView()
        self.btnSearchView.setCornerRadiusToView()
        self.firstNameView.setCornerRadiusToView()
        self.firstNameView.setBorderColorToView()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

}
