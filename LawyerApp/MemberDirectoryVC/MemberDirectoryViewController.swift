//
//  MemberDirectoryViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import Kingfisher

class MemberDirectoryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionMembers: UICollectionView!
    
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var collectionView: UIView!
    
    var memberVC: MemberNameViewController?
    var searchVC: SearchFilterViewController?
    var arrayOfMembers = [ResponseUsers]()
    var bitValue = 1
    var bitValueForAscDes = 0
    var strValue = ""
    var fullName = ""
    var currentMemberId: Int?
    var currentAdminStatus: Bool?
    var currentStatus: Int?
    var roleIDValue = 3
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.collectionMembers.collectionViewLayout = layout
        self.collectionMembers.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.collectionMembers.addSubview(self.refreshControl!)
        self.callGetUsersApi(status: "2")
    }
    
    
    
    @objc func didPullToRefresh() {
        
        self.arrayOfMembers.removeAll()
        self.callGetUsersApi(status: "2")
        self.refreshControl?.endRefreshing()
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
        
//        self.callGetUsersApi(status: "2")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        cell.layer.shadowOffset = CGSize(width: 0,height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowRadius = 4
        cell.lblMemberName.text = arrayOfMembers[indexPath.item].fullName
        cell.lblCourtName.text = arrayOfMembers[indexPath.item].licenseType
        let url = URL(string: "\(Constant.imageDownloadURL)\(arrayOfMembers[indexPath.item].profileUrl ?? "")")
        
        cell.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.memberVC = MemberNameViewController()
        if let member = memberVC {
            
            self.view.addSubview(member.view)
            member.lblMemberName.text = arrayOfMembers[indexPath.item].fullName
            member.lblPhoneNumber.text = arrayOfMembers[indexPath.item].contactNumber
//            member.lblLisenceDateOflower.text = arrayOfMembers[indexPath.item].issuanceDateLowerCourt
//            member.lblLisenceDateOfHigh.text = arrayOfMembers[indexPath.item].issuanceDateHighCourt
//            member.lblLisenceDateOfSupreme.text = arrayOfMembers[indexPath.item].issuanceDateSupremeCourt
            member.lblOfcAddress.text = arrayOfMembers[indexPath.item].officeAddress
            member.memberId = arrayOfMembers[indexPath.item].userId
            currentUser = arrayOfMembers[indexPath.item].userId
            adminValue = arrayOfMembers[indexPath.item].isAdmin
            let url = URL(string: "\(Constant.imageDownloadURL)\(arrayOfMembers[indexPath.item].profileUrl ?? "")")
            member.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
//            member.btn1.isHidden = true
            member.btn2.isHidden = true
            member.btn3.isHidden = true
            if arrayOfMembers[indexPath.item].isAdmin ?? false {
                member.btn1.setTitle("Remove As Admin", for: .normal)
            } else {
                member.btn1.setTitle("Make A Admin", for: .normal)
            }
            member.btnRejectedHeight.constant = 0
//            member.btnApprovedHeight.constant = 0
            member.btnGiveApprovementHeight.constant = 0
            self.currentMemberId = arrayOfMembers[indexPath.row].userId
            self.currentAdminStatus = arrayOfMembers[indexPath.row].isAdmin
            self.currentStatus = arrayOfMembers[indexPath.row].roleId
            member.btn1.addTarget(self, action: #selector(clickedOnAButton1), for: .touchUpInside)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCollectionView = collectionView.bounds.width
        return CGSize(width: widthCollectionView/2 , height: widthCollectionView/2.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func clickedOnAButton1() {
        
        self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: !(self.currentAdminStatus ?? false))
        
//        if self.currentStatus != 3 {
//
//            self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, roleID: self.roleIDValue)
//        } else {
//
//            self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: !(self.currentAdminStatus ?? false), roleID: 1 )
//        }
    }

    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchFilter( _sender: UIButton) {
        
        self.searchVC = SearchFilterViewController()
        if let search = searchVC {
            
            self.view.addSubview(search.view)
            search.btnAll.addTarget(self, action: #selector(clickedOnAll), for: .touchUpInside)
            search.btnLowerCourt.addTarget(self, action: #selector(clickedOnLowerCourt), for: .touchUpInside)
            search.btnHighCourt.addTarget(self, action: #selector(clickedOnHighCourt), for: .touchUpInside)
            search.btnSupremeCourt.addTarget(self, action: #selector(clickedOnSupremeCourt), for: .touchUpInside)
            
            search.btnAscending.addTarget(self, action: #selector(clickedOnAscending), for: .touchUpInside)
            search.btndescending.addTarget(self, action: #selector(clickedOndescending), for: .touchUpInside)
            
            search.btnSearch.addTarget(self, action: #selector(clickedOnSearch), for: .touchUpInside)
            search.txtName.text = self.fullName
            if self.bitValue == 1 {
                
                self.setUpButtonsUI(value: self.bitValue)
                
            } else if self.bitValue == 2 {
                
                self.setUpButtonsUI(value: self.bitValue)
                
            } else if self.bitValue == 3 {
                
                self.setUpButtonsUI(value: self.bitValue)
                
            } else if self.bitValue == 4 {
                
                self.setUpButtonsUI(value: self.bitValue)
                
            }
            
            if self.bitValueForAscDes == 1 {
                self.searchVC?.imgAsc.image = UIImage(named: "Group 247")
                self.searchVC?.imgDes.image = UIImage(named: "Circle")
            } else {
                
                self.searchVC?.imgDes.image = UIImage(named: "Group 247")
                self.searchVC?.imgAsc.image = UIImage(named: "Circle")
            }
        }
            
    }
    
    @objc func clickedOnAll() {
        
        self.bitValue = 1
        self.setUpButtonsUI(value: self.bitValue)
        
    }
    
    @objc func clickedOnLowerCourt() {
        
        self.bitValue = 2
        self.setUpButtonsUI(value: self.bitValue)
    }
    
    @objc func clickedOnHighCourt() {
        
        self.bitValue = 3
        self.setUpButtonsUI(value: self.bitValue)
    }
    
    @objc func clickedOnSupremeCourt() {
        
        self.bitValue = 4
        self.setUpButtonsUI(value: self.bitValue)
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
        
        self.fullName = self.searchVC?.txtName.text ?? ""
        if self.bitValue == 1 {
            
            self.searchFilterApi(fullName: self.fullName)
            
        } else if self.bitValue == 2 {
            
            self.searchFilterApi(fullName: self.fullName, lisenseType: "3")
            
        } else if self.bitValue == 3 {
            
            self.searchFilterApi(fullName: self.fullName, lisenseType: "2")
            
        } else if self.bitValue == 4 {
            
            self.searchFilterApi(fullName: self.fullName, lisenseType: "1")
            
        }
    }
    
    //MARK: - CallAPisFunction
    
    func callGetUsersApi(status: String) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = ApprovalRequestModel(source: "2", Pagination: PaginationModel(orderBy: "desc", limit: 10, offset: 0), user: ApprovalUser(fullName: nil, cnic: nil, licenseNumber: nil, contactNumber: nil, licenseType: nil, status: "2"))
            let signUpUrl = "api/User/GetUsers"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
                
                if status {
                    
                    self.arrayOfMembers = responseData.users ?? []
                    print(self.arrayOfMembers)
                    self.noDataFoundView.isHidden = true
                    self.collectionView.isHidden = false
                    self.collectionMembers.reloadData()
                } else {
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    self.noDataFoundView.isHidden = false
                    self.collectionView.isHidden = true
//                    self.arrayOfMembers.removeAll()
                }
            }
        } else{
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    func searchFilterApi(fullName: String, lisenseType: String? = nil) {
        
        if bitValueForAscDes == 1 {
            self.strValue = "asc"
        } else {
            self.strValue = "desc"
        }
        
        self.startAnimation()
        let dataModel = MemberRequestModel(Pagination: PaginationModel(orderBy: self.strValue, limit: 10, offset: 0), source: "2", user: MemberUser(fullName: fullName ,cnic: nil, licenseNumber: nil, contactNumber: nil, licenseType: lisenseType, status: "2"))
        let signUpUrl = "api/User/GetUsers"
        let services = ApprovalServices()
        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
            
            self.stopAnimation()
            let status = responseData.success ?? false
            if status {
                
                self.arrayOfMembers = responseData.users ?? []
                print(self.arrayOfMembers)
                self.searchVC?.willMove(toParent: nil)
                self.searchVC?.view.removeFromSuperview()
                self.searchVC?.removeFromParent()
                self.noDataFoundView.isHidden = true
                self.collectionView.isHidden = false
                self.collectionMembers.reloadData()
            } else {
//                self.showAlertForMember(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                self.searchVC?.willMove(toParent: nil)
                self.searchVC?.view.removeFromSuperview()
                self.searchVC?.removeFromParent()
                self.noDataFoundView.isHidden = false
                self.collectionView.isHidden = true
            }
        }
    }
    
    func callMakeRemoveAdmin(id: Int? = nil , admin: Bool? = nil , roleID: Int? = nil) {
        
        if  Connectivity.isConnectedToInternet {
            startAnimation()
            let dataModel = AdminRequestModel(source: "2", user: RemoveAdminUser(userId: id ?? 0, isAdmin: admin ?? false, roleId: roleID))
            let signUpUrl = "api/User/MakeRemoveAdmin"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
//                    self.arrayOfMembers.removeAll()
                    self.callGetUsersApi(status: "2")
                    self.collectionMembers.reloadData()
                    self.memberVC?.willMove(toParent: nil)
                    self.memberVC?.view.removeFromSuperview()
                    self.memberVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    
    func showAlertForMember(alertTitle : String, alertMessage : String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
            self.searchVC?.willMove(toParent: nil)
            self.searchVC?.view.removeFromSuperview()
            self.searchVC?.removeFromParent()
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpButtonsUI(value: Int) {
        
        if value == 1 {
            
            self.searchVC?.btnAll.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.searchVC?.btnAll.setTitleColor( UIColor.white, for: .normal)
            self.searchVC?.btnLowerCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnLowerCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnHighCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnHighCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnSupremeCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnSupremeCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnAllView.removeBorderColorToView()
            self.searchVC?.btnLowerView.applyCircledView()
            self.searchVC?.btnLowerView.setBorderColorToView()
            self.searchVC?.btnHighView.applyCircledView()
            self.searchVC?.btnHighView.setBorderColorToView()
            self.searchVC?.btnSupremeView.applyCircledView()
            self.searchVC?.btnSupremeView.setBorderColorToView()
            
        }
        else if value == 2 {
            
            self.searchVC?.btnLowerCourt.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.searchVC?.btnLowerCourt.setTitleColor( UIColor.white, for: .normal)
            self.searchVC?.btnAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnHighCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnHighCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnSupremeCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnSupremeCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnLowerView.removeBorderColorToView()
            self.searchVC?.btnAllView.applyCircledView()
            self.searchVC?.btnAllView.setBorderColorToView()
            self.searchVC?.btnHighView.applyCircledView()
            self.searchVC?.btnHighView.setBorderColorToView()
            self.searchVC?.btnSupremeView.applyCircledView()
            self.searchVC?.btnSupremeView.setBorderColorToView()
        }
        else if value == 3 {
            
            self.searchVC?.btnHighCourt.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.searchVC?.btnHighCourt.setTitleColor( UIColor.white, for: .normal)
            self.searchVC?.btnLowerCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnLowerCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnSupremeCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnSupremeCourt.setTitleColor( UIColor.lightGray, for: .normal)
//            self.searchVC?.btnSearchView.setCornerRadiusToView()
//            self.searchVC?.btnSearchView.setBorderColorToView()
            self.searchVC?.btnHighView.removeBorderColorToView()
            self.searchVC?.btnAllView.applyCircledView()
            self.searchVC?.btnAllView.setBorderColorToView()
            self.searchVC?.btnLowerView.applyCircledView()
            self.searchVC?.btnLowerView.setBorderColorToView()
            self.searchVC?.btnSupremeView.applyCircledView()
            self.searchVC?.btnSupremeView.setBorderColorToView()
        }
        else if value == 4 {
            
            self.searchVC?.btnSupremeCourt.backgroundColor = #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1)
            self.searchVC?.btnSupremeCourt.setTitleColor( UIColor.white, for: .normal)
            self.searchVC?.btnLowerCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnLowerCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnHighCourt.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnHighCourt.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnAll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.searchVC?.btnAll.setTitleColor( UIColor.lightGray, for: .normal)
            self.searchVC?.btnSupremeView.removeBorderColorToView()
            self.searchVC?.btnAllView.applyCircledView()
            self.searchVC?.btnAllView.setBorderColorToView()
            self.searchVC?.btnHighView.applyCircledView()
            self.searchVC?.btnHighView.setBorderColorToView()
            self.searchVC?.btnLowerView.applyCircledView()
            self.searchVC?.btnLowerView.setBorderColorToView()
        }
    }

}
