//
//  BarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

class BarCouncilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,SearchFilterController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblBarCouncilList: UITableView!
    @IBOutlet weak var scrollBar: UIScrollView!
    @IBOutlet weak var HStack: UIStackView!
    @IBOutlet weak var viewPostButton: UIView!
    
    @IBOutlet weak var dataNotFoundView: UIView!
    @IBOutlet weak var tableView: UIView!
    
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
    var refreshControl: UIRefreshControl?
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
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        self.tblBarCouncilList.addSubview(self.refreshControl!)
        self.callGetAnnouncements()
        if roleId == 3 {
            
            self.viewPostButton.isHidden = false
        }
    }
    
    @objc func didPullToRefresh() {
        
        self.barListArrays.removeAll()
        self.callGetAnnouncements()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FileManager.default.clearTmpDirectory()
//        self.callGetAnnouncements()
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
            
            
            searchVC.modalPresentationStyle = .overCurrentContext
            searchVC.modalTransitionStyle = .crossDissolve
            searchVC.delegate = self
            self.present(searchVC, animated: true, completion: nil)
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
        tmpCell.selectionStyle = .none
        let url = URL(string: barListArrays[indexPath.item].announcedByProfile ?? "")
        tmpCell.userImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // need to pass your indexpath then it showing your indicator at bottom
           tableView.addLoading(indexPath) {
               self.callGetAnnouncements()
               tableView.stopLoading() // stop your indicator
           }
    }
    
    //MARK: - CallingAPiFunctions
    
    func callGetAnnouncements() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: "desc", limit: 10, offset: self.barListArrays.count), barAnnouncement: nil)
            let url = Constant.barGetAnnounceEP
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    if responseData.barAnnouncements?.count != 0 {
                        if self.barListArrays.count > 0 {
                            
                            if let arrayData : [AnnouncementResponseModel] = responseData.barAnnouncements {
                                
                                for item in arrayData {
                                    self.barListArrays.append(item)
                                    self.tblBarCouncilList.reloadData()
                                    self.dataNotFoundView.isHidden = true
                                    self.tableView.isHidden = false
                                }
                            }
                        } else {
                            self.barListArrays = responseData.barAnnouncements ?? []
                            self.tblBarCouncilList.reloadData()
                            self.dataNotFoundView.isHidden = true
                            self.tableView.isHidden = false
                        }
                    
                    }
                    
//                    self.barListArrays = responseData.barAnnouncements ?? []
//                    self.tblBarCouncilList.reloadData()
//                    self.dataNotFoundView.isHidden = true
//                    self.tableView.isHidden = false
                    
                } else {
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    if self.barListArrays.count == 0 {
                        self.dataNotFoundView.isHidden = false
                        self.tableView.isHidden = true
                    }
                    
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func selectedDateTextfield(fromDate: String, toDate: String, duration: String?, order: String) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: order, limit: 10, offset: 0), barAnnouncement: BarAnnouncement(barAnnouncementId: nil, toDate: toDate, fromDate: fromDate, duration: duration))
            let url = Constant.barGetAnnounceEP
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
//                    if responseData.barAnnouncements?.count != 0 {
//                        if self.barListArrays.count > 0 {
//
//                            if let arrayData : [AnnouncementResponseModel] = responseData.barAnnouncements {
//
//                                for item in arrayData {
//                                    self.barListArrays.append(item)
//                                    self.tblBarCouncilList.reloadData()
//                                    self.search?.dismiss(animated: true)
//                                    self.dataNotFoundView.isHidden = true
//                                    self.tableView.isHidden = false
//                                }
//                            }
//                        } else {
//                            self.barListArrays = responseData.barAnnouncements ?? []
//                            self.tblBarCouncilList.reloadData()
//                            self.search?.dismiss(animated: true)
//                            self.dataNotFoundView.isHidden = true
//                            self.tableView.isHidden = false
//                        }
//
//                    }
                    self.barListArrays.removeAll()
                    self.barListArrays = responseData.barAnnouncements ?? []
                    self.tblBarCouncilList.reloadData()
                    self.search?.dismiss(animated: true)
                    self.dataNotFoundView.isHidden = true
                    self.tableView.isHidden = false
                    
                } else {
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    self.search?.dismiss(animated: true)
                    self.dataNotFoundView.isHidden = false
                    self.tableView.isHidden = true
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
//            self.search?.toAndFromView.isUserInteractionEnabled = true
            
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
//            self.search?.toAndFromView.isUserInteractionEnabled = true
            
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
//            self.search?.toAndFromView.isUserInteractionEnabled = true
            
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
//            self.search?.toAndFromView.isUserInteractionEnabled = true
            
        }
        
    }
}
