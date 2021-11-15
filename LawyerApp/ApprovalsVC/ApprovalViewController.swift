//
//  ApprovalViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import UIKit
import Kingfisher

class ApprovalViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var approvalsCollection: UICollectionView!
    @IBOutlet weak var lblTab1: UILabel!
    @IBOutlet weak var lblTab2: UILabel!
    @IBOutlet weak var lblTab3: UILabel!
    @IBOutlet weak var lblTab4: UILabel!
    
    @IBOutlet weak var viewLine1: UIView!
    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var viewLine3: UIView!
    @IBOutlet weak var viewLine4: UIView!
    @IBOutlet weak var dataNotFoundView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    
    //MARK: - Propertities
    
    var memberVC: MemberNameViewController?
    var profileController: ProfileViewController?
    var arrayOfMembers = [ResponseUsers]()
    var swappedViewValue = 1
    //    var arrayOfMembers = []()
    //    var arrayOfMembers = [String]()
    var currentMemberId: Int?
    var currentAdminStatus: Bool?
    var currentStatus: Int?
    var selectedTab = 0
    var roleIDValue = 3
    var refreshControl: UIRefreshControl?
    var isPageRefreshing:Bool = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.approvalsCollection.collectionViewLayout = layout
        self.approvalsCollection.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
        
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleContentViewGesture))
        leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleContentViewGesture))
        rightRecognizer.direction = .right
        self.contentView.addGestureRecognizer(leftRecognizer)
        self.contentView.addGestureRecognizer(rightRecognizer)
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
//        self.approvalsCollection.addSubview(self.refreshControl!)
//        self.callGetUsersApi(status: "1")
//        self.selectedTab = 1
//        self.setLabelColor()
//        self.setViewColorLine()
        
    }
//
//    @objc func didPullToRefresh() {
//
//        self.arrayOfMembers.removeAll()
//        self.isPageRefreshing = true
//        if self.selectedTab == 1 {
//            self.callGetUsersApi(status: "1")
//
//        } else if self.selectedTab == 2 {
//            self.callGetUsersApi(status: "2")
//
//        } else if self.selectedTab == 3 {
//            self.callGetUsersApi(status: "3")
//
//        } else if self.selectedTab == 4 {
//            self.callGetUsersApi(status: "4")
//        }
//        self.refreshControl?.endRefreshing()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetUsersApi(status: "1")
        self.selectedTab = 1
        self.setLabelColor()
        self.setViewColorLine()
    }
    
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
            if self.swappedViewValue < 5 {
                self.onTapsClicked(value: self.swappedViewValue)
            } else {
                self.swappedViewValue = 4
            }
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedAll(_sender: UIButton) {
        
        
        self.onTapsClicked(value: 1)
        self.selectedTab = 1
    }
    
    @IBAction func tappedApproved(_sender: UIButton) {
        
        self.onTapsClicked(value: 2)
        self.selectedTab = 2
    }
    
    @IBAction func tappedRejected(_sender: UIButton) {
        
        self.onTapsClicked(value: 3)
        self.selectedTab = 3
    }
    
    @IBAction func tappedInvolved(_sender: UIButton) {
        
        self.onTapsClicked(value: 4)
        self.selectedTab = 4
    }
    
    func onTapsClicked(value: Int) {
        self.swappedViewValue = value
        self.selectedTab = value
        self.setLabelColor()
        self.setViewColorLine()
        self.callGetUsersApi(status: "\(value)")
    }
    
    @IBAction func tappedOnBackNavigation(_sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UICollectionViewDelegate&UICollectionViewDataSource
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.memberVC = MemberNameViewController()
        if let member = memberVC {
            
            if self.selectedTab == 1 {
                
//                member.btnGiveApprovementHeight.constant = 0
                
                let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
                profileVC.intUserValue = arrayOfMembers[indexPath.item].userId ?? 0
                profileVC.bitForViewBtns = true
                self.navigationController?.pushViewController(profileVC, animated: true)
                
            } else {
                
                self.view.addSubview(member.view)
                member.lblMemberName.text = arrayOfMembers[indexPath.item].fullName
                member.lblPhoneNumber.text = arrayOfMembers[indexPath.item].contactNumber
                member.lblOfcAddress.text = arrayOfMembers[indexPath.item].officeAddress
                member.memberId = arrayOfMembers[indexPath.item].userId
                let url = URL(string: "\(Constant.imageDownloadURL)\(arrayOfMembers[indexPath.item].profileUrl ?? "")")
                member.profileImage.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
    //            currentUser = arrayOfMembers[indexPath.item].userId
    //            adminValue = arrayOfMembers[indexPath.item].isAdmin
                self.currentMemberId = arrayOfMembers[indexPath.row].userId
                self.currentAdminStatus = arrayOfMembers[indexPath.row].isAdmin
                self.currentStatus = arrayOfMembers[indexPath.row].roleId
                
                
                
                if self.selectedTab == 2 {
                    let adminStatus = arrayOfMembers[indexPath.item].isAdmin ?? false
                    let admin = Generic.getAdminValue()
                    if admin == "0" {
                        if adminStatus {
                            member.btn2.isHidden = false
                            member.btnRejectedHeight.constant = 40
                            member.btn2.setTitle("Remove As Admin", for: .normal)
                        } else {
                            member.btn2.isHidden = false
                            member.btnRejectedHeight.constant = 40
                            member.btn2.setTitle("Make A Admin", for: .normal)
                        }
                    } else {
                        member.btn2.isHidden = true
                        member.btnRejectedHeight.constant = 0
        //                member.btn1.setTitle("Make A Admin", for: .normal)
                    }
//                    if adminStatus {
//                        if adminStatus {
//                            member.btn1.setTitle("Remove As Admin", for: .normal)
//                        } else {
//
//                            member.btn1.setTitle("Make A Admin", for: .normal)
//                        }
//                    } else {
//                        member.btn1.isHidden = true
//                        member.btnApprovedHeight.constant = 0
//                    }
                    
                    if arrayOfMembers[indexPath.row].roleId == self.roleIDValue {
                        member.btn3.setTitle("Remove Bar Announcement Rights", for: .normal)
                        
                    } else {
                        member.btn3.setTitle("Give Bar Announcement Rights", for: .normal)
                    }
                    
                    member.btn1.setTitle("Block", for: .normal)
                }
                
                if self.selectedTab == 3 {
                    
                    member.btn1.setTitle("Approved", for: .normal)
                    member.btn2.isHidden = true
                    member.btnRejectedHeight.constant = 0
                    member.btnGiveApprovementHeight.constant = 0
                }
                
                if self.selectedTab == 4 {
                    
                    member.btn1.setTitle("Approved", for: .normal)
                    member.btn2.isHidden = true
                    member.btnRejectedHeight.constant = 0
                    member.btnGiveApprovementHeight.constant = 0
                }
                
                member.btn1.addTarget(self, action: #selector(clickedOnAButton1), for: .touchUpInside)
                member.btn2.addTarget(self, action: #selector(clickedOnAButton2), for: .touchUpInside)
                member.btn3.addTarget(self, action: #selector(clickedOnAButton3), for: .touchUpInside)
                //            member.btnMakeAAdmin.addTarget(self, action: #selector(clickedOnMakeAAdmin), for: .touchUpInside)
                //            member.btnRemoveAdmin.addTarget(self, action: #selector(clickedOnRemoveAAdmin), for: .touchUpInside)
                //            member.approveUsersArray = arrayOfMembers[indexPath.item]
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        collectionView.addLoading(indexPath) {
//
//            if self.selectedTab == 1 {
//                self.callGetUsersApi(status: "1")
//
//            } else if self.selectedTab == 2 {
//                self.callGetUsersApi(status: "2")
//
//            } else if self.selectedTab == 3 {
//                self.callGetUsersApi(status: "3")
//
//            } else if self.selectedTab == 4 {
//                self.callGetUsersApi(status: "4")
//            }
////            self.callGetUsersApi(status: "2")
//            collectionView.stopLoading() // stop your indicator
//        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if(self.approvalsCollection.contentOffset.y >= (self.approvalsCollection.contentSize.height - self.approvalsCollection.bounds.size.height)) {
            if !isPageRefreshing {
//                isPageRefreshing = true
                self.arrayOfMembers.removeAll()
                if self.selectedTab == 1 {
                    self.callGetUsersApi(status: "1")
                    
                } else if self.selectedTab == 2 {
                    self.callGetUsersApi(status: "2")
                    
                } else if self.selectedTab == 3 {
                    self.callGetUsersApi(status: "3")
                    
                } else if self.selectedTab == 4 {
                    self.callGetUsersApi(status: "4")
                }
            }
        }
    }
    
    @objc func clickedOnAButton1() {
        
        if self.selectedTab == 1 {
            
            self.callUpdateUsersApi(status: "2", id: self.currentMemberId ?? 0)
            
        } else if self.selectedTab == 2 {
            
//            self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: !(self.currentAdminStatus ?? false))
            self.callUpdateUsersApi(status: "4", id: self.currentMemberId ?? 0)
            
        } else if self.selectedTab == 3 {
            
            self.callUpdateUsersApi(status: "2", id: self.currentMemberId ?? 0)
            
        } else if self.selectedTab == 4 {
            
            self.callUpdateUsersApi(status: "2", id: self.currentMemberId ?? 0)
            
        }
    }
    
    @objc func clickedOnAButton2() {
        
        if self.selectedTab == 1 {
            
            self.callUpdateUsersApi(status: "3", id: self.currentMemberId ?? 0)
            
        } else if self.selectedTab == 2 {
            
            self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: !(self.currentAdminStatus ?? false), roleID: nil)
            
//            self.callUpdateUsersApi(status: "4", id: self.currentMemberId ?? 0)
        }
    }
    
    @objc func clickedOnAButton3() {
        
        if self.selectedTab == 2 {
            if self.currentStatus != 3 {
                
                self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, roleID: self.roleIDValue)
            } else {
                
                self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: !(self.currentAdminStatus ?? false), roleID: 1 )
            }
            
        }
    }
    
//    @objc func clickedOnMakeAAdmin() {
//
//        self.callMakeRemoveAdmin(id: self.currentMemberId ?? 0, admin: self.currentAdminStatus ?? false)
//
//    }
    
    //MARK: - CallAPisFunction
    
    func callGetUsersApi(status: String) {
        
        self.arrayOfMembers.removeAll()
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = ApprovalRequestModel(source: "2", Pagination: PaginationModel(orderBy: "desc", limit: 10, offset: self.arrayOfMembers.count), user: ApprovalUser(fullName: nil, cnic: nil, licenseNumber: nil, contactNumber: nil, licenseType: nil, status: status))
            let signUpUrl = "api/User/GetUsers"
            let services = ApprovalServices()
            self.stopAnimation()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
//                self.arrayOfMembers.removeAll()
                if status {
                    if responseData.users?.count != 0 {
                        if self.arrayOfMembers.count > 0 {
                            
                            if let arrayData : [ResponseUsers] = responseData.users {
                                
                                for item in arrayData {
                                    self.arrayOfMembers.append(item)
                                    self.approvalsCollection.reloadData()
                                    self.approvalsCollection.isHidden = false
                                    self.dataNotFoundView.isHidden = true
                                }
                            }
                        } else {
                            self.arrayOfMembers = responseData.users ?? []
                            self.approvalsCollection.reloadData()
                            self.approvalsCollection.isHidden = false
                            self.dataNotFoundView.isHidden = true
                        }
                        
                    }
                    
//                    self.arrayOfMembers = responseData.users ?? []
//                    print(self.arrayOfMembers)
//                    self.approvalsCollection.reloadData()
//                    self.approvalsCollection.isHidden = false
//                    self.dataNotFoundView.isHidden = true
                } else {
                    
                    if responseData.code == "401" {
                        self.showAlertForLogin(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                        return
                    }
                    if self.arrayOfMembers.count == 0 {
                        self.approvalsCollection.isHidden = true
                        self.dataNotFoundView.isHidden = false
                    }
                }
                
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func callUpdateUsersApi(status: String, id: Int) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = AcceptRequestModel(source: "2", user: AcceptUser(status: status, userId: id, reason: "fail"))
            let signUpUrl = "api/User/UpdateUserStatus"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let response = responseData.success ?? false
                if response {
                    if self.selectedTab == 1 {
                        self.callGetUsersApi(status: "1")
                        
                    } else if self.selectedTab == 2 {
                        self.callGetUsersApi(status: "2")
                        
                    } else if self.selectedTab == 3 {
                        self.callGetUsersApi(status: "3")
                        
                    } else if self.selectedTab == 4 {
                        self.callGetUsersApi(status: "4")
                    }
                    
//                    self.arrayOfMembers.removeAll()
                    self.memberVC?.willMove(toParent: nil)
                    self.memberVC?.view.removeFromSuperview()
                    self.memberVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                    //                    self.arrayOfMembers.removeAll()
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
        
    }
    
    func callMakeRemoveAdmin(id: Int? = nil , admin: Bool? = nil , roleID: Int?) {
        
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
                    self.approvalsCollection.reloadData()
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
    
    func setViewColorLine() {
        
        self.viewLine1.backgroundColor = selectedTab == 1 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine2.backgroundColor = selectedTab == 2 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine3.backgroundColor = selectedTab == 3 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine4.backgroundColor = selectedTab == 4 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    func setLabelColor() {
        
        self.lblTab1.textColor = selectedTab == 1 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab2.textColor = selectedTab == 2 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab3.textColor = selectedTab == 3 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab4.textColor = selectedTab == 4 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
    }
    
}
