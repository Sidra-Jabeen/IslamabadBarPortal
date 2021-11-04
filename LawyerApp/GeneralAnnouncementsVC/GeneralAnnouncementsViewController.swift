//
//  GeneralAnnouncementsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import SwiftUI

class GeneralAnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,SearchFilterController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tblAnnouncements: UITableView!
    
    @IBOutlet weak var viewPostButton: UIView!
    @IBOutlet weak var dataNotFoundView: UIView!
    @IBOutlet weak var tableView: UIView!
    
    
    //MARK: - Propertities
    
    var search: SearchForBarCouncilViewController?
    var postAnnouncementVC: PostAnnouncementViewController?
    var postAttachmentVC: PostAttachmentViewController?
    var announcementsVC:AnnouncementViewController?
    var listArrays = [GeneralAnnouncementResponseModel]()
    var intValue = 0
    var bitValueForAscDes = 0
    var strValue = ""
    let date = Date()
    let formatter = DateFormatter()
    var toDateText = ""
    var fromDateText = ""
    var refreshControl: UIRefreshControl?
    
    //MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblAnnouncements.register(UINib(nibName: "GeneralAnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralAnnouncementTableViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                swipeLeft.direction = .right
                self.view.addGestureRecognizer(swipeLeft)
        self.viewPostButton.setCornerRadiusToView()
        self.navigationController?.isNavigationBarHidden = true
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        self.tblAnnouncements.addSubview(self.refreshControl!)
        self.callGetGeneralAnnouncements()
        if roleId == 3 {
            
            self.viewPostButton.isHidden = false
        }
    }
    
    //MARK: - RefreshMethod
    
    @objc func didPullToRefresh() {
        
        self.listArrays.removeAll()
        self.callGetGeneralAnnouncements()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.callGetGeneralAnnouncements()
    }
    
    //MARK: - HandGestureFunction
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    //MARK: - UITableViewDelegate,UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "GeneralAnnouncementTableViewCell", for: indexPath) as! GeneralAnnouncementTableViewCell

        tmpCell.lblAnounceTitle.text = listArrays[indexPath.row].title
        tmpCell.lblAnounceAt.text = listArrays[indexPath.row].announcedAt
        tmpCell.lblAnounceBy.text = listArrays[indexPath.row].announcedBy
        tmpCell.lblType.text = listArrays[indexPath.row].typeNames
        let url = URL(string: "\(Constant.imageDownloadURL)\(listArrays[indexPath.item].announcedByProfile ?? "")")
        tmpCell.userImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
        tmpCell.selectionStyle = .none
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tblAnnouncements.deselectRow(at: indexPath, animated: true)
        self.announcementsVC = AnnouncementViewController()
        if let vc = announcementsVC {
            vc.userId = listArrays[indexPath.row].memberAnnouncementId
            vc.bitValue = true
            vc.barTitle = "General Announcements"
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    //MARK: - IBActions
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnPostAnnouncement( _sender: UIButton) {
        
        let postVC = PostAttachmentViewController(nibName: "PostAttachmentViewController", bundle: nil)
        postVC.height = 0
        postVC.strTitle = "General Announcements"
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    @IBAction func tappedOnSearchAnnouncement( _sender: UIButton) {
        
        self.search = SearchForBarCouncilViewController()
        if let searchVC = search {

            searchVC.modalPresentationStyle = .overCurrentContext
            searchVC.modalTransitionStyle = .crossDissolve
            searchVC.delegate = self
            self.present(searchVC, animated: true, completion: nil)

        }
    }
    
//    func selectedDateTextfield(startDate: String, endDate: String) {
//
//        self.toDateText = startDate
//        self.fromDateText = endDate
//    }
    
    //MARK: - CallingApisFunctions
    
    func callGetGeneralAnnouncements() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            
            
            let dataModel = GeneralAnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: "desc", limit: 10, offset: listArrays.count), memberAnnouncement: nil)
            let url = Constant.memGetAnnounceEP
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.listArrays = responseData.memberAnnouncements ?? []
                    self.tblAnnouncements.reloadData()
                    self.dataNotFoundView.isHidden = true
                    self.tableView.isHidden = false
                } else {
                    self.dataNotFoundView.isHidden = false
                    self.tableView.isHidden = true
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    func selectedDateTextfield(fromDate: String, toDate: String, duration: String?, order: String) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = GeneralAnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: order, limit: 10, offset: 0), memberAnnouncement: GeneralAnnouncement(memberAnnouncementId: nil, toDate: toDate, fromDate: fromDate, duration: duration))
            let url = Constant.memGetAnnounceEP
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
//                    self.listArrays.removeAll()
                    self.listArrays = responseData.memberAnnouncements ?? []
                    self.tblAnnouncements.reloadData()
                    self.search?.dismiss(animated: true)
                    self.dataNotFoundView.isHidden = true
                    self.tableView.isHidden = false
                    
                } else {
                    
                    self.search?.dismiss(animated: true)
                    self.dataNotFoundView.isHidden = false
                    self.tableView.isHidden = true
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
                self.strValue = "desc"
            }
            let dataModel = GeneralAnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: self.strValue, limit: 10, offset: 0), memberAnnouncement: GeneralAnnouncement(memberAnnouncementId: nil, toDate: strtDate, fromDate: frmDate, duration: duration))
            let url = Constant.memGetAnnounceEP
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
//                    self.listArrays.removeAll()
                    self.listArrays = responseData.memberAnnouncements ?? []
                    self.tblAnnouncements.reloadData()
                    self.search?.dismiss(animated: true)
                    self.dataNotFoundView.isHidden = true
                    self.tableView.isHidden = false
//                    self.search?.willMove(toParent: nil)
//                    self.search?.view.removeFromSuperview()
//                    self.search?.removeFromParent()
                } else {
                    self.dataNotFoundView.isHidden = false
                    self.tableView.isHidden = true
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
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
//            self.search?.toAndFromView.isUserInteractionEnabled = false
            
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
//            self.search?.toAndFromView.isUserInteractionEnabled = false
            
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
//            self.search?.toAndFromView.isUserInteractionEnabled = false
            
        }
        
    }
}
