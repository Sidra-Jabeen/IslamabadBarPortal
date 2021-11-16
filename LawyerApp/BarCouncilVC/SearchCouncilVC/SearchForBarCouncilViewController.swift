//
//  SearchForBarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

protocol SearchFilterController {
    
    func selectedDateTextfield(fromDate: String, toDate: String, duration: String?, order: String, name: String?)
}

var strDate: String?
var endDate: String?

class SearchForBarCouncilViewController: UIViewController, UITextFieldDelegate, CalenderControllerDetegate {

    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewAll: UIView!
    @IBOutlet weak var viewToday: UIView!
    @IBOutlet weak var viewYesterday: UIView!
    @IBOutlet weak var viewLastweek: UIView!
    
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
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var questionView: UIView!
    
    @IBOutlet weak var txtname: UITextField!
    
    //MARK: - Propertities
    
//    var strDate: String?
//    var endDate: String?
    var toDate = Date()
    let todayDate = Date()
    let dateFormatter = DateFormatter()
    public var delegate: SearchFilterController?
    var intValue = 0
    var bitValueForAscDes = 0
    var calenderView: CalenderViewController?
    var tempTextField = UITextField()
    var intForDuration: String?
    var strValue = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgDes.image = UIImage(named: "Group 247")
        self.imgAsc.image = UIImage(named: "Circle")
        
        self.txtFromDate.delegate = self
        self.txtToDate.delegate = self
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.txtname.text = strForFullName
        
        if intForSearchFilter == 0 {
            
            self.allTapped(UIButton())
        }
        else if intForSearchFilter == 1 {
            
            self.todayBtnTapped(UIButton())
        }
        else if intForSearchFilter == 2 {
            
            self.yesterdayTapped(UIButton())
        }
        else if intForSearchFilter == 3 {
            
            self.lastWeekTapped(UIButton())
        }
        
        if intForSetAscDes == 1 {
            
            self.imgAsc.image = UIImage(named: "Group 247")
            self.imgDes.image = UIImage(named: "Circle")
            
        } else if intForSetAscDes == 2 {
            
            self.imgDes.image = UIImage(named: "Group 247")
            self.imgAsc.image = UIImage(named: "Circle")
        }
        
//        self.view.frame.size.height = UIScreen.main.bounds.height
//        self.view.frame.size.width = UIScreen.main.bounds.width
        
    }
    
    //MARK: - IBAction
    
    @IBAction func tappedOnCancel( _sender: UIButton) {
        
//        self.willMove(toParent: nil)
//        self.view.removeFromSuperview()
//        self.removeFromParent()
        
        self.dismiss(animated: true)
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
        txtToDate.text = strToDate
        txtFromDate.text = strFromDate
        
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
        strToDate = nil
        strFromDate = nil
        
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
        strToDate = nil
        strFromDate = nil
        
        let previousDay = previousDay()
        txtToDate.text = self.dateFormatter.string(from: previousDay)
        txtFromDate.text = self.dateFormatter.string(from: previousDay)
        
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
        strToDate = nil
        strFromDate = nil
        txtToDate.text = self.dateFormatter.string(from: endDay ?? Date())
        txtFromDate.text = self.dateFormatter.string(from: startDay ?? Date())
    }
    
    @IBAction func tappedOnAscOrder(_ sender: Any){

        self.bitValueForAscDes = 1
        if self.bitValueForAscDes == 1 {
            self.imgAsc.image = UIImage(named: "Group 247")
            self.imgDes.image = UIImage(named: "Circle")
        }
    }

    @IBAction func tappedOndecOrder(_ sender: Any){
        
        self.bitValueForAscDes = 2
        if self.bitValueForAscDes == 2 {
            self.imgDes.image = UIImage(named: "Group 247")
            self.imgAsc.image = UIImage(named: "Circle")
        }
    }
    
    @IBAction func tappedOnSearch(_ sender: Any) {
        
        if self.intValue == 0 {
            
            intForSearchFilter = 0
            self.intForDuration = nil
            
        } else if self.intValue == 1 {
            
            intForSearchFilter = 1
            self.intForDuration = "1"
            
        } else if self.intValue == 2 {
            
            intForSearchFilter = 2
            self.intForDuration = "2"
            
        } else if self.intValue == 3 {
            
            intForSearchFilter = 3
            self.intForDuration = "3"
        }
        
        if bitValueForAscDes == 1 {
             intForSetAscDes = 1
            self.strValue = "asc"
        } else {
            intForSetAscDes = 2
            self.strValue = "desc"
        }
        
        delegate?.selectedDateTextfield(fromDate: self.txtFromDate.text ?? "", toDate: self.txtToDate.text ?? "", duration: self.intForDuration, order: self.strValue, name: txtname.text)
    }
    
    @IBAction func tappedOnClear(_ sender: Any) {
        
        self.txtToDate.text = ""
        self.txtFromDate.text = ""
        self.txtname.text = ""
//        strFromDate = nil
//        strToDate = nil
//        strOrderBy = nil
//        strName = nil
//        strDuration = nil
        self.bitValueForAscDes = 2
        if self.bitValueForAscDes == 2 {
            self.imgDes.image = UIImage(named: "Group 247")
            self.imgAsc.image = UIImage(named: "Circle")
        }
        intForSearchFilter = 0
        intForSetAscDes = 2
        strFromDate = nil
        strToDate = nil
        self.allTapped(UIButton())
    }
    
    //MARK: - TouchScreenFunction
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//       {
//           let touch = touches.first
//           if touch?.view != self.centerView
//           { self.dismiss(animated: true, completion: nil) }
//           if touch?.view != self.topView
//           { self.dismiss(animated: true, completion: nil) }
//           if touch?.view != self.questionView
//           { self.dismiss(animated: true, completion: nil) }
//           if touch?.view != self.btnView
//           { self.dismiss(animated: true, completion: nil) }
//       }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.endEditing(true)
        self.tempTextField = textField
        self.calenderView = CalenderViewController()
        if let calender = self.calenderView {
            
            calender.modalPresentationStyle = .overCurrentContext
            calender.modalTransitionStyle = .crossDissolve
            calender.delegate = self
            calender.maxDate = txtToDate.text ?? ""
            calender.minDate = txtFromDate.text ?? ""
            if textField == txtToDate {
                
                if self.txtToDate.text == "" {
                    
                    strDOB = nil
                    
                } else  if !(self.txtToDate.text?.isEmpty ?? false) {
                    
                    strDOB = self.txtToDate.text
                }
            }
            if textField == txtFromDate {
                
                if self.txtFromDate.text == "" {
                    
                    strDOB = nil
                    
                } else  if !(self.txtFromDate.text?.isEmpty ?? false) {
                    
                    strDOB = self.txtFromDate.text
                    
                }
            }
            self.present(calender, animated: true, completion: nil)
            
        }
        
//        if self.txtToDate.text == "" {
//            strDOB = nil
//            return
//        } else  if !(self.txtToDate.text?.isEmpty ?? false) {
//            strDOB = self.txtToDate.text
//            return
//        } else if self.txtFromDate.text == "" {
//            strDOB = nil
//            return
//        } else  if !(self.txtFromDate.text?.isEmpty ?? false) {
//            strDOB = self.txtFromDate.text
//            return
//        }
//
    }
    
     //MARK: - CalenderViewDelegateMethod
    
    func didSelectDate(date: String, isClear: Bool) {
        
        strDOB = date
        self.tempTextField.text = date
        self.checkDays(allClear: isClear)
    }
    
    //MARK: - Others
    
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
    
    func checkDays(allClear: Bool){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let yesterday = previousDay()
//        let weekFirstDay = getPreviousWeekStartDay()
//        let weekLastDay = getPreviousWeekEndDay()
        let weekFirstDay = getPreviousWeekEndDay()
        let weekLastDay = getPreviousWeekStartDay()
        
        if self.txtToDate.text == dateFormatter.string(from: Date()) && self.txtFromDate.text == dateFormatter.string(from: Date()){
            self.todayBtnTapped(UIButton())
            
        }else if self.txtToDate.text == dateFormatter.string(from: yesterday) && self.txtFromDate.text == dateFormatter.string(from: yesterday){
            
            self.yesterdayTapped(UIButton())
            
        }else if self.txtToDate.text == dateFormatter.string(from: weekLastDay!) && self.txtFromDate.text == dateFormatter.string(from: weekFirstDay!){
            
            self.lastWeekTapped(UIButton())
            
        }else if allClear == false {
            self.allTapped(UIButton())
            strToDate = nil
            strFromDate = nil
        }
        
    }

}
