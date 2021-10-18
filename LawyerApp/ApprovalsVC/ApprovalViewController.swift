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
    var swappedViewValue = 1
    
    //MARK: - Propertities
    
    var memberVC: MemberNameViewController?
    var arrayOfMembers = [ResponseUsers]()
    //    var arrayOfMembers = []()
    //    var arrayOfMembers = [String]()
    var selectedTab = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.approvalsCollection.collectionViewLayout = layout
        self.approvalsCollection.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleContentViewGesture))
           leftRecognizer.direction = .left
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleContentViewGesture))
           rightRecognizer.direction = .right
           self.contentView.addGestureRecognizer(leftRecognizer)
           self.contentView.addGestureRecognizer(rightRecognizer)
        self.dataNotFoundView.addGestureRecognizer(leftRecognizer)
        self.dataNotFoundView.addGestureRecognizer(rightRecognizer)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.callGetUsersApi(status: "1")
        self.selectedTab = 1
        self.setLabelColor()
        self.setViewColorLine()
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
    
    @objc func handleContentViewGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            
            self.swappedViewValue -= 1
            self.onTapsClicked(value: self.swappedViewValue)
            
        }
        else if gesture.direction == .left {
            print("Swipe Left")
            self.swappedViewValue += 1
            self.onTapsClicked(value: self.swappedViewValue)
           
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedAll(_sender: UIButton) {
        
        self.onTapsClicked(value: 1)
        
    }
    
    @IBAction func tappedApproved(_sender: UIButton) {
        
        self.onTapsClicked(value: 2)
    }
    
    @IBAction func tappedRejected(_sender: UIButton) {
        
        self.onTapsClicked(value: 3)
    }
    
    @IBAction func tappedInvolved(_sender: UIButton) {
        
        self.onTapsClicked(value: 4)
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
        let url = URL(string: arrayOfMembers[indexPath.item].profileUrl ?? "")
        cell.profileImage.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.memberVC = MemberNameViewController()
        if let member = memberVC {
            
            self.view.addSubview(member.view)
            member.lblMemberName.text = arrayOfMembers[indexPath.item].fullName
            member.lblPhoneNumber.text = arrayOfMembers[indexPath.item].contactNumber
            member.lblLisenceDateOflower.text = arrayOfMembers[indexPath.item].issuanceDateLowerCourt
            member.lblLisenceDateOfHigh.text = arrayOfMembers[indexPath.item].issuanceDateHighCourt
            member.lblLisenceDateOfSupreme.text = arrayOfMembers[indexPath.item].issuanceDateSupremeCourt
            member.lblOfcAddress.text = arrayOfMembers[indexPath.item].officeAddress
            member.memberId = arrayOfMembers[indexPath.item].userId
            let url = URL(string: arrayOfMembers[indexPath.item].profileUrl ?? "")
            member.profileImage.kf.setImage(with: url)
            currentUser = arrayOfMembers[indexPath.item].userId
            adminValue = arrayOfMembers[indexPath.item].isAdmin
            
            if self.selectedTab == 1 {
                member.btnRejected.alpha = 1
                member.btnAccepted.alpha = 1
                member.btnMakeAAdmin.alpha = 0
            }
            
            if self.selectedTab == 2 {
                member.btnRejected.alpha = 0
                member.btnAccepted.alpha = 0
                member.btnMakeAAdmin.alpha = 1
            }
            
            if self.selectedTab == 3 {
                member.btnRejected.alpha = 0
                member.btnAccepted.alpha = 0
                member.btnMakeAAdmin.alpha = 0
            }
            
            member.btnAccepted.addTarget(self, action: #selector(clickedOnAccepted), for: .touchUpInside)
            member.btnRejected.addTarget(self, action: #selector(clickedOndeleted), for: .touchUpInside)
            member.btnMakeAAdmin.addTarget(self, action: #selector(clickedOnMakeAAdmin), for: .touchUpInside)
            
            //            member.approveUsersArray = arrayOfMembers[indexPath.item]
        }
    }
    @objc func clickedOnAccepted() {
        
        self.callUpdateUsersApi(status: "2", id: currentUser ?? 0)

    }
    
    @objc func clickedOndeleted() {
        
        self.callUpdateUsersApi(status: "3", id: currentUser ?? 0)
    }
    
    @objc func clickedOnMakeAAdmin() {
        
        self.callMakeRemoveAdmin(id: currentUser ?? 0, admin: adminValue ?? false)

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
    
    //MARK: - CallAPisFunction
    
    func callGetUsersApi(status: String) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = ApprovalRequestModel(source: "2", Pagination: PaginationModel(orderBy: "asc", limit: 10, offset: 0), user: ApprovalUser(fullName: "", status: status))
            let signUpUrl = "api/User/GetUsers"
            let services = ApprovalServices()
            self.stopAnimation()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.arrayOfMembers = responseData.users ?? []
                    print(self.arrayOfMembers)
                    self.approvalsCollection.reloadData()
                    self.approvalsCollection.isHidden = false
                    self.dataNotFoundView.isHidden = true
                } else {
    //                self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                    self.approvalsCollection.isHidden = true
                    self.dataNotFoundView.isHidden = false
                    self.arrayOfMembers.removeAll()
                }
                
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
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
                let status = responseData.success ?? false
                if status {
                    
                    self.callGetUsersApi(status: "1")
                    self.memberVC?.willMove(toParent: nil)
                    self.memberVC?.view.removeFromSuperview()
                    self.memberVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                    self.arrayOfMembers.removeAll()
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
    func callMakeRemoveAdmin(id: Int, admin: Bool) {
        
        if  Connectivity.isConnectedToInternet {
            startAnimation()
            let dataModel = AdminRequestModel(source: "2", user: RemoveAdminUser(userId: id, isAdmin: admin))
            let signUpUrl = "api/User/MakeRemoveAdmin"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.callGetUsersApi(status: "2")
                    self.memberVC?.willMove(toParent: nil)
                    self.memberVC?.view.removeFromSuperview()
                    self.memberVC?.removeFromParent()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                    self.arrayOfMembers.removeAll()
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
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
