//
//  SearchForBarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

protocol SearchFilterController {
    func selectedDateTextfield(startDate: String, endDate: String)
}

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
    var endDate: String?
    var toDate = Date()
    let todayDate = Date()
    let dateFormatter = DateFormatter()
    public var delegate: SearchFilterController?
    var intValue = 0
    var bitValueForAscDes = 0
    
    
    private lazy var datePickerView: DateTimePicker = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let picker = DateTimePicker()
//        picker.setup()
        
        print(picker.setup())
        picker.didSelectDates = { [weak self] (selectedDate) in
             self!.toDate = selectedDate
            //print(selectedDate)
            self?.strDate = formatter.string(from: selectedDate)
        }
        fromDatePickerView = DateTimePicker()
        return picker
    }()
    
    private lazy var fromDatePickerView: DateTimePicker = {
        let picker = DateTimePicker()
        return picker
    }()
    
    deinit {
        fromDatePickerView = DateTimePicker()
    }
//    private lazy var datePickerView: DateTimePicker = {
//        
////        let picker = DateTimePicker()
////        picker.setup()
////        picker.didSelectDates = { [weak self] (selectedDate) in
////            print(selectedDate)
////
////            let formatter = DateFormatter()
////            formatter.dateFormat = "yyyy-MM-dd"
////            self?.strDate = formatter.string(from: selectedDate)
////        }
////        fromDatePickerView = DateTimePicker()
////        return picker
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let picker = DateTimePicker()
////        picker.setup()
//        
//        print(picker.setup())
//        picker.didSelectDates = { [weak self] (selectedDate) in
//             self!.toDate = selectedDate
//            //print(selectedDate)
//            self?.strDate = formatter.string(from: selectedDate)
//        }
//        fromDatePickerView = DateTimePicker()
//        return picker
//    }()
//    
//    lazy var fromDatePickerView: DateTimePicker = {
//        let picker = DateTimePicker()
//        return picker
//    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.btnSearchView.setCornerRadiusToView()
//        self.btnClearView.setCornerRadiusToView()
//        self.viewToDate.setCornerRadiusToView()
//        self.viewFromDate.setCornerRadiusToView()
//        self.postAnnouncementView.setCornerRadiusToView()
//        self.btnCancel.applyCircledViewToButttons()
//
//        self.viewToDate.setCornerRadiusToView()
//        self.viewToDate.setBorderColorToView()
//
//        self.viewFromDate.setCornerRadiusToView()
//        self.viewFromDate.setBorderColorToView()
//
//        self.viewAll.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
//        self.btnAll.setTitleColor( UIColor.white, for: .normal)
//
//        self.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
//        self.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
//        self.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        self.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
//        self.viewAll.removeBorderColorToView()
//        self.viewAll.applyCircledView()
//        self.viewToday.applyCircledView()
//        self.viewToday.setBorderColorToView()
//        self.viewYesterday.applyCircledView()
//        self.viewYesterday.setBorderColorToView()
//        self.viewLastweek.applyCircledView()
//        self.viewLastweek.setBorderColorToView()
        
        self.imgDes.image = UIImage(named: "Group 247")
        self.imgAsc.image = UIImage(named: "Circle")
        self.txtToDate.inputView = datePickerView.inputView
        self.txtFromDate.inputView = fromDatePickerView.inputView
        
        self.txtFromDate.delegate = self
        self.txtToDate.delegate = self
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if self.intValue == 0 {
            
            self.allTapped(UIButton())
        }
        else if self.intValue == 1 {
            
            self.todayBtnTapped(UIButton())
        }
        else if self.intValue == 2 {
            
            self.yesterdayTapped(UIButton())
        }
        else if self.intValue == 3 {
            
            self.lastWeekTapped(UIButton())
        }
        
//        self.txtToDate.inputView = datePickerView.inputView
//        self.txtFromDate.inputView = datePickerView.inputView
        
//        self.txtFromDate.delegate = self
//        self.txtToDate.delegate = self
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
    
    @IBAction func allTapped(_ sender: Any) {
        //checkDays()
        self.intValue = 0
        self.viewAll.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
        self.btnAll.setTitleColor( UIColor.white, for: .normal)
        self.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
//        txtToDate.text = ""
//        txtFromDate.text = ""
        
    }
    
    
    @IBAction func todayBtnTapped(_ sender: Any) {
        
        self.intValue = 1
        self.viewToday.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
        self.btnToday.setTitleColor( UIColor.white, for: .normal)
        self.viewAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
        
        
        txtToDate.text = self.dateFormatter.string(from: self.todayDate)
        txtFromDate.text = self.dateFormatter.string(from: self.todayDate)
        
        
    }
 
    
    @IBAction func yesterdayTapped(_ sender: Any) {
        
        self.intValue = 2
        self.viewYesterday.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
        self.btnYesterday.setTitleColor( UIColor.white, for: .normal)
        self.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
        
        
        let previousDay = previousDay()
        txtToDate.text = self.dateFormatter.string(from: previousDay)
        txtFromDate.text = self.dateFormatter.string(from: previousDay)
        
//        datePickerView.Value = previousDay
        
    }
    
    @IBAction func lastWeekTapped(_ sender: Any) {
        
        self.intValue = 3
        self.viewLastweek.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
        self.btnLastweek.setTitleColor( UIColor.white, for: .normal)
        self.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
        self.viewAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
        let startDay = getPreviousWeekStartDay()
        let endDay = getPreviousWeekEndDay()
        txtToDate.text = self.dateFormatter.string(from: startDay ?? Date())
        txtFromDate.text = self.dateFormatter.string(from: endDay ?? Date())
    }
    
//    @IBAction func tappedOnAscOrder(_ sender: Any){
//
//        self.bitValueForAscDes = 1
//        if self.bitValueForAscDes == 1 {
//            self.imgAsc.image = UIImage(named: "Group 247")
//            self.imgDes.image = UIImage(named: "Circle")
//        }
//    }
//
//    @IBAction func tappedOndecOrder(_ sender: Any){
//
//        self.bitValueForAscDes = 2
//        if self.bitValueForAscDes == 2 {
//            self.imgDes.image = UIImage(named: "Group 247")
//            self.imgAsc.image = UIImage(named: "Circle")
//    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtToDate {
            
            self.txtToDate.text = self.strDate
            checkDays()
    
//            self.txtFromDate.inputView = self.fromDatePickerView.inputView
            
        } else if textField == self.txtFromDate {
            
            self.txtFromDate.text = self.endDate
            
            checkDays()

        }
        
        delegate?.selectedDateTextfield(startDate: self.strDate ?? "", endDate: self.endDate ?? "")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.txtFromDate {
            fromDatePickerView.setupFrom(toDate: toDate)
            fromDatePickerView.didSelectDates = { [weak self] (selectedDate) in
                
                print(selectedDate)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self?.endDate = formatter.string(from: selectedDate)
            }
  
        }
    }
    
    
    func previousDay()-> Date{
        let theCalendar     = Calendar.current
        let day = theCalendar.date(byAdding: .day, value: -1, to: Date())!
        return day
    }
    
    func getPreviousWeekStartDay() -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from:
        gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        return gregorian.date(byAdding: .day, value: -7, to: sunday!)!
    }

    func getPreviousWeekEndDay() -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        return gregorian.date(byAdding: .day, value: -1, to: sunday!)!
    }
    
    func checkDays(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterday = previousDay()
        let weekFirstDay = getPreviousWeekStartDay()
        let weekLastDay = getPreviousWeekEndDay()
        
        if self.txtToDate.text == dateFormatter.string(from: Date()) && self.txtFromDate.text == dateFormatter.string(from: Date()){
            self.todayBtnTapped(UIButton())
            
        }else if self.txtToDate.text == dateFormatter.string(from: yesterday) && self.txtFromDate.text == dateFormatter.string(from: yesterday){
            
            self.yesterdayTapped(UIButton())
            
        }else if self.txtToDate.text == dateFormatter.string(from: weekFirstDay!) && self.txtFromDate.text == dateFormatter.string(from: weekLastDay!){
            
            self.lastWeekTapped(UIButton())
        }else{
            self.allTapped(UIButton())
        }
        
    }
    

    
    //MARK: - UITextFieldDelegate
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        
//        if textField == self.txtToDate {
//            
//            self.txtToDate.text = self.strDate
//        } else {
//            
//            self.txtFromDate.text = self.strDate
//        }
//    }
}
