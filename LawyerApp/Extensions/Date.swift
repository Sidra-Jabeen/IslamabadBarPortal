//
//  Date.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 20/10/2021.
//

import Foundation

extension Date {
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func previousDay()-> Date{
        var dayComponent    = DateComponents()
        dayComponent.day    = -1
        let theCalendar     = Calendar.current
        let day        = theCalendar.date(byAdding: dayComponent, to: Date())!
        return day
    }
    
    func getPreviousWeekStartDay() -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from:
        gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        return gregorian.date(byAdding: .day, value: -6, to: sunday!)!
    }

    // Getting last day of previous week
    func getPreviousWeekEndDay() -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        return gregorian.date(byAdding: .day, value: 0, to: sunday!)!
    }
    
}
