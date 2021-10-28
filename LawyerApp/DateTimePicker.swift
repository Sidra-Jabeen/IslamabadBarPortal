//
//  DateTimePicker.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 18/10/2021.
//

import UIKit

class DateTimePicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
  
  var didSelectDates: ((_ selectedDate: Date) -> Void)?
  
  private lazy var pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    return pickerView
  }()
  
  private var days = [Date]()
  private var startTimes = [Date]()
  private var endTimes = [Date]()
  private var months = [Date]()
  private var years = [Date]()
  
  let dayFormatter = DateFormatter()
  let timeFormatter = DateFormatter()
  let monthFormatter = DateFormatter()
  let yearFormatter = DateFormatter()
  
  var inputView: UIView {
    return pickerView
  }
  
  func setup() {
    dayFormatter.dateFormat = "dd"
    monthFormatter.dateFormat = "MMMM"
    yearFormatter.dateFormat = "yyyy"
    timeFormatter.timeStyle = .short
    days = setDays()
    startTimes = setStartTimes()
    endTimes = setEndTimes()
  }
    
    func setupFrom(toDate : Date) {
      dayFormatter.dateFormat = "dd"
      monthFormatter.dateFormat = "MMMM"
      yearFormatter.dateFormat = "yyyy"
      timeFormatter.timeStyle = .short
        days = getDay(toDate: toDate)
      
    }
  
  // MARK: - UIPickerViewDelegate & DateSource
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return days.count
    case 1:
      return startTimes.count
    case 2:
      return endTimes.count
    default:
      return 0
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel
    
    if let view = view as? UILabel {
      label = view
    } else {
      label = UILabel()
    }
    
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 15)
    
    var text = ""
    
    switch component {
    case 0:
      text = getDayString(from: days[row])
    case 1:
      text = getMonthString(from: startTimes[row])
    case 2:
      text = getYearString(from: endTimes[row])
    default:
      break
    }
    
    label.text = text
    
    return label
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    let dayIndex = pickerView.selectedRow(inComponent: 0)
//    let startTimeIndex = pickerView.selectedRow(inComponent: 1)
//    let endTimeIndex = pickerView.selectedRow(inComponent: 2)
    
      guard days.indices.contains(dayIndex) else { return }
//            startTimes.indices.contains(startTimeIndex),
//            endTimes.indices.contains(endTimeIndex) else { return }

//    let startTime = startTimes[startTimeIndex]
//    let endTime = endTimes[endTimeIndex]
            let mySelectedDate = days[dayIndex]
    
    didSelectDates?(mySelectedDate)
  }
  
  // MARK: - Private helpers
  
  private func getDays(of date: Date) -> [Date] {
      
    var dates = [Date]()
      var dayComponent    = DateComponents()
    dayComponent.day    = -30
    let calendar = Calendar.current

    // first date
    var currentDate = date

    // adding 30 days to current date
    let oneMonthFromNow = calendar.date(byAdding: dayComponent, to: currentDate)

    // last date
    let endDate = oneMonthFromNow

    while endDate! >= currentDate {
      dates.append(endDate!)
      currentDate = calendar.date(byAdding: .day, value: 1, to: endDate!)!
      
//      var dates = [Date]()
//      var dayComponent    = DateComponents()
//      dayComponent.year    = -10
//      let theCalendar     = Calendar.current
//      var startDate        = theCalendar.date(byAdding: dayComponent, to: Date())!
//      let calendar = Calendar.current
//
//      while  startDate <= Date() {
//        dates.append(startDate)
//          startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
//      }
//
//      return dates.reversed()
    }
    
    return dates
  }
    
    private func getMonths(of date: Date) -> [Date] {
      var dates = [Date]()
        var dayComponent    = DateComponents()
        dayComponent.month    = -11
      let calendar = Calendar.current

      // first date
      var currentDate = date

      // adding 30 days to current date
  //    let oneMonthFromNow = calendar.date(byAdding: .day, value: 30, to: currentDate)
//        let oneMonthFromNow = calendar.date(byAdding: .month, value: 12, to: currentDate)
        let oneMonthFromNow = calendar.date(byAdding: dayComponent, to: currentDate)

      // last date
      let endDate = oneMonthFromNow

      while endDate! >= currentDate {
        dates.append(endDate!)
        currentDate = calendar.date(byAdding: .month, value: 1, to: endDate!)!
        
  //      var dates = [Date]()
  //      var dayComponent    = DateComponents()
  //      dayComponent.year    = -10
  //      let theCalendar     = Calendar.current
  //      var startDate        = theCalendar.date(byAdding: dayComponent, to: Date())!
  //      let calendar = Calendar.current
  //
  //      while  startDate <= Date() {
  //        dates.append(startDate)
  //          startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
  //      }
  //
  //      return dates.reversed()
      }
      
      return dates
    }
    
    private func getYears(of date: Date) -> [Date] {
      var dates = [Date]()
        var dayComponent    = DateComponents()
        dayComponent.year    = -50
      let calendar = Calendar.current

      // first date
      var currentDate = date

      // adding 30 days to current date
  //    let oneMonthFromNow = calendar.date(byAdding: .day, value: 30, to: currentDate)
//        let oneMonthFromNow = calendar.date(byAdding: .year, value: 50, to: currentDate)
        let oneMonthFromNow = calendar.date(byAdding: dayComponent, to: currentDate)

      // last date
      let endDate = oneMonthFromNow

        while endDate! >= currentDate {
        dates.append(endDate!)
        currentDate = calendar.date(byAdding: .year, value: 1, to: endDate!)!
        
  //      var dates = [Date]()
  //      var dayComponent    = DateComponents()
  //      dayComponent.year    = -10
  //      let theCalendar     = Calendar.current
  //      var startDate        = theCalendar.date(byAdding: dayComponent, to: Date())!
  //      let calendar = Calendar.current
  //
  //      while  startDate <= Date() {
  //        dates.append(startDate)
  //          startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
  //      }
  //
  //      return dates.reversed()
      }
      
      return dates
    }
    
    private func getDay(toDate: Date) -> [Date] {
        
        var dates = [Date]()
        dates.removeAll()
        var startDate = toDate
        let calendar = Calendar.current

        while  startDate <= Date() {
            dates.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!

        }
        return dates.reversed()
    }
    
    private func getMonth(toDate: Date) -> [Date] {
        
        var dates = [Date]()
        dates.removeAll()
        var startDate = toDate
        let calendar = Calendar.current

        while  startDate <= Date() {
            dates.append(startDate)
            startDate = calendar.date(byAdding: .month, value: 1, to: startDate)!

        }
        return dates.reversed()
    }
    
    private func getYear(toDate: Date) -> [Date] {
        
        var dates = [Date]()
        dates.removeAll()
        var startDate = toDate
        let calendar = Calendar.current

        while  startDate <= Date() {
            dates.append(startDate)
            startDate = calendar.date(byAdding: .year, value: 1, to: startDate)!

        }
        return dates.reversed()
    }
  
  private func getTimes(of date: Date) -> [Date] {
    var times = [Date]()
    var currentDate = date
    
    currentDate = Calendar.current.date(bySetting: .hour, value: 7, of: currentDate)!
    currentDate = Calendar.current.date(bySetting: .minute, value: 00, of: currentDate)!
    
    let calendar = Calendar.current
    
    let interval = 60
    var nextDiff = interval - calendar.component(.minute, from: currentDate) % interval
    var nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: currentDate) ?? Date()
    
    var hour = Calendar.current.component(.hour, from: nextDate)
    
    while(hour < 23) {
      times.append(nextDate)
      
      nextDiff = interval - calendar.component(.minute, from: nextDate) % interval
      nextDate = calendar.date(byAdding: .minute, value: nextDiff, to: nextDate) ?? Date()
      
      hour = Calendar.current.component(.hour, from: nextDate)
    }
    
    return times
  }
  
  private func setDays() -> [Date] {
    let today = Date()
    return getDays(of: today)
  }
    
//    private func setDays() -> [Date] {
//        let today = Date(timeIntervalSince1970: 30*60*24*30*12*1)
//        return getDays(of: today)
//      }
  
  private func setStartTimes() -> [Date] {
    let today = Date()
    return getMonths(of: today)//getTimes(of: today)
  }
  
  private func setEndTimes() -> [Date] {
    let today = Date()
    return getYears(of: today)//getTimes(of: today)
  }
  
  private func getDayString(from: Date) -> String {
    return dayFormatter.string(from: from)
  }
  
  private func getTimeString(from: Date) -> String {
    return timeFormatter.string(from: from)
  }
    
    private func getMonthString(from: Date) -> String {
      return monthFormatter.string(from: from)
    }
    
    private func getYearString(from: Date) -> String {
      return yearFormatter.string(from: from)
    }
  
}

extension Date {

  static func buildTimeRangeString(startDate: Date, endDate: Date) -> String {
    
    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "EEEE, MMM d, yyyy"

    let startTimeFormatter = DateFormatter()
    startTimeFormatter.dateFormat = "h:mm a"
    
    let endTimeFormatter = DateFormatter()
    endTimeFormatter.dateFormat = "h:mm a"
    
    return String(format: "%@ (%@ - %@)",
                  dayFormatter.string(from: startDate),
                  startTimeFormatter.string(from: startDate),
                  endTimeFormatter.string(from: endDate))
  }
}
