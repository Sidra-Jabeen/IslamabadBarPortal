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
    
    @IBOutlet weak var lblTab1: UILabel!
    @IBOutlet weak var lblTab2: UILabel!
    @IBOutlet weak var lblTab3: UILabel!
    
    @IBOutlet weak var viewLine1: UIView!
    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var viewLine3: UIView!
    
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
    var selectedTab = 0
    var swappedViewValue = 1
    var isPageRefreshing:Bool = false
//    var roleIDValue = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.collectionMembers.collectionViewLayout = layout
        self.collectionMembers.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
//        swipeLeft.direction = .right
//
//        self.view.addGestureRecognizer(swipeLeft)
//        self.onTapsClicked(value: 1)
        self.selectedTab = 1
        self.setLabelColor()
        self.setViewColorLine()
        self.callGetUsersApi(status: "2", name: nil, lisenceType: "1", order: nil)
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleContentViewGesture))
        leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleContentViewGesture))
        rightRecognizer.direction = .right
        self.collectionView.addGestureRecognizer(leftRecognizer)
        self.collectionView.addGestureRecognizer(rightRecognizer)
        
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
//        self.collectionMembers.addSubview(self.refreshControl!)
        
    }
    
    
    
//    @objc func didPullToRefresh() {
//
//        self.arrayOfMembers.removeAll()
//        self.isPageRefreshing = true
//        if self.selectedTab == 1 {
//            self.callGetUsersApi(status: "2", name: nil, lisenceType: "1", order: nil)
//
//        } else if self.selectedTab == 2 {
//            self.callGetUsersApi(status: "2", name: nil, lisenceType: "2", order: nil)
//
//        } else if self.selectedTab == 3 {
//            self.callGetUsersApi(status: "2", name: nil, lisenceType: "3", order: nil)
//
//        }
//        self.refreshControl?.endRefreshing()
//    }
    
    @objc func handleContentViewGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            
            self.swappedViewValue -= 1
            if self.swappedViewValue < 1 {
                self.navigationController?.popViewController(animated: true)
            } else {
                
                self.onTapsClicked(value: self.swappedViewValue)
            }
            
        }
        else if gesture.direction == .left {
            print("Swipe Left")
            self.swappedViewValue += 1
            if self.swappedViewValue < 4 {
                self.onTapsClicked(value: self.swappedViewValue)
            } else {
                self.swappedViewValue = 4
            }
        }
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
    
    //MARK: - IBActions
    
    @IBAction func tappedLowerCourt(_sender: UIButton) {
        
        
        self.onTapsClicked(value: 1)
        self.selectedTab = 1
    }
    
    @IBAction func tappedHighCourt(_sender: UIButton) {
        
        self.onTapsClicked(value: 2)
        self.selectedTab = 2
    }
    
    @IBAction func tappedSupremeCourt(_sender: UIButton) {
        
        self.onTapsClicked(value: 3)
        self.selectedTab = 3
    }
    
    func onTapsClicked(value: Int) {
        self.arrayOfMembers.removeAll()
        self.swappedViewValue = value
        self.selectedTab = value
        self.setLabelColor()
        self.setViewColorLine()
        self.callGetUsersApi(status: "2", name: nil, lisenceType: "\(value)", order: nil)
//        self.callGetUsersApi(status: "\(value)")
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
            member.lblOfcAddress.text = arrayOfMembers[indexPath.item].officeAddress
            member.memberId = arrayOfMembers[indexPath.item].userId
            currentUser = arrayOfMembers[indexPath.item].userId
            adminValue = arrayOfMembers[indexPath.item].isAdmin
            let url = URL(string: "\(Constant.imageDownloadURL)\(arrayOfMembers[indexPath.item].profileUrl ?? "")")
            member.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
            member.btn1.isHidden = true
            member.btn2.isHidden = true
            member.btn3.isHidden = true
            member.btnRejectedHeight.constant = 0
            member.btnGiveApprovementHeight.constant = 0
            member.btnApprovedHeight.constant = 0
            let adminStatus = arrayOfMembers[indexPath.item].isAdmin
            let admin = Generic.getAdminValue()
            if admin == "0" {
                if adminStatus ?? false {
                    member.btn1.isHidden = false
                    member.btnApprovedHeight.constant = 40
                    member.btn1.setTitle("Remove As Admin", for: .normal)
                } else {
                    member.btn1.isHidden = false
                    member.btnApprovedHeight.constant = 40
                    member.btn1.setTitle("Make A Admin", for: .normal)
                }
            } else {
                member.btn1.isHidden = true
                member.btnApprovedHeight.constant = 0
//                member.btn1.setTitle("Make A Admin", for: .normal)
            }
//            if adminStatus ?? false {
//                if adminStatus ?? false {
//                    member.btn1.isHidden = false
//                    member.btnApprovedHeight.constant = 40
//                    member.btn1.setTitle("Remove As Admin", for: .normal)
//                } else {
//                    member.btn1.isHidden = false
//                    member.btnApprovedHeight.constant = 40
//                    member.btn1.setTitle("Make A Admin", for: .normal)
//                }
//            } else {
//                member.btn1.isHidden = true
//                member.btnApprovedHeight.constant = 0
////                member.btn1.setTitle("Make A Admin", for: .normal)
//            }
            
//            member.btnApprovedHeight.constant = 0
            
            self.currentMemberId = arrayOfMembers[indexPath.row].userId
            self.currentAdminStatus = arrayOfMembers[indexPath.row].isAdmin
            self.currentStatus = arrayOfMembers[indexPath.row].roleId
            member.btn1.addTarget(self, action: #selector(clickedOnAButton1), for: .touchUpInside)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCollectionView = collectionView.bounds.width
        return CGSize(width: widthCollectionView/2 , height: widthCollectionView/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        if indexPath.row == self.arrayOfMembers.count - 1 {  //numberofitem count
//            updateNextSet()
//        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if(self.collectionMembers.contentOffset.y >= (self.collectionMembers.contentSize.height - self.collectionMembers.bounds.size.height)) {
//            if !isPageRefreshing {
//                isPageRefreshing = true
//                if self.selectedTab == 1 {
//                    self.callGetUsersApi(status: "2", name: nil, lisenceType: "1", order: nil)
//
//                } else if self.selectedTab == 2 {
//                    self.callGetUsersApi(status: "2", name: nil, lisenceType: "2", order: nil)
//
//                } else if self.selectedTab == 3 {
//                    self.callGetUsersApi(status: "2", name: nil, lisenceType: "3", order: nil)
//
//                }
//            }
//        }
//    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if(self.collectionMembers.contentOffset.y >= (self.collectionMembers.contentSize.height - self.collectionMembers.bounds.size.height)) {
            if !isPageRefreshing {
//                isPageRefreshing = true
                self.arrayOfMembers.removeAll()
                if self.selectedTab == 1 {
                    self.callGetUsersApi(status: "2", name: nil, lisenceType: "1", order: nil)
                    
                } else if self.selectedTab == 2 {
                    self.callGetUsersApi(status: "2", name: nil, lisenceType: "2", order: nil)
                    
                } else if self.selectedTab == 3 {
                    self.callGetUsersApi(status: "2", name: nil, lisenceType: "3", order: nil)
                    
                }
            }
        }
    }
    
    func updateNextSet(){
           print("On Completetion")
        if self.selectedTab == 1 {
            self.callGetUsersApi(status: "2", name: nil, lisenceType: "1", order: nil)
            
        } else if self.selectedTab == 2 {
            self.callGetUsersApi(status: "2", name: nil, lisenceType: "2", order: nil)
            
        } else if self.selectedTab == 3 {
            self.callGetUsersApi(status: "2", name: nil, lisenceType: "3", order: nil)
            
        }
           //requests another set of data (20 more items) from the server.
    }
    
    @objc func clickedOnAButton1() {
        
        self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: !(self.currentAdminStatus ?? false))
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
            search.btnClear.addTarget(self, action: #selector(clickedOnClear), for: .touchUpInside)
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
    
    @objc func clickedOnClear() {
        
        self.searchVC?.txtName.text = ""
        self.bitValueForAscDes = 2
        if self.bitValueForAscDes == 2 {
            self.searchVC?.imgDes.image = UIImage(named: "Group 247")
            self.searchVC?.imgAsc.image = UIImage(named: "Circle")
        }
    }
    
    @objc func clickedOnSearch() {
        
        self.arrayOfMembers.removeAll()
        self.fullName = self.searchVC?.txtName.text ?? ""
        if bitValueForAscDes == 1 {
            self.strValue = "asc"
        } else {
            self.strValue = "desc"
        }
        if self.selectedTab == 1 {
            self.callGetUsersApi(status: "2", name: self.fullName, lisenceType: "1", order: self.strValue)
//            self.searchFilterApi(fullName: self.fullName)
            
        } else if self.selectedTab == 2 {
            self.callGetUsersApi(status: "2", name: self.fullName, lisenceType: "2", order: self.strValue)
//            self.searchFilterApi(fullName: self.fullName, lisenseType: "3")
            
        } else if self.selectedTab == 3 {
            self.callGetUsersApi(status: "2", name: self.fullName, lisenceType: "3", order: self.strValue)
//            self.searchFilterApi(fullName: self.fullName, lisenseType: "2")
            
        }
    }
    
    //MARK: - CallAPisFunction
    
    func callGetUsersApi(status: String, name: String?, lisenceType: String?, order: String?) {
        
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = ApprovalRequestModel(source: "2", Pagination: PaginationModel(orderBy: order ?? "desc", limit: 10, offset: self.arrayOfMembers.count), user: ApprovalUser(fullName: name, cnic: nil, licenseNumber: nil, contactNumber: nil, licenseType: lisenceType, status: "2"))
            let signUpUrl = "api/User/GetUsers"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
                
                if status {
                    if responseData.users?.count != 0 {
                        if self.arrayOfMembers.count > 0 {

                            if let arrayData : [ResponseUsers] = responseData.users {

                                for item in arrayData {
                                    self.arrayOfMembers.append(item)
                                    self.collectionMembers.reloadData()
                                    self.noDataFoundView.isHidden = true
                                    self.collectionMembers.isHidden = false
                                    self.searchVC?.willMove(toParent: nil)
                                    self.searchVC?.view.removeFromSuperview()
                                    self.searchVC?.removeFromParent()
                                }
                            }
                        } else {
                            self.arrayOfMembers = responseData.users ?? []
                            self.collectionMembers.reloadData()
                            self.noDataFoundView.isHidden = true
                            self.collectionMembers.isHidden = false
                            self.searchVC?.willMove(toParent: nil)
                            self.searchVC?.view.removeFromSuperview()
                            self.searchVC?.removeFromParent()
                        }

                    }
//                    self.arrayOfMembers = responseData.users ?? []
//                    print(self.arrayOfMembers)
//                    self.noDataFoundView.isHidden = true
//                    self.collectionView.isHidden = false
//                    self.searchVC?.willMove(toParent: nil)
//                    self.searchVC?.view.removeFromSuperview()
//                    self.searchVC?.removeFromParent()
                } else {
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
//                    if self.arrayOfMembers.count == 0 {
//
//                        self.noDataFoundView.isHidden = false
//                        self.collectionView.isHidden = true
//                    }
                    
                    if responseData.code == "401" {
                        self.showAlertForLogin(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                        return
                    }
                    
                    if self.arrayOfMembers.count == 0 {
                        self.noDataFoundView.isHidden = false
                        self.collectionMembers.isHidden = true
                        self.searchVC?.willMove(toParent: nil)
                        self.searchVC?.view.removeFromSuperview()
                        self.searchVC?.removeFromParent()
                    }
//                    else {
//                        self.noDataFoundView.isHidden = false
//                        self.collectionMembers.isHidden = true
//                        self.searchVC?.willMove(toParent: nil)
//                        self.searchVC?.view.removeFromSuperview()
//                        self.searchVC?.removeFromParent()
//                    }
                }
            }
        } else{
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }

    }
    
    
//    func setViewColorLine(
    
//    func searchFilterApi(fullName: String, lisenseType: String? = nil) {
//        
//        if bitValueForAscDes == 1 {
//            self.strValue = "asc"
//        } else {
//            self.strValue = "desc"
//        }
//        
//        self.startAnimation()
//        let dataModel = MemberRequestModel(Pagination: PaginationModel(orderBy: self.strValue, limit: 10, offset: 0), source: "2", user: MemberUser(fullName: fullName ,cnic: nil, licenseNumber: nil, contactNumber: nil, licenseType: lisenseType, status: "2"))
//        let signUpUrl = "api/User/GetUsers"
//        let services = ApprovalServices()
//        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
//            
//            self.stopAnimation()
//            let status = responseData.success ?? false
//            if status {
//                
////                if responseData.users?.count != 0 {
////                    if self.arrayOfMembers.count > 0 {
////
////                        if let arrayData : [ResponseUsers] = responseData.users {
////
////                            for item in arrayData {
////                                self.arrayOfMembers.append(item)
////                                self.collectionMembers.reloadData()
////                                self.searchVC?.willMove(toParent: nil)
////                                self.searchVC?.view.removeFromSuperview()
////                                self.searchVC?.removeFromParent()
////                                self.noDataFoundView.isHidden = true
////                                self.collectionView.isHidden = false
////                            }
////                        }
////                    } else {
////                        self.arrayOfMembers = responseData.users ?? []
////                        self.searchVC?.willMove(toParent: nil)
////                        self.searchVC?.view.removeFromSuperview()
////                        self.searchVC?.removeFromParent()
////                        self.noDataFoundView.isHidden = true
////                        self.collectionView.isHidden = false
////                        self.collectionMembers.reloadData()
////                    }
////
////                }
//                
//                self.arrayOfMembers = responseData.users ?? []
//                print(self.arrayOfMembers)
//                self.searchVC?.willMove(toParent: nil)
//                self.searchVC?.view.removeFromSuperview()
//                self.searchVC?.removeFromParent()
//                self.noDataFoundView.isHidden = true
//                self.collectionView.isHidden = false
//                self.collectionMembers.reloadData()
//            } else {
////                self.showAlertForMember(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
//                
//                if responseData.code == "401" {
//                    self.showAlertForLogin(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
//                    return
//                }
//                
//                self.searchVC?.willMove(toParent: nil)
//                self.searchVC?.view.removeFromSuperview()
//                self.searchVC?.removeFromParent()
//                self.noDataFoundView.isHidden = false
//                self.collectionView.isHidden = true
//            }
//        }
//    }
    
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
                    
                    self.arrayOfMembers.removeAll()
                    self.callGetUsersApi(status: "2", name: nil, lisenceType: nil, order: nil)
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
    
    func setViewColorLine() {
        
        self.viewLine1.backgroundColor = selectedTab == 1 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine2.backgroundColor = selectedTab == 2 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine3.backgroundColor = selectedTab == 3 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    func setLabelColor() {
        
        self.lblTab1.textColor = selectedTab == 1 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab2.textColor = selectedTab == 2 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab3.textColor = selectedTab == 3 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
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

extension UICollectionView {

    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        if let lastVisibleIndexPath = self.indexPathsForVisibleItems.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfItems(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }
    }

    func stopLoading() {
        print("stopLoading")
    }
}
