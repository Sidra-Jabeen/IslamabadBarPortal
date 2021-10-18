//
//  GeneralAnnouncementsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import SwiftUI

class GeneralAnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tblAnnouncements: UITableView!
    
    var search: SearchForBarCouncilViewController?
    var postAnnouncementVC: PostAnnouncementViewController?
    var announcementsVC:AnnouncementViewController?
    var listArrays = [GeneralAnnouncementResponseModel]()
    var intValue = 0
    var bitValueForAscDes = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblAnnouncements.register(UINib(nibName: "GeneralAnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralAnnouncementTableViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                swipeLeft.direction = .right
                self.view.addGestureRecognizer(swipeLeft)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetGeneralAnnouncements()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "GeneralAnnouncementTableViewCell", for: indexPath) as! GeneralAnnouncementTableViewCell

        tmpCell.lblAnounceTitle.text = listArrays[indexPath.row].title
        tmpCell.lblAnounceAt.text = listArrays[indexPath.row].announcedAt
        tmpCell.lblAnounceBy.text = listArrays[indexPath.row].announcedBy
        tmpCell.selectionStyle = .none
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tblAnnouncements.deselectRow(at: indexPath, animated: true)
        self.announcementsVC = AnnouncementViewController()
        if let vc = announcementsVC {
            
            vc.strtitle = listArrays[indexPath.row].title
            vc.strdescription = listArrays[indexPath.row].description
            vc.anouncedAt = listArrays[indexPath.row].announcedAt
            vc.anouncedBy = listArrays[indexPath.row].announcedBy
            vc.barTitle = "General Announcements"
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
//        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
//        self.view.removeFromSuperview()
        
    }
    
    @IBAction func tappedOnPostAnnouncement( _sender: UIButton) {
        
        self.postAnnouncementVC = PostAnnouncementViewController()
        if let postAnnounc = postAnnouncementVC {
            
            self.view.addSubview(postAnnounc.view)
            postAnnounc.btnUpload.addTarget(self, action: #selector(onClickedUpload), for: .touchUpInside)
            
        }

    }
    
    @IBAction func tappedOnSearchAnnouncement( _sender: UIButton) {
        
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
//            searchVC.btnToDate.addTarget(self, action: #selector(openDatePicker), for: .touchUpInside)
//            searchVC.btnFromDate.addTarget(self, action: #selector(openDatePicker), for: .touchUpInside)
            
        }
    }
    
//    @objc func openDatePicker() {
//
//        search?.txtToDate.inputView = search?.datePickerView.inputView
//        search?.txtFromDate.inputView = search?.datePickerView.inputView
//    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        search?.txtToDate.text = dateFormatter.string(from: sender.date)
    }

    @objc func onClickedUpload() {
        
        self.callGetPostAnnouncementApi()
    }
    
    @objc func onClickedSearch() {
        
        if intValue == 0 {
        
            
            self.searchByDates(strtDate: search?.txtToDate.text ?? "", frmDate: search?.txtFromDate.text ?? "", duration: nil)
        }
        else if intValue == 1 {
            
            self.searchByDates( duration: "1")
        }
        else if intValue == 2 {
            
            self.searchByDates(duration: "2")
        }
        else if intValue == 3 {
            
            self.searchByDates( duration: "3")
        }
    }
    
    @objc func clickedOnAll() {
        
        self.intValue = 0
//        self.search?.txtToDate.isUserInteractionEnabled = false
//        self.search?.txtFromDate.isUserInteractionEnabled = false
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnToday() {
        
        self.intValue = 1
//        self.search?.txtToDate.isUserInteractionEnabled = true
//        self.search?.txtFromDate.isUserInteractionEnabled = true
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnYesterday() {
        
        self.intValue = 2
//        self.search?.txtToDate.isUserInteractionEnabled = true
//        self.search?.txtFromDate.isUserInteractionEnabled = true
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnLastweek() {
        
        self.intValue = 3
//        self.search?.txtToDate.isUserInteractionEnabled = true
//        self.search?.txtFromDate.isUserInteractionEnabled = true
        self.setUpButtonsUI(value: self.intValue)
    }
    
    @objc func clickedOnAscending() {
        
        self.bitValueForAscDes = 1
        if self.bitValueForAscDes == 1 {
            self.search?.imgAsc.image = UIImage(named: "Group 247")
            self.search?.imgDes.image = UIImage(named: "Circle")
        }
    }
    
    @objc func clickedOndescending() {
        
        self.bitValueForAscDes = 2
        if self.bitValueForAscDes == 2 {
            self.search?.imgDes.image = UIImage(named: "Group 247")
            self.search?.imgAsc.image = UIImage(named: "Circle")
        }
    }
    
    
    func callGetGeneralAnnouncements() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            
            
            let dataModel = GeneralAnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: "", limit: 10, offset: listArrays.count), memberAnnouncement: nil)
            let url = "api/MemberAnnouncement/GetAnnouncements"
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.listArrays = responseData.memberAnnouncements ?? []
                    self.tblAnnouncements.reloadData()
                    
                    self.postAnnouncementVC?.willMove(toParent: nil)
                    self.postAnnouncementVC?.view.removeFromSuperview()
                    self.postAnnouncementVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
    func searchByDates(strtDate: String? = nil, frmDate: String? = nil, duration: String?) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = GeneralAnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: "asc", limit: 10, offset: listArrays.count), memberAnnouncement: GeneralAnnouncement(memberAnnouncementId: nil, startDate: strtDate, fromDate: frmDate, duration: duration))
            let url = "api/MemberAnnouncement/GetAnnouncements"
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.listArrays = responseData.memberAnnouncements ?? []
                    self.tblAnnouncements.reloadData()
                    
                    self.postAnnouncementVC?.willMove(toParent: nil)
                    self.postAnnouncementVC?.view.removeFromSuperview()
                    self.postAnnouncementVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
    func callGetPostAnnouncementApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = GeneralPostAnnouncementRequestModel(source: "2", memberAnnouncement: MemberAnnouncements(title:  self.postAnnouncementVC?.txtEnterTitle.text ?? "", description: self.postAnnouncementVC?.descTextView.text ?? ""))
            let url = "api/MemberAnnouncement/PostAnnouncement"
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.callGetGeneralAnnouncements()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
    func callGetAnnouncementDetailApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = GeneralAnnouncementDetailsRequestModel(source: "2", memberAnnouncement: GeneralAnnouncementDetails(memberAnnouncementId: 0))
            let url = "api/MemberAnnouncement/GetAnnouncementDetail"
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.callGetGeneralAnnouncements()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
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
            self.search?.toAndFromView.isUserInteractionEnabled = false
            self.search?.calenderViewHeight.constant = 50
            self.search?.serachByViewHeight.constant = 20
            
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
            self.search?.calenderViewHeight.constant = 0
            self.search?.serachByViewHeight.constant = 0
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
            self.search?.calenderViewHeight.constant = 0
            self.search?.serachByViewHeight.constant = 0
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
            self.search?.calenderViewHeight.constant = 0
            self.search?.serachByViewHeight.constant = 0
            self.search?.toAndFromView.isUserInteractionEnabled = true
            
        }
        
    }
}
