//
//  SideMenuTableViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var tblSideMenuList: UITableView!
    
    var navigation:SideMenuTableViewController?
    let tableViewColor: UIColor = #colorLiteral(red: 0.130608201, green: 0.3541451395, blue: 0.3179354072, alpha: 1)
    var arrMenuList = ["Queries","Member Announcememts","Bar Announcements","Members Directory","Help","My Profile","Official Directory", "Request Approval","Biometric", "Logout"]
    var listImages: [String] = [ "Layer 25", "Notification", "Notification", "21-List-1","Group 253", "Layer 19", "Path 288","listing_search_magnifier_magnifying_glass_loupe","2538673_biometric_finger_fingerprint_identity_thumb_icon", "logout"]
    
    public var delegate: MenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblSideMenuList.backgroundColor = tableViewColor
        self.tblSideMenuList.separatorStyle = .none
        self.tblSideMenuList.register(UINib(nibName: "UserNameTableViewCell", bundle: nil), forCellReuseIdentifier: "UserNameTableViewCell")
        self.tblSideMenuList.register(UINib(nibName: "MenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuListTableViewCell")
        self.tblSideMenuList.register(UINib(nibName: "BiometricTableViewCell", bundle: nil), forCellReuseIdentifier: "BiometricTableViewCell")
        
        let admin = Generic.getAdminValue()
        if admin == "1" {
            self.arrMenuList.remove(at: 7)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.arrMenuList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UserNameTableViewCell", for: indexPath) as! UserNameTableViewCell
            tmpCell.backgroundColor = .clear
            tmpCell.selectionStyle = .none
            return tmpCell
            
        } else {
            if indexPath.row < 8 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListTableViewCell", for: indexPath) as! MenuListTableViewCell
                
                cell.lblMenuItem?.text = arrMenuList[indexPath.row]
                cell.lblMenuItem?.textColor = .white
                cell.imgMenuItem.image = UIImage(named: listImages[indexPath.row])
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
            } else if indexPath.row < 9 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BiometricTableViewCell", for: indexPath) as! BiometricTableViewCell
                
                cell.img.image = UIImage(named: listImages[indexPath.row])
                cell.lbl.text = arrMenuList[indexPath.row]
                cell.bioSwitch.addTarget(self, action: #selector(enabledBiometric), for: .touchUpInside)
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                
                if UserDefaults.standard.string(forKey: "isBiometricLogin") == "1" {
                    
                    cell.bioSwitch.setOn(true, animated: true)
                } else {
                    
                    cell.bioSwitch.setOn(false, animated: true)
                }
                
                return cell
                
            } else  {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListTableViewCell", for: indexPath) as! MenuListTableViewCell
                
                cell.lblMenuItem?.text = arrMenuList[indexPath.row]
                cell.lblMenuItem?.textColor = .white
                cell.imgMenuItem.image = UIImage(named: listImages[indexPath.row])
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
            }
        }
    }
    
    override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else {
            
            let selectedItem = arrMenuList[indexPath.row]
            self.dismiss(animated: true, completion: nil)
            //            self.tblSideMenuList.deselectRow(at: indexPath, animated: true)
            delegate?.didSelectMenuItem(named: selectedItem)
        }
        
        
    }
    
    @objc func enabledBiometric(_ sender: UISwitch) {
        
        if sender.isOn {
            print("ON")
            UserDefaults.standard.set("1", forKey: "isBiometricLogin")
            self.alertForBiometricOff(alertTitle: "Islamabad Bar Connect", alertMessage: "Are You sure you want to enabled Fingerprint Login")

        }
        else {
            print ("OFF")
            UserDefaults.standard.set("0", forKey: "isBiometricLogin")
            self.alertForBiometricOff(alertTitle: "Islamabad Bar Connect", alertMessage: "Are You sure you want to disabled Fingerprint Login")

        }
        
    }
    
    func alertForBiometricOff(alertTitle: String, alertMessage: String) {

        let refreshAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            if UserDefaults.standard.string(forKey: "isBiometricLogin") == "0"{
                
                self.authenticateUserTouchID()
            } else {
                
                self.authenticateUserTouchID()
            }
            
//            UserDefaults.standard.set("0", forKey: "isBiometricLogin")
//            self.tblSideMenuList.reloadData()
          }))
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            UserDefaults.standard.set("1", forKey: "isBiometricLogin")
           
            self.tblSideMenuList.reloadData()
//            UserDefaults.standard.set("0", forKey: "isBiometricLogin")
            
          }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func authenticateUserTouchID() {
        
        BiometricsManager().authenticateUser(completion: { [weak self] (response) in
            switch response {
            case .failure:
               print("Failed")
//                UserDefaults.standard.set("0", forKey: "isBiometricLogin")
                DispatchQueue.main.async {
                    
                    self?.tblSideMenuList.reloadData()
                    self?.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Authentication Failed")
                }
                
            case .success:
                print("Success")
//                UserDefaults.standard.set("1", forKey: "isBiometricLogin")
                UserDefaults.standard.set(strLisenceNo, forKey: "lisenceNumber")
                UserDefaults.standard.set(strPassword, forKey: "password")
                DispatchQueue.main.async {
                    
                    self?.tblSideMenuList.reloadData()
//                    self?.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Authentication Failed")
                }
            }
        })
    }
}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
