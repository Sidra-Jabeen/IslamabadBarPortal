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
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnAscending: UIButton!
    @IBOutlet weak var btndescending: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgAsc: UIImageView!
    @IBOutlet weak var imgDes: UIImageView!
    
    @IBOutlet weak var btnAllView: UIView!
    @IBOutlet weak var btnSupremeView: UIView!
    @IBOutlet weak var btnHighView: UIView!
    @IBOutlet weak var btnLowerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAll.applyCircledViewToButttons()
        self.btnSupremeCourt.applyCircledViewToButttons()
        self.btnHighCourt.applyCircledViewToButttons()
        self.btnLowerCourt.applyCircledViewToButttons()
        self.btnCancel.applyCircledViewToButttons()
        
//        self.btnSupremeCourt.setBorderColorToView()
//        self.btnHighCourt.setBorderColorToView()
//        self.btnLowerCourt.setBorderColorToView()
        
        self.btnAllView.setBorderColorToView()
        self.btnAllView.setCornerRadiusToView()
        self.btnLowerView.setBorderColorToView()
        self.btnLowerView.setCornerRadiusToView()
        self.btnHighView.setBorderColorToView()
        self.btnHighView.setCornerRadiusToView()
        self.btnSupremeView.setBorderColorToView()
        self.btnSupremeView.setCornerRadiusToView()
        
        self.centerView.setCornerRadiusToView()
        self.btnSearchView.setCornerRadiusToView()
        self.firstNameView.setCornerRadiusToView()
        self.firstNameView.setBorderColorToView()
        
        self.btnAllView.applyCircledView()
        self.btnHighView.applyCircledView()
        self.btnLowerView.applyCircledView()
        self.btnSupremeView.applyCircledView()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

}
