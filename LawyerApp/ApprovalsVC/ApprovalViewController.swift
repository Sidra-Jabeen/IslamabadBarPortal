//
//  ApprovalViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 12/10/2021.
//

import UIKit

class ApprovalViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - IBOutlets

    @IBOutlet weak var approvalsCollection: UICollectionView!
    @IBOutlet weak var lblTab1: UILabel!
    @IBOutlet weak var lblTab2: UILabel!
    @IBOutlet weak var lblTab3: UILabel!
    @IBOutlet weak var lblTab4: UILabel!
    @IBOutlet weak var lblTab5: UILabel!
    
    @IBOutlet weak var viewLine1: UIView!
    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var viewLine3: UIView!
    @IBOutlet weak var viewLine4: UIView!
    @IBOutlet weak var viewLine5: UIView!
    
    //MARK: - Propertities
    
    var memberVC: MemberNameViewController?
    var arrayOfMembers = [[String: Any]]()
    var selectedTab = 0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.approvalsCollection.collectionViewLayout = layout
        self.approvalsCollection.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
        self.callGetUsersApi()
        self.selectedTab = 1
        self.setLabelColor()
        self.setViewColorLine()
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
       else if gesture.direction == .up {
            print("Swipe Up")
       }
       else if gesture.direction == .down {
            print("Swipe Down")
       }
    }
    
    //MARK: - IBActions
    
    @IBAction func tappedAll(_sender: UIButton) {
        
        self.selectedTab = 1
        self.setLabelColor()
        self.setViewColorLine()
        self.callGetUsersApi()
        
    }
    
    @IBAction func tappedApproved(_sender: UIButton) {
        
        self.selectedTab = 2
        self.setLabelColor()
        self.setViewColorLine()
    }
    
    @IBAction func tappedRejected(_sender: UIButton) {
        
        self.selectedTab = 3
        self.setLabelColor()
        self.setViewColorLine()
    }
    
    @IBAction func tappedInvolved(_sender: UIButton) {
        
        self.selectedTab = 4
        self.setLabelColor()
        self.setViewColorLine()
    }
    
    @IBAction func tappedBlackListed(_sender: UIButton) {
        
        self.selectedTab = 5
        self.setLabelColor()
        self.setViewColorLine()
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
        cell.lblMemberName.text = arrayOfMembers[indexPath.item]["fullName"] as? String ?? ""
        cell.lblCourtName.text = arrayOfMembers[indexPath.item]["licenseType"] as? String ?? ""
//        cell.profileImage.image = arrayOfMembers[indexPath.item]["profileUrl"] as? UIImage ?? #imageLiteral(resourceName: "Lawyer")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.memberVC = MemberNameViewController()
        if let member = memberVC {

            self.view.addSubview(member.view)
            member.lblMemberName.text = arrayOfMembers[indexPath.item]["fullName"] as? String ?? ""
            member.lblPhoneNumber.text = arrayOfMembers[indexPath.item]["contactNumber"] as? String ?? ""
            member.lblLisenceDateOflower.text = arrayOfMembers[indexPath.item]["issuanceDateLowerCourt"] as? String ?? ""
            member.lblLisenceDateOfHigh.text = arrayOfMembers[indexPath.item]["issuanceDateHighCourt"] as? String ?? ""
            member.lblLisenceDateOfSupreme.text = arrayOfMembers[indexPath.item]["issuanceDateSupremeCourt"] as? String ?? ""
            member.lblOfcAddress.text = arrayOfMembers[indexPath.item]["officeAddress"] as? String ?? ""
//            member.approveUsersArray = arrayOfMembers[indexPath.item]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCollectionView = collectionView.bounds.width
        return CGSize(width: widthCollectionView/2 , height: widthCollectionView/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - CallAPisFunction
    
    func callGetUsersApi() {
        
        let dataModel = ApprovalRequestModel(source: "2", user: ApprovalUser(fullName: "", cnic: "", licenseNumber: "", contactNumber: "", email: "", licenseType: "", status: "0"))
        let signUpUrl = "api/User/GetUsers"
        let services = SignUpServices()
        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
            print(responseData)
            if let members = responseData["users"] as? [[String: Any]] {
             self.arrayOfMembers = members
                print(self.arrayOfMembers)
                self.approvalsCollection.reloadData()
            }
        }
    }
    
    func setViewColorLine() {
        
        self.viewLine1.backgroundColor = selectedTab == 1 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine2.backgroundColor = selectedTab == 2 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine3.backgroundColor = selectedTab == 3 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine4.backgroundColor = selectedTab == 4 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.viewLine5.backgroundColor = selectedTab == 5 ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    func setLabelColor() {
        
        self.lblTab1.textColor = selectedTab == 1 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab2.textColor = selectedTab == 2 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab3.textColor = selectedTab == 3 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab4.textColor = selectedTab == 4 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.lblTab5.textColor = selectedTab == 5 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
    }
}
