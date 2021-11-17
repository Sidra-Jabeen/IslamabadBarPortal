//
//  CalenderViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import UIKit
import FSCalendar

class CalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var lblDate: UILabel!
    
    //MARK: - Propertities
    
    public var delegate: CalenderControllerDetegate?
    var str: String?
    var bitVale = false
    let formatter = DateFormatter()
    var minDate = ""
    var maxDate = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUPFSCalender()
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedOnBack(_ sender: Any) {
        
        self.calendar.setCurrentPage(getPreviousYear(date: calendar.currentPage), animated: true)
        self.lblDate.text = ""
        calendarCurrentPageDidChange(self.calendar)
    }
    
    @IBAction func tappedOnForward(_ sender: Any) {
        
        self.calendar.setCurrentPage(getNextYear(date: calendar.currentPage), animated: true)
        self.lblDate.text = ""
        calendarCurrentPageDidChange(self.calendar)
    }
    
    //MARK: - FSCalenderDelegate
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date) ?? Date()
    }

    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date) ?? Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.setCurrentPage(date, animated: true)
        calendar.select(date)
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.dateFormat = calendar.appearance.headerDateFormat
        
        for cell in calendar.calendarHeaderView.collectionView.visibleCells {
            (cell as! FSCalendarHeaderCell).titleLabel.text = formatter.string(from: date)
        }
        self.lblDate.text = strDOB
        self.str = formatter.string(from: date)
        self.bitVale = true
        print(self.str ?? "")
        delegate?.didSelectDate(date: self.str ?? "", isClear: self.bitVale)
        self.dismiss(animated: true)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        
//        let date = formatter.date(from: self.maxDate)
//        return date ?? calendar.maximumDate
//        formatter.dateFormat = "dd-MM-yyyy"
//        if maxDate == "" {
//            return calendar.maximumDate
//        } else if !(maxDate.isEmpty) {
//            let date = formatter.date(from: self.maxDate) ?? Date()
//            return date
//        } else {
//            return Date()
//        }
        
        return Date()
//        var dateComponents:DateComponents = DateComponents()
//        dateComponents.day = 28
//        let currentCalander:Calendar = Calendar.current
//        return currentCalander.date(byAdding:dateComponents, to: Date())!
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        
//        let date = formatter.date(from: self.minDate)
//        return date ?? calendar.minimumDate
        
        formatter.dateFormat = "dd-MM-yyyy"
        if minDate == "" {
            return calendar.minimumDate
        } else {
            let date = formatter.date(from: self.minDate) ?? Date()
            return date
        }
//        return Date()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//            calendar.reloadData()
        let currentPageDate = calendar.currentPage
        let year = Calendar.current.component(.year, from: currentPageDate)
        self.calendar.appearance.headerDateFormat = "dd-MM-YYYY"
//        let date = Date()
//        formatter.dateFormat = "dd-MM-YYYY"
        self.lblDate.text = formatter.string(from: self.calendar.currentPage)
    }
    
    func getNextYear(date:Date)->Date {
        return  Calendar.current.date(byAdding: .year, value: 1, to:date) ?? Date()
    }

    func getPreviousYear(date:Date)->Date {
        return  Calendar.current.date(byAdding: .year, value: -1, to:date) ?? Date()
    }
    
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
//    {
//        let date = formatter.date(from: strDOB ?? "")
//        if(date == date)
//        {
//            return false
//        }
//        else
//        {
//            return true
//        }
//    }
    
    //MARK: - TouchScreenFunction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           let touch = touches.first
           if touch?.view != self.calendar
           { self.dismiss(animated: true, completion: nil) }
       }
    
    //MARK: - Others
    
    func setUPFSCalender() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        let currentDate = Date()
        formatter.dateFormat = "dd-MM-yyyy"
        self.calendar.appearance.headerDateFormat = "dd-MM-yyyy"
//        self.calendar.appearance.headerDateFormat = formatter.string(from: date)
//        self.str = formatter.string(from: date)
//        self.calendar.appearance.headerDateFormat = self.str
//        print(self.str ?? "")
//        self.calendar.selectedDate.
        let date = strDOB
        
        if let dob = formatter.date(from: date ?? "") {
            self.lblDate.text = strDOB
            self.calendar.select(dob)
            
        } else {
            self.lblDate.text = formatter.string(from: currentDate)
        }
        
        
        self.calendar.swipeToChooseGesture.isEnabled = true
        self.calendar.placeholderType = .none
        self.calendar.scrollEnabled = true
        self.calendar.allowsMultipleSelection = false
        self.calendar.scope = .month
        self.calendar.reloadData()
    }

}

protocol CalenderControllerDetegate {
    func didSelectDate(date: String, isClear: Bool)
}