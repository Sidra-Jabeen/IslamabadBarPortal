//
//  BarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

class BarCouncilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tblBarCouncilList: UITableView!
    @IBOutlet weak var scrollBar: UIScrollView!
    @IBOutlet weak var HStack: UIStackView!
    
    var search: SearchForBarCouncilViewController?
    var postAnnouncementVC: PostAnnouncementViewController?
    var announcementsVC:AnnouncementViewController?
    var listArrays = [AnnouncementResponseModel]()
    var intValue = 0
    var bitValueForAscDes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblBarCouncilList.register(UINib(nibName: "GeneralAnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralAnnouncementTableViewCell")
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
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
        
        self.callGetAnnouncements()
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "GeneralAnnouncementTableViewCell", for: indexPath) as! GeneralAnnouncementTableViewCell

        tmpCell.lblAnounceTitle.text = listArrays[indexPath.row].title
        tmpCell.lblAnounceAt.text = listArrays[indexPath.row].announcedAt
        tmpCell.lblAnounceBy.text = listArrays[indexPath.row].announcedBy
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.announcementsVC = AnnouncementViewController()
        if let vc = announcementsVC {
            
            vc.strtitle = listArrays[indexPath.row].title
            vc.strdescription = listArrays[indexPath.row].description
            vc.anouncedAt = listArrays[indexPath.row].announcedAt
            vc.anouncedBy = listArrays[indexPath.row].announcedBy
            vc.barTitle = "Bar Announcements"
            self.navigationController?.pushViewController(vc, animated: true)
        }

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
            
        }
    }

    @IBAction func tappedOnPostAnnouncement( _sender: UIButton) {
        
        self.postAnnouncementVC = PostAnnouncementViewController()
        if let postAnnounc = postAnnouncementVC {
            
            self.view.addSubview(postAnnounc.view)
            postAnnounc.btnUpload.addTarget(self, action: #selector(onClickedUpload), for: .touchUpInside)
            
        }
    }
    
    @objc func onClickedUpload() {
        
        self.callGetPostAnnouncementApi()
    }
    
    @objc func onClickedSearch() {
        
//        if bitValueForAscDes == 1  {
//
//            self.searchFilter(order: "asc")
//        } else {
//            self.searchFilter(order: "des")
//        }
        callGetPostAnnouncementApi()
        
    }
    
    @objc func clickedOnAll() {
        
        self.intValue = 1
        if self.intValue == 1 {
            
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
            self.search?.toAndFromView.isHidden = false
            self.search?.calenderViewHeight.constant = 50
            self.search?.serachByViewHeight.constant = 20
            
        }
    }
    
    @objc func clickedOnToday() {
        
        self.intValue = 2
        if self.intValue == 2 {
            
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
            self.search?.toAndFromView.isHidden = true
            
        }
    }
    
    @objc func clickedOnYesterday() {
        
        self.intValue = 3
        if self.intValue == 3 {
            
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
            self.search?.toAndFromView.isHidden = true
            
        }
    }
    
    @objc func clickedOnLastweek() {
        
        self.intValue = 4
        if self.intValue == 4 {
            
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
            self.search?.toAndFromView.isHidden = true
            
        }
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
    
    func callGetAnnouncements() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: "des", limit: 10, offset: listArrays.count), barAnnouncement: BarAnnouncement(duration: ""))
            let url = "api/BarAnnouncement/GetAnnouncements"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    if self.listArrays.count > 0 {
                        if let arrayData : [AnnouncementResponseModel] = responseData.barAnnouncements {
                            
                            for item in arrayData {
                                self.listArrays.append(item)
                            }
                        }
                    } else {
                        self.listArrays = responseData.barAnnouncements ?? []
                    }
                    self.tblBarCouncilList.reloadData()
                    
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
            let dataModel = PostAnnouncementRequestModel(source: "2", barAnnouncement: Announcement(title: self.postAnnouncementVC?.titleTextView.text ?? "", description: self.postAnnouncementVC?.descTextView.text ?? ""))
//            let dataModel = PostAnnouncementRequestModel(source: "2", barAnnouncement: Announcement(title: "bar Announcement title", description: "desc"))
            let url = "api/BarAnnouncement/PostAnnouncement"
            let services = AnnouncementServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.listArrays.removeAll()
                    self.callGetAnnouncements()
                    
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
//    func searchFilter(order: String) {
//
//        if  Connectivity.isConnectedToInternet {
//            self.startAnimation()
//
//            if intValue == 1 {
//
//                let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: order, limit: 10, offset: listArrays.count), barAnnouncement: BarAnnouncement(duration: <#T##String#>, params: <#T##[String : Any]#>))
//                let url = "api/BarAnnouncement/GetAnnouncements"
//                let services = AnnouncementServices()
//                services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
//
//                    self.stopAnimation()
//                    let status = responseData.success ?? false
//                    if status {
//                        if self.listArrays.count > 0 {
//                            if let arrayData : [AnnouncementResponseModel] = responseData.barAnnouncements {
//
//                                for item in arrayData {
//                                    self.listArrays.append(item)
//                                }
//                            }
//                        } else {
//                            self.listArrays = responseData.barAnnouncements ?? []
//                        }
//                        self.tblBarCouncilList.reloadData()
//
//                        self.postAnnouncementVC?.willMove(toParent: nil)
//                        self.postAnnouncementVC?.view.removeFromSuperview()
//                        self.postAnnouncementVC?.removeFromParent()
//                    } else {
//                        self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
//                    }
//                }
//            } else {
//
//                let dataModel = AnnouncementRequestModel(source: "2", pagination: PaginationModel(orderBy: order, limit: 10, offset: listArrays.count), barAnnouncement: BarAnnouncement( duration: ""))
//                let url = "api/BarAnnouncement/GetAnnouncements"
//                let services = AnnouncementServices()
//                services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
//
//                    self.stopAnimation()
//                    let status = responseData.success ?? false
//                    if status {
//                        if self.listArrays.count > 0 {
//                            if let arrayData : [AnnouncementResponseModel] = responseData.barAnnouncements {
//
//                                for item in arrayData {
//                                    self.listArrays.append(item)
//                                }
//                            }
//                        } else {
//                            self.listArrays = responseData.barAnnouncements ?? []
//                        }
//                        self.tblBarCouncilList.reloadData()
//
//                        self.postAnnouncementVC?.willMove(toParent: nil)
//                        self.postAnnouncementVC?.view.removeFromSuperview()
//                        self.postAnnouncementVC?.removeFromParent()
//                    } else {
//                        self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
//                    }
//                }
//            }
//
//
//        } else {
//            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
//        }
//
//    }
    
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
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
}
