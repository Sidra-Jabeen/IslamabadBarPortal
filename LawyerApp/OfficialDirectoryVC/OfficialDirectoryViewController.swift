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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAddDirectory.layer.cornerRadius = self.btnAddDirectory.frame.size.height / 2
        self.tblDirectories.register(UINib(nibName: "OfficialDirectoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OfficialDirectoryTableViewCell")
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
        
        return self.officialListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "OfficialDirectoryTableViewCell", for: indexPath) as! OfficialDirectoryTableViewCell
        tmpCell.layer.shadowOffset = CGSize(width: 0,height: 0)
        tmpCell.layer.shadowColor = UIColor.black.cgColor
        tmpCell.layer.shadowOpacity = 0.25
        tmpCell.layer.shadowRadius = 4
        tmpCell.lblMemberName.text = officialListArray[indexPath.row].fullName
        tmpCell.lblCourtName.text = officialListArray[indexPath.row].memberOff
        tmpCell.lblContactNumber.text = officialListArray[indexPath.row].contactNumber
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    

    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
     
    @IBAction func tappedOnSearchFilter( _sender: UIButton) {
        
        
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
            
            
            let dataModel = OfficialDirectoryRequestModel(source: "2", pagination: PaginationModel(orderBy: "", limit: 10, offset: 0), OfficialDirectory: OfficialModel(fullName: nil, designation: nil, officeAddress: nil, contactNumber: nil, memberOff: nil))
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
                    self.officialListArray = responseData.officialDirectoryList ?? []
                    self.tblDirectories.reloadData()

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
}
