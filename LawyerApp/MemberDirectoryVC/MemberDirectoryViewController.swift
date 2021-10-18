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
    var searchVC: SearchFilterViewController?
    var arrayOfMembers = [ResponseUsers]()
    var bitValue = 0
    var bitValueForAscDes = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        self.collectionMembers.collectionViewLayout = layout
        self.collectionMembers.register(UINib(nibName: "MemberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberCollectionViewCell")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.callGetUsersApi(status: "2")
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
            currentUser = arrayOfMembers[indexPath.item].userId
            adminValue = arrayOfMembers[indexPath.item].isAdmin
            member.btnRejected.alpha = 0
            member.btnAccepted.alpha = 0
            member.btnMakeAAdmin.alpha = 0
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
        }
            
    }
    
    @objc func clickedOnAll() {
        
        self.bitValue = 1
        if self.bitValue == 1 {
            
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
        
    }
    
    @objc func clickedOnLowerCourt() {
        
        self.bitValue = 2
        if self.bitValue == 2 {
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
    }
    
    @objc func clickedOnHighCourt() {
        
        self.bitValue = 3
        if self.bitValue == 3 {
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
    }
    
    @objc func clickedOnSupremeCourt() {
        
        self.bitValue = 4
        if self.bitValue == 4 {
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
    
    //MARK: - CallAPisFunction
    
    func callGetUsersApi(status: String) {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = ApprovalRequestModel(source: "2", Pagination: PaginationModel(orderBy: "asc", limit: 10, offset: 0), user: ApprovalUser(fullName: "", status: status))
            let signUpUrl = "api/User/GetUsers"
            let services = ApprovalServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.arrayOfMembers = responseData.users ?? []
                    print(self.arrayOfMembers)
                    self.collectionMembers.reloadData()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
                    self.arrayOfMembers.removeAll()
                }
            }
        } else{
            self.showAlert(alertTitle: "Islamabad Bar Council", alertMessage: "No Internet Connection")
        }

    }
    
    func searchFilterApi() {
        
        self.startAnimation()
        let dataModel = MemberRequestModel(Pagination: PaginationModel(orderBy: "", limit: 10, offset: 0), source: "2", user: MemberUser(fullName: "", licenseType: "", status: "2"))
        let signUpUrl = "api/User/GetUsers"
        let services = ApprovalServices()
        services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
            
            self.stopAnimation()
            let status = responseData.success ?? false
            if status {
                
//                self.arrayOfMembers = responseData.users ?? []
//                print(self.arrayOfMembers)
                self.collectionMembers.reloadData()
            } else {
                self.showAlertForMember(alertTitle: "Islamabad Bar Council", alertMessage: responseData.desc ?? "")
            }
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

}
