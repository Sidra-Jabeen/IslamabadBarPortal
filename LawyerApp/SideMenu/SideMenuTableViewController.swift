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
    var arrMenuList = ["Legal Questions Answers","General Announcememts","Bar Council Announcememts","Members Directory","My Profile","Official Directory","Logout"]
    var listImages: [String] = [ "Layer 25", "Notification", "Notification", "21-List-1", "Layer 19", "Path 288", "logout"]
    
    public var delegate: MenuControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblSideMenuList.backgroundColor = tableViewColor
        self.tblSideMenuList.separatorStyle = .none
        self.tblSideMenuList.register(UINib(nibName: "UserNameTableViewCell", bundle: nil), forCellReuseIdentifier: "UserNameTableViewCell")
        self.tblSideMenuList.register(UINib(nibName: "MenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuListTableViewCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListTableViewCell", for: indexPath) as! MenuListTableViewCell
            
            //        cell.imgMenuItem.image = menuListImages[indexPath.row]
            cell.lblMenuItem?.text = arrMenuList[indexPath.row]
            cell.lblMenuItem?.textColor = .white
            cell.imgMenuItem.image = UIImage(named: listImages[indexPath.row])
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
    
    override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 100 : 65
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
}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
