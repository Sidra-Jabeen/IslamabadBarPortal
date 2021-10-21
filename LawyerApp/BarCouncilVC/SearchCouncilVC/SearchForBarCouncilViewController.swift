//
//  SearchForBarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

class SearchForBarCouncilViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var viewToday: UIView!
    @IBOutlet weak var viewYesterday: UIView!
    @IBOutlet weak var viewLastweek: UIView!
    
    @IBOutlet weak var toAndFromView: UIView!
    @IBOutlet weak var searchByDateView: UIView!
    @IBOutlet weak var viewToDate: UIView!
    @IBOutlet weak var viewFromDate: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnSearchView: UIView!
    @IBOutlet weak var postAnnouncementView:UIView!
    @IBOutlet weak var btnClearView: UIView!
    
    @IBOutlet weak var btnAll: UIButton!
    @IBOutlet weak var btnToday: UIButton!
    @IBOutlet weak var btnYesterday: UIButton!
    @IBOutlet weak var btnLastweek: UIButton!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    @IBOutlet weak var btnAscending: UIButton!
    @IBOutlet weak var btndescending: UIButton!
    @IBOutlet weak var btnToDate: UIButton!
    @IBOutlet weak var btnFromDate: UIButton!
    
    @IBOutlet weak var imgAsc: UIImageView!
    @IBOutlet weak var imgDes: UIImageView!
    
    @IBOutlet weak var txtToDate: UITextField!
    @IBOutlet weak var txtFromDate: UITextField!
    
    @IBOutlet weak var serachByViewHeight: NSLayoutConstraint!
    @IBOutlet weak var calenderViewHeight: NSLayoutConstraint!
    
    //MARK: - Propertities
    
    var strDate: String?
    private lazy var datePickerView: DateTimePicker = {
        
        let picker = DateTimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (selectedDate) in
            print(selectedDate)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self?.strDate = formatter.string(from: selectedDate)
        }
        return picker
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.btnSearchView.setCornerRadiusToView()
        self.btnClearView.setCornerRadiusToView()
        self.viewToDate.setCornerRadiusToView()
        self.viewFromDate.setCornerRadiusToView()
        self.postAnnouncementView.setCornerRadiusToView()
        self.btnCancel.applyCircledViewToButttons()
        
        self.viewToDate.setCornerRadiusToView()
        self.viewToDate.setBorderColorToView()
        
        self.viewFromDate.setCornerRadiusToView()
        self.viewFromDate.setBorderColorToView()
        
        self.viewAll.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
        self.btnAll.setTitleColor( UIColor.white, for: .normal)
        
        self.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewAll.removeBorderColorToView()
        self.viewAll.applyCircledView()
        self.viewToday.applyCircledView()
        self.viewToday.setBorderColorToView()
        self.viewYesterday.applyCircledView()
        self.viewYesterday.setBorderColorToView()
        self.viewLastweek.applyCircledView()
        self.viewLastweek.setBorderColorToView()
        
        self.imgDes.image = UIImage(named: "Group 247")
        self.imgAsc.image = UIImage(named: "Circle")
        
        
        self.txtToDate.inputView = datePickerView.inputView
        self.txtFromDate.inputView = datePickerView.inputView
        
        self.txtFromDate.delegate = self
        self.txtToDate.delegate = self
//        
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
        
    }
    
    //MARK: - IBAction
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtToDate {
            
            self.txtToDate.text = self.strDate
        } else {
            
            self.txtFromDate.text = self.strDate
        }
    }
}
