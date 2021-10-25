//
//  BarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

class BarCouncilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblBarCouncilList: UITableView!
    @IBOutlet weak var scrollBar: UIScrollView!
    @IBOutlet weak var HStack: UIStackView!
    @IBOutlet weak var viewPostButton: UIView!
    
    //MARK: - Propertities
    
    var search: SearchForBarCouncilViewController?
    var postAnnouncementVC: PostAnnouncementViewController?
    var announcementsVC:AnnouncementViewController?
    var barListArrays = [AnnouncementResponseModel]()
    var intValue = 0
    var bitValueForAscDes = 0
    var strValue = ""
    let date = Date()
    let formatter = DateFormatter()
    var strDate: String?
    var endDate: String?
    var toDate = Date()
//    var strDate: String?
    private lazy var datePickerView: DateTimePicker = {
        
//        let picker = DateTimePicker()
//        picker.setup()
//        picker.didSelectDates = { [weak self] (selectedDate) in
//            print(selectedDate)
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            self?.strDate = formatter.string(from: selectedDate)
//        }
//        fromDatePickerView = DateTimePicker()
//        return picker
        
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
    
    lazy var fromDatePickerView: DateTimePicker = {
        let picker = DateTimePicker()
        return picker
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewPostButton.setCornerRadiusToView()
        self.tblBarCouncilList.register(UINib(nibName: "GeneralAnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralAnnouncementTableViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        
        if roleId == 3 {
            
            self.viewPostButton.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetAnnouncements()
    }
    
    //MARK: - HandGesturesFunction
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnSearch( _sender: UIButton) {
        
        self.search = SearchForBarCouncilViewController()
        if let searchVC = search {

            self.view.addSubview(searchVC.view)
            searchVC.btnSearch.addTarget(self, action: #selector(onClickedSearch), for: .touchUpInside)
            searchVC.btnAll.addTarget(self, action: #selector(clickedOnAll), for: .touchUpInside)
            searchVC.btnToday.addTarget(self, action: #selector(clickedOnToday), for: .touchUpInside)
            searchVC.btnYesterday.addTarget(self, action: #selector(clickedOnYesterday), for: .touchUpInside)
            searchVC.btnLastweek.addTarget(self, action: #selector(clickedOnLastweek), for: .touchUpInside)
            
            searchVC.btnAscending.addTarget(self, action: #selector(clickedOnAscending), for: .touchUpInside)
            searchVC.btndescending.addTarget(self, action: #selector(clickedOndescending), for: .touchUpInside)
            searchVC.btnClear.addTarget(self, action: #selector(clickedOnClear), for: .touchUpInside)
            searchVC.txtFromDate.delegate = self
            searchVC.txtToDate.delegate = self
            searchVC.txtToDate.inputView = datePickerView.inputView
            searchVC.txtFromDate.inputView = datePickerView.inputView
            
            if self.intValue == 0 {
                
                self.search?.txtToDate.text = ""
                self.search?.txtFromDate.text = ""
                self.setUpButtonsUI(value: self.intValue)
            }
            else if self.intValue == 1 {
                
                formatter.dateFormat = "yyyy-MM-dd"
                let result = formatter.string(from: date)
                self.search?.txtToDate.text = result
                self.search?.txtFromDate.text = result
                self.setUpButtonsUI(value: self.intValue)
            }
            else if self.intValue == 2 {
                
                let dateFormatter = DateFormatter()
                let previousDay = previousDay()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.search?.txtToDate.text = dateFormatter.string(from: previousDay)
                self.search?.txtFromDate.text = dateFormatter.string(from: previousDay)
                self.setUpButtonsUI(value: self.intValue)
            }
            else if self.intValue == 3 {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let startDay = getPreviousWeekStartDay()
                let endDay = getPreviousWeekEndDay()
                self.search?.txtToDate.text = dateFormatter.string(from: startDay ?? Date())
                self.search?.txtFromDate.text = dateFormatter.string(from: endDay ?? Date())
                self.setUpButtonsUI(value: self.intValue)
            }
            
            if self.bitValueForAscDes == 1 {
                self.search?.imgAsc.image = UIImage(named: "Group 247")
                self.search?.imgDes.image = UIImage(named: "Circle")
            } else if self.bitValueForAscDes == 2 {
                
                self.search?.imgDes.image = UIImage(named: "Group 247")
                self.search?.imgAsc.image = UIImage(named: "Circle")
            }
            
        }
    }

    @IBAction func tappedOnPostAnnouncement( _sender: UIButton) {
        
        let postVC = PostAttachmentViewController(nibName: "PostAttachmentViewController", bundle: nil)
//        postVC.strTitle = "Bar Announcement"
        postVC.height = 125
        self.navigationController?.pushViewController(postVC, animated: true)
        
//        self.postAnnouncementVC = PostAnnouncementViewController()
//        if let postAnnounc = postAnnouncementVC {
//
//            self.view.addSubview(postAnnounc.view)
//            postAnnounc.btnUpload.addTarget(self, action: #selector(onClickedUpload), for: .touchUpInside)
//
//        }
    }
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return barListArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "GeneralAnnouncementTableViewCell", for: indexPath) as! GeneralAnnouncementTableViewCell

        tmpCell.lblAnounceTitle.text = barListArrays[indexPath.row].title
        tmpCell.lblAnounceAt.text = barListArrays[indexPath.row].announcedAt
        tmpCell.lblAnounceBy.text = barListArrays[indexPath.row].announcedBy
        tmpCell.lblType.text = barListArrays[indexPath.row].typeNames
        let url = URL(string: barListArrays[indexPath.item].announcedByProfile ?? "")
        tmpCell.userImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.announcementsVC = AnnouncementViewController()
        if let vc = announcementsVC {
            
//            vc.strtitle = barListArrays[indexPath.row].title
//            vc.strdescription = barListArrays[indexPath.row].description
//            vc.anouncedAt = barListArrays[indexPath.row].announcedAt
//            vc.anouncedBy = barListArrays[indexPath.row].announcedBy
            vc.userId = barListArrays[indexPath.row].barAnnouncementId
            vc.barTitle = "Bar Announcements"
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @objc func onClickedUpload( _sender: UIButton) {
        
        self.callGetPostAnnouncementApi()
    }
    
    //MARK: - SearchForBarCouncilViewControllerFunctions
    
    @objc func onClickedSearch( _sender: UIButton) {
        
        if intValue == 0 {
        
            
            self.searchByDates(strtDate: search?.txtToDate.text ?? "", frmDate: search?.txtFromDate.text ?? "", duration: nil)
        }
        else if intValue == 1 {
            
            self.searchByDates( strtDate: search?.txtToDate.text ?? "", frmDate: search?.txtFromDate.text ?? "", duration: "1")
        }
        else if intValue == 2 {
            
            self.searchByDates( strtDate: search?.txtToDate.text ?? "", frmDate: search?.txtFromDate.text ?? "",duration: "2")
        }
        else if intValue == 3 {
            
            self.searchByDates( strtDate: search?.txtToDate.text ?? "", frmDate: search?.txtFromDate.text ?? "", duration: "3")
        }
    }
    
    @objc func clickedOnAll( _sender: UIButton) {
        
        self.intValue = 0
        self.search?.txtToDate.text = ""
        self.search?.txtFromDate.text = ""
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnToday( _sender: UIButton) {
        
        self.intValue = 1
        formatter.dateFormat = "yyyy-MM-dd"
        let result = formatter.string(from: date)
        self.search?.txtToDate.text = result
        self.search?.txtFromDate.text = result
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnYesterday( _sender: UIButton) {
        
        self.intValue = 2
        let dateFormatter = DateFormatter()
        let previousDay = previousDay()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.search?.txtToDate.text = dateFormatter.string(from: previousDay)
        self.search?.txtFromDate.text = dateFormatter.string(from: previousDay)
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnLastweek( _sender: UIButton) {
        
        self.intValue = 3
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDay = getPreviousWeekStartDay()
        let endDay = getPreviousWeekEndDay()
        self.search?.txtToDate.text = dateFormatter.string(from: startDay ?? Date())
        self.search?.txtFromDate.text = dateFormatter.string(from: endDay ?? Date())
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnAscending( _sender: UIButton) {
        
        self.bitValueForAscDes = 1
        if self.bitValueForAscDes == 1 {
            self.search?.imgAsc.image = UIImage(named: "Group 247")
            self.search?.imgDes.image = UIImage(named: "Circle")
        }
    }
    
    @objc func clickedOndescending( _sender: UIButton) {
        
        self.bitValueForAscDes = 2
        if self.bitValueForAscDes == 2 {
            self.search?.imgDes.image = UIImage(named: "Group 247")
            self.search?.imgAsc.image = UIImage(named: "Circle")
        }
    }
    
    @objc func clickedOnClear() {
        
        self.search?.txtToDate.text = ""
        self.search?.txtFromDate.text = ""
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
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.search?.txtToDate {
            
            self.search?.txtToDate.text = self.strDate
            self.checkDays()
        } else {
            
            self.search?.txtFromDate.text = self.endDate
            self.checkDays()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.search?.txtFromDate {
            self.fromDatePickerView.setupFrom(toDate: toDate)
            self.fromDatePickerView.didSelectDates = { [weak self] (selectedDate) in
                
                print(selectedDate)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self?.endDate = formatter.string(from: selectedDate)
            }
  
        }
    }
    
    func checkDays(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterday = previousDay()
        let weekFirstDay = getPreviousWeekStartDay()
        let weekLastDay = getPreviousWeekEndDay()
        
        if self.search?.txtToDate.text == dateFormatter.string(from: Date()) && self.search?.txtFromDate.text == dateFormatter.string(from: Date()){
            self.clickedOnToday(_sender: UIButton())
            
        }else if self.search?.txtToDate.text == dateFormatter.string(from: yesterday) && self.search?.txtFromDate.text == dateFormatter.string(from: yesterday){
            
//            self.yesterdayTapped(UIButton())
            self.clickedOnYesterday(_sender: UIButton())
            
        }else if self.search?.txtToDate.text == dateFormatter.string(from: weekFirstDay!) && self.search?.txtFromDate.text == dateFormatter.string(from: weekLastDay!){
            
//            self.lastWeekTapped(UIButton())
            self.clickedOnLastweek(_sender: UIButton())
        }else{
//            self.allTapped(UIButton())
            self.clickedOnAll(_sender: UIButton())
        }
        
    }
    
    //MARK: - CallingAPiFunctions
    
    func callGetAnnouncements() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: "des", limit: 10, offset: self.barListArrays.count), barAnnouncement: nil)
            let url = "api/BarAnnouncement/GetAnnouncements"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    if self.barListArrays.count > 0 {
                        if let arrayData : [AnnouncementResponseModel] = responseData.barAnnouncements {
                            
                            for item in arrayData {
                                self.barListArrays.append(item)
                            }
                        }
                    } else {
                        self.barListArrays = responseData.barAnnouncements ?? []
                        self.tblBarCouncilList.reloadData()
                        
                        self.postAnnouncementVC?.willMove(toParent: nil)
                        self.postAnnouncementVC?.view.removeFromSuperview()
                        self.postAnnouncementVC?.removeFromParent()
                    }
                    
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func callGetPostAnnouncementApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = PostAnnouncementRequestModel(source: "2", barAnnouncement: Announcement(title: self.postAnnouncementVC?.txtEnterTitle.text ?? "", description: self.postAnnouncementVC?.descTextView.text ?? "", type: ""))
//            let dataModel = PostAnnouncementRequestModel(source: "2", barAnnouncement: Announcement(title: "bar Announcement title", description: "desc"))
            let url = "api/BarAnnouncement/PostAnnouncement"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.barListArrays.removeAll()
                    self.callGetAnnouncements()
                    
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    func searchByDates(strtDate: String? = nil, frmDate: String? = nil, duration: String?) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            
            if bitValueForAscDes == 1 {
                self.strValue = "asc"
            } else {
                self.strValue = "des"
            }
            let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: self.strValue, limit: 10, offset: 0), barAnnouncement: BarAnnouncement(barAnnouncementId: nil, toDate: strtDate, fromDate: frmDate, duration: duration))
            let url = "api/BarAnnouncement/GetAnnouncements"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.barListArrays = responseData.barAnnouncements ?? []
                    self.tblBarCouncilList.reloadData()
//                    
                    self.search?.willMove(toParent: nil)
                    self.search?.view.removeFromSuperview()
                    self.search?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    func callGetAnnouncementDetailApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AnnouncementDetailsRequestModel(source: "2", barAnnouncement: Details(barAnnouncementId: 1))
            let url = "api/BarAnnouncement/GetAnnouncementDetail"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.callGetAnnouncements()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    //MARK: - Others
    
    func setUpButtonsUI(value: Int) {
        
        if self.intValue == 0 {
            
            self.search?.viewAll.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.search?.btnAll.setTitleColor( UIColor.white, for: .normal)
            self.search?.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewAll.removeBorderColorToView()
            self.search?.viewAll.applyCircledView()
            self.search?.viewToday.applyCircledView()
            self.search?.viewToday.setBorderColorToView()
            self.search?.viewYesterday.applyCircledView()
            self.search?.viewYesterday.setBorderColorToView()
            self.search?.viewLastweek.applyCircledView()
            self.search?.viewLastweek.setBorderColorToView()
            self.search?.toAndFromView.isUserInteractionEnabled = true
            
//            self.search?.calenderViewHeight.constant = 50
//            self.search?.serachByViewHeight.constant = 20
            
        }
        
        else if self.intValue == 1 {
            
            self.search?.viewToday.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.search?.btnToday.setTitleColor( UIColor.white, for: .normal)
            self.search?.viewAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewToday.removeBorderColorToView()
            self.search?.viewToday.applyCircledView()
            self.search?.viewAll.applyCircledView()
            self.search?.viewAll.setBorderColorToView()
            self.search?.viewYesterday.applyCircledView()
            self.search?.viewYesterday.setBorderColorToView()
            self.search?.viewLastweek.applyCircledView()
            self.search?.viewLastweek.setBorderColorToView()
//            self.search?.calenderViewHeight.constant = 0
//            self.search?.serachByViewHeight.constant = 0
            self.search?.toAndFromView.isUserInteractionEnabled = true
            
        }
        
        else if self.intValue == 2 {
            
            self.search?.viewYesterday.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.search?.btnYesterday.setTitleColor( UIColor.white, for: .normal)
            self.search?.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewLastweek.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnLastweek.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewYesterday.removeBorderColorToView()
            self.search?.viewYesterday.applyCircledView()
            self.search?.viewToday.applyCircledView()
            self.search?.viewToday.setBorderColorToView()
            self.search?.viewAll.applyCircledView()
            self.search?.viewAll.setBorderColorToView()
            self.search?.viewLastweek.applyCircledView()
            self.search?.viewLastweek.setBorderColorToView()
//            self.search?.calenderViewHeight.constant = 0
//            self.search?.serachByViewHeight.constant = 0
            self.search?.toAndFromView.isUserInteractionEnabled = true
            
        }
        
        else if self.intValue == 3 {
            
            self.search?.viewLastweek.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.search?.btnLastweek.setTitleColor( UIColor.white, for: .normal)
            self.search?.viewToday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnToday.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewYesterday.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnYesterday.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.search?.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
            self.search?.viewLastweek.removeBorderColorToView()
            self.search?.viewLastweek.applyCircledView()
            self.search?.viewToday.applyCircledView()
            self.search?.viewToday.setBorderColorToView()
            self.search?.viewYesterday.applyCircledView()
            self.search?.viewYesterday.setBorderColorToView()
            self.search?.viewAll.applyCircledView()
            self.search?.viewAll.setBorderColorToView()
//            self.search?.calenderViewHeight.constant = 0
//            self.search?.serachByViewHeight.constant = 0
            self.search?.toAndFromView.isUserInteractionEnabled = true
            
        }
        
    }
}
