//
//  MemberDirectoryViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class MemberDirectoryViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionMembers: UICollectionView!
    
    var memberVC: MemberNameViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.collectionMembers.collectionViewLayout = layout
        self.collectionMembers.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        cell.layer.shadowOffset = CGSize(width: 0,height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowRadius = 4
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.memberVC = MemberNameViewController()
        if let member = memberVC {

            self.view.addSubview(member.view)
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

    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
//    func getUserDirectory() {
//        
//        let dataModel = MemberDirectoryRequestModel(source: "2", user: GetUsers(fullName: "", cnic: "", licenseNumber: "", contactNumber: "", email: "", licenseType: "", status: "0"))
//        
//        let memberDirectory = "api/User/GetUsers"
//        
//        let services = MemberDirectoryService()
//        services.postMethod(urlString: memberDirectory, dataModel: dataModel.params) { (responseData) in
//            print(responseData)
//            UserDefaults.standard.set("TEST", forKey: "Key")
//            
//            
//            let response = MenberDirectoryResponeModel(code: responseData["code"] as? String ?? "", desc: responseData["code"] as? String ?? "", success: responseData["success"] as? String ?? "", user: memberDirectoryUser(userId: responseData["userId"] as? Int ?? 0, fullName: responseData["fullName"] as? String ?? "", cnic: responseData["cnic"] as? String ?? "", dob: responseData["dob"] as? String ?? "", licenseNumber: responseData[""], contactNumber: <#T##String#>, licenseType: <#T##String#>, issuanceDateLowerCourt: <#T##String#>, issuanceDateHighCourt: <#T##String#>, issuanceDateSupremeCourt: <#T##String#>, officeAddress: <#T##String#>, profileUrl: <#T##String#>, isAdmin: <#T##Bool#>) )
//            
//            
//            (code: responseData["code"] as? String ?? "", desc: responseData["code"] as? String ?? "", success: responseData["success"] as? String ?? "", user: responseUser(userId:  responseData["code"] as? Int ?? 0 , loginToken:  responseData["loginToken"] as? String ?? "", isAdmin:  (responseData["code"] as? Bool ?? false)))
//            
//            print(response)
//            let user = responseData["user"] as? [String: Any]
//            let usertoken = user?["loginToken"]
//            Generic.setToken(token: usertoken as? String ?? "")
//            print(responseData["success"] ?? "")
//            let id = responseData["success"] as? Bool ?? false
//            if id {
//                
//                        let dashboardVC = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
//                        self.navigationController?.pushViewController(dashboardVC, animated: true)
//            }
//        }
//    }
//    
    
    
}
