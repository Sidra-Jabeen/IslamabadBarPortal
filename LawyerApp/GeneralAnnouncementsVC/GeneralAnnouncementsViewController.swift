//
//  GeneralAnnouncementsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import SwiftUI

class GeneralAnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,SearchFilterController, UITableViewDataSourcePrefetching {
    
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
    var currentPage : Int = 0
    var totalPage : Int = 0
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    
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
        self.tblAnnouncements.prefetchDataSource = self
        self.callGetGeneralAnnouncements()
        if roleId == 3 {
            
            self.viewPostButton.isHidden = false
        }
//        self.tblAnnouncements.tableFooterView = UIView()
//        self.activityIndicator = LoadMoreActivityIndicator(scrollView: tableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
    
    //MARK: - RefreshMethod
    
    @objc func didPullToRefresh() {
        
        self.listArrays.removeAll()
        self.callGetGeneralAnnouncements()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        FileManager.default.clearTmpDirectory()
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
        
        
//        if indexPath.row == self.listArrays.count {
//                self.callGetGeneralAnnouncements()
//            }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // need to pass your indexpath then it showing your indicator at bottom
           tableView.addLoading(indexPath) {
               // add your code here
               // append Your array and reload your tableview
               self.callGetGeneralAnnouncements()
               tableView.stopLoading() // stop your indicator
           }
        
//        if indexPath.row == self.listArrays.count-1 {
//                    print("came to last row")
//            self.callGetGeneralAnnouncements()
//        }
//        let lastItem = self.listArrays.count - 1
//        if indexPath.row == lastItem {
//            print("IndexRow\(indexPath.row)")
//            self.totalPage = self.listArrays.count
//            if currentPage < totalPage {
//                currentPage += 1
//               //Get data from Server
//                self.callGetGeneralAnnouncements()
//            }
//        }
//        self.callGetQuestionApi()
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//            print("prefetchdRowsAtIndexpath \(indexPaths)")
        }

        func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//            print("cancelPrefetchingForRowsAtIndexpath \(indexPaths)")
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
                    if responseData.memberAnnouncements?.count != 0 {
                        if self.listArrays.count > 0 {
                            
                            if let arrayData : [GeneralAnnouncementResponseModel] = responseData.memberAnnouncements {
                                
                                for item in arrayData {
                                    self.listArrays.append(item)
                                    self.tblAnnouncements.reloadData()
                                    self.dataNotFoundView.isHidden = true
                                    self.tableView.isHidden = false
                                }
                            }
                        } else {
                            self.listArrays = responseData.memberAnnouncements ?? []
                            self.tblAnnouncements.reloadData()
                            self.dataNotFoundView.isHidden = true
                            self.tableView.isHidden = false
                        }
                    
                    }
                        
                } else {
                    if self.listArrays.count == 0 {
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
            let dataModel = GeneralAnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: order, limit: 10, offset: 0), memberAnnouncement: GeneralAnnouncement(memberAnnouncementId: nil, toDate: toDate, fromDate: fromDate, duration: duration))
            let url = Constant.memGetAnnounceEP
            let services = GeneralAnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
//                    if responseData.memberAnnouncements?.count != 0 {
//                        if self.listArrays.count > 0 {
//                            
//                            if let arrayData : [GeneralAnnouncementResponseModel] = responseData.memberAnnouncements {
//                                
//                                for item in arrayData {
//                                    self.listArrays.append(item)
//                                    self.tblAnnouncements.reloadData()
//                                    self.search?.dismiss(animated: true)
//                                    self.dataNotFoundView.isHidden = true
//                                    self.tableView.isHidden = false
//                                }
//                            }
//                        } else {
//                            self.listArrays = responseData.memberAnnouncements ?? []
//                            self.tblAnnouncements.reloadData()
//                            self.search?.dismiss(animated: true)
//                            self.dataNotFoundView.isHidden = true
//                            self.tableView.isHidden = false
//                        }
//                    
//                    }
                    self.listArrays.removeAll()
                    self.listArrays = responseData.memberAnnouncements ?? []
                    self.tblAnnouncements.reloadData()
                    self.search?.dismiss(animated: true)
                    self.dataNotFoundView.isHidden = true
                    self.tableView.isHidden = false
                    
                } else {
//                    if self.listArrays.count == 0 {
                       
                        self.search?.dismiss(animated: true)
                        self.dataNotFoundView.isHidden = false
                        self.tableView.isHidden = true
//                    }
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
}

extension UITableView {

    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        //    indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
    }

    func stopLoading() {
        print("stopLoading")
        //    if self.tableFooterView != nil {
        //        self.indicatorView().stopAnimating()
        //        self.tableFooterView = nil
        //    }
        //    else {
        //        self.tableFooterView = nil
        //    }
    }
}
