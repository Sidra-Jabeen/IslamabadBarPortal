//
//  SearchForBarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

class SearchForBarCouncilViewController: UIViewController {
    
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var viewToday: UIView!
    @IBOutlet weak var viewYesterdar: UIView!
    @IBOutlet weak var viewLastweak: UIView!
    
    @IBOutlet weak var viewToDate: UIView!
    @IBOutlet weak var viewFromDate: UIView!

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnSearchView: UIView!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewAll.applyCircledView()
        self.viewToday.applyCircledView()
        self.viewYesterdar.applyCircledView()
        self.viewLastweak.applyCircledView()
        
        self.viewAll.setBorderColorToView()
        self.viewToday.setBorderColorToView()
        self.viewYesterdar.setBorderColorToView()
        self.viewLastweak.setBorderColorToView()
        
        
        self.btnSearchView.setCornerRadiusToView()
        self.viewToDate.setCornerRadiusToView()
        self.viewFromDate.setCornerRadiusToView()
        
        self.btnCancel.applyCircledViewToButttons()
        
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

}
