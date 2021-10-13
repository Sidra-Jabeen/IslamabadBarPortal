//
//  CalenderViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import UIKit
import FSCalendar

class CalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    public var delegate: CalenderControllerDetegate?
    var str: String?
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUPFSCalender()
        self.view.frame.size.height = UIScreen.main.bounds.height
        self.view.frame.size.width = UIScreen.main.bounds.width
    }
    
    func setUPFSCalender() {
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.calendar.appearance.headerDateFormat = "dd/MM/YYYY"
        let date = Date()
        formatter.dateFormat = "dd/MM/YYYY"
        self.str = formatter.string(from: date)
        print(self.str ?? "")
        self.calendar.swipeToChooseGesture.isEnabled = true
        self.calendar.placeholderType = .none
        self.calendar.scrollEnabled = true
        self.calendar.allowsMultipleSelection = false
//        self.calendar.scopeGesture.isEnabled = true
//                self.calendar.handleScopeGesture(.init(target: self, action: #selector (switchCalendarScope(sender: ))))
        //        self.contentView.addGestureRecognizer(self.scopeGesture)
        //        self.calenderView.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .month
        //        switchCalendarScope()
    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date) ?? Date()
    }

    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date) ?? Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd/MM/YYYY"
        self.str = formatter.string(from: date)
        print(self.str ?? "")
        delegate?.didSelectDate(date: self.str ?? "")
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()

//        for currentData in dictOfArrays {
//            print("array date of each index: \(currentData["eventDate"] ?? "")")
//            if currentData["eventDate"] == formatter.string(from: date) {
//                data.append(currentData)
//            }
//        }
//        self.tblEvents.reloadData()
    }

}

protocol CalenderControllerDetegate {
    func didSelectDate(date: String)
}
