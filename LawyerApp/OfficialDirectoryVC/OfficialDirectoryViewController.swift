//
//  OfficialDirectoryViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class OfficialDirectoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblDirectories: UITableView!
    @IBOutlet weak var btnAddDirectory: UIButton!
    
    var officialListArray = [OfficialDirectoryResponseModel]()
    var addOfficialDirectory: AddOfficialDirectoryViewController?
    var searchVC: SearchFilterViewController?
    var bitValueForAscDes = 0
    var strValue = ""
    var strTextValue = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAddDirectory.layer.cornerRadius = self.btnAddDirectory.frame.size.height / 2
        self.tblDirectories.register(UINib(nibName: "OfficialDirectoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OfficialDirectoryTableViewCell")
        self.tblDirectories.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
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

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetOfficialDirectoryApi()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.officialListArray.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "OfficialDirectoryTableViewCell", for: indexPath) as! OfficialDirectoryTableViewCell
            tmpCell.layer.shadowOffset = CGSize(width: 0,height: 0)
            tmpCell.layer.shadowColor = UIColor.black.cgColor
            tmpCell.layer.shadowOpacity = 0.25
            tmpCell.layer.shadowRadius = 4
            tmpCell.lblMemberName.text = officialListArray[indexPath.row].fullName
            tmpCell.lblCourtName.text = officialListArray[indexPath.row].memberOff
            tmpCell.lblContactNumber.text = officialListArray[indexPath.row].contactNumber
            tmpCell.btnphone.tag = indexPath.row
            tmpCell.btnphone.addTarget(self, action: #selector(clickedOnPhone), for: .touchUpInside)
            return tmpCell
            
        } else {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
            return tmpCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 { return 60 } else { return 80  }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
            if indexPath.row == lastRowIndex - 1 {
                tableView.scrollToBottom(animated: true)
            }
        }
    
    func reloadData(){
        self.tblDirectories.reloadData()
        let scrollPoint = CGPoint(x: 0, y: self.tblDirectories.contentSize.height - self.tblDirectories.frame.size.height)
        self.tblDirectories.setContentOffset(scrollPoint, animated: true)
    }
    
    @objc func clickedOnPhone(_ sender: UIButton) {
        
//        let strNumber = officialListArray[sender.tag].contactNumber
//        UIApplication.shared.openURL(NSURL(string: "03035851389")! as URL)
//        UIApplication.shared.openURL(NSURL(string: "telprompt://\(strNumber))")! as URL)
        
        if let phoneCallURL:URL = URL(string:"tel://\(officialListArray[sender.tag].contactNumber ?? "")") {
                    let application:UIApplication = UIApplication.shared
                    if (application.canOpenURL(phoneCallURL)) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil);
                    }
                }
    }

    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
     
    @IBAction func tappedOnSearchFilter( _sender: UIButton) {
        
        self.searchVC = SearchFilterViewController()
        if let search = searchVC {
            
            self.view.addSubview(search.view)
            
            search.allButtonsView.isHidden = true
            search.btnAscending.addTarget(self, action: #selector(clickedOnAscending), for: .touchUpInside)
            search.btndescending.addTarget(self, action: #selector(clickedOndescending), for: .touchUpInside)
            
            search.btnSearch.addTarget(self, action: #selector(clickedOnSearch), for: .touchUpInside)
            search.txtName.text = self.strTextValue
            if self.bitValueForAscDes == 1 {
                self.searchVC?.imgAsc.image = UIImage(named: "Group 247")
                self.searchVC?.imgDes.image = UIImage(named: "Circle")
            } else {
                
                self.searchVC?.imgDes.image = UIImage(named: "Group 247")
                self.searchVC?.imgAsc.image = UIImage(named: "Circle")
            }
        }
        
    }
    
    @objc func clickedOnAscending() {
        
        self.bitValueForAscDes = 1
        if self.bitValueForAscDes == 1 {
            self.searchVC?.imgAsc.image = UIImage(named: "Group 247")
            self.searchVC?.imgDes.image = UIImage(named: "Circle")
        }
    }
    
    @objc func clickedOndescending() {
        
        self.bitValueForAscDes = 2
        if self.bitValueForAscDes == 2 {
            self.searchVC?.imgDes.image = UIImage(named: "Group 247")
            self.searchVC?.imgAsc.image = UIImage(named: "Circle")
        }
    }
    
    @objc func clickedOnSearch() {
        
        self.searchFilterApi()
    }
    
    @IBAction func tappedOnAdd( _sender: UIButton) {
        
        self.addOfficialDirectory = AddOfficialDirectoryViewController()
        if let officialDirectory = self.addOfficialDirectory {
            
            self.view.addSubview(officialDirectory.view)
            officialDirectory.btnAdd.addTarget(self, action: #selector(onClickedAdd), for: .touchUpInside)
            
        }
    }
    
    @objc func onClickedAdd() {
        
        callAddOfficialDirectoryApi()
    }
    
    func callGetOfficialDirectoryApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            
            
            let dataModel = OfficialDirectoryRequestModel(source: "2", pagination: PaginationModel(orderBy: "", limit: 10, offset: self.officialListArray.count), OfficialDirectory: OfficialModel(fullName: nil, designation: nil, officeAddress: nil, contactNumber: nil, memberOff: nil))
            let url = "api/OfficialDirectory/GetOfficialContacts"
            let services = OfficialDirectoryServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.officialListArray = responseData.officialDirectoryList ?? []
                    self.tblDirectories.reloadData()

//                    self.postAnnouncementVC?.willMove(toParent: nil)
//                    self.postAnnouncementVC?.view.removeFromSuperview()
//                    self.postAnnouncementVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    func callAddOfficialDirectoryApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = OfficialDirectoryRequestModel(source: "2", pagination: PaginationModel(orderBy: "", limit: 10, offset: 0), OfficialDirectory: OfficialModel(fullName: addOfficialDirectory?.txtFullName.text, designation: addOfficialDirectory?.txtDesignation.text, officeAddress: addOfficialDirectory?.txtOfficeAddress.text, contactNumber: addOfficialDirectory?.txtContactNumber.text, memberOff: "1,2,3"))
            let url = "api/OfficialDirectory/AddOfficialContact"
            let services = OfficialDirectoryServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.callGetOfficialDirectoryApi()

                    self.addOfficialDirectory?.willMove(toParent: nil)
                    self.addOfficialDirectory?.view.removeFromSuperview()
                    self.addOfficialDirectory?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func searchFilterApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            if bitValueForAscDes == 1 {
                self.strValue = "asc"
            } else {
                self.strValue = "des"
            }
            
            self.strTextValue = self.searchVC?.txtName.text ?? ""
            let dataModel = OfficialDirectoryRequestModel(source: "2", pagination: PaginationModel(orderBy: self.strValue, limit: 10, offset: 0), OfficialDirectory: OfficialModel(fullName: self.strTextValue, designation: nil, officeAddress: nil, contactNumber: nil, memberOff: nil))
            let url = "api/OfficialDirectory/GetOfficialContacts"
            let services = OfficialDirectoryServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.officialListArray = responseData.officialDirectoryList ?? []
                    self.tblDirectories.reloadData()

                    self.searchVC?.willMove(toParent: nil)
                    self.searchVC?.view.removeFromSuperview()
                    self.searchVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
}

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .middle, animated: true)
        }
    }
}
