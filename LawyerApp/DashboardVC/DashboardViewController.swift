//
//  DashboardViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit
import SideMenu
import LocalAuthentication

class DashboardViewController: UIViewController, MenuControllerDelegate {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var approvalView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var mainhelpView:UIView!

    var sideMenu: SideMenuTableViewController?
    var menu: SideMenuNavigationController?
    var navController: UINavigationController?
    var isFingerLogin = false
    var strLisenceNo = ""
    var password = ""
    var homeController: DashboardViewController?
    var legalQuestionsAnswers: LegalQuestionsAnswersViewController?
    var generalAnnouncements: GeneralAnnouncementsViewController?
    var barCouncil: BarCouncilViewController?
    var memberDirectory: MemberDirectoryViewController?
    var profileController: ProfileViewController?
    var officialDirectory: OfficialDirectoryViewController?
    var requestApproval: ApprovalViewController?
    
//    let kc = KeyChainManager(KeyChain())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.helpView.applyCircledView()
        self.helpView.applyCircledView()
        
        self.sideMenu = SideMenuTableViewController()
        if let list = sideMenu {
            
            list.delegate = self
            self.menu = SideMenuNavigationController(rootViewController: list)
            self.menu?.leftSide = false
            self.menu?.setNavigationBarHidden(true, animated: true)
            self.menu?.menuWidth = view.bounds.width * 0.9
            SideMenuManager.default.leftMenuNavigationController = menu
            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
            
        }
        
        if UserDefaults.standard.string(forKey: "isBiometricLogin") == nil {
            
            let alert = UIAlertController(title: "Islamabad Bar Connect", message: "Do you want to enabled Finger ID", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { alert in
                self.dismiss(animated: true, completion: nil)
                self.authenticateUserTouchID()
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { alert in
                
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)

        }
        
        
        let admin = Generic.getAdminValue()
        if admin == "0" {
//            self.approvalView.isHidden = true
        }
//        self.authenticateUserTouchID()
        
    }
    
    func authenticateUserTouchID() {
        
        BiometricsManager().authenticateUser(completion: { [weak self] (response) in
            switch response {
            case .failure:
               print("Failed")
                UserDefaults.standard.set("0", forKey: "isBiometricLogin")
                self?.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "Authentication Failed")
            case .success:
                print("Success")
                UserDefaults.standard.set("1", forKey: "isBiometricLogin")
                UserDefaults.standard.set(self?.strLisenceNo, forKey: "lisenceNumber")
                UserDefaults.standard.set(self?.password, forKey: "password")
            }
        })
    }
    
    @IBAction func showSideMenu() {
        
        present(menu!, animated: true)
    }
    
    @IBAction func tappedOnApproval( _sender: UIButton) {
        
        let approveVC = ApprovalViewController(nibName: "ApprovalViewController", bundle: nil)
        self.navigationController?.pushViewController(approveVC, animated: true)
    }
    
    @IBAction func tappedOnProfile( _sender: UIButton) {
        
        let profileVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func tappedOnLegalQuesAns( _sender: UIButton) {
        
        self.legalQuestionsAnswers = LegalQuestionsAnswersViewController()
        if let controller = legalQuestionsAnswers  {
            pushControllers(controller: controller)
        }
    }
    
    @IBAction func tappedOnGeneralAnnouncements( _sender: UIButton) {
        
        self.generalAnnouncements = GeneralAnnouncementsViewController()
        if let controller = generalAnnouncements  {
            pushControllers(controller: controller)
        }
    }
    
    @IBAction func tappedOnAnnouncements( _sender: UIButton) {
        
        self.barCouncil = BarCouncilViewController()
        if let controller = barCouncil  {
            pushControllers(controller: controller)
        }
    }
    
    @IBAction func tappedOnMembersDirectory( _sender: UIButton) {
        
        self.memberDirectory = MemberDirectoryViewController()
        if let controller = memberDirectory  {
            pushControllers(controller: controller)
        }
    }
    
    func didSelectMenuItem(named: String) {
            if named == "Queries" {
                legalQuestionsAnswers = LegalQuestionsAnswersViewController()
                if let controller = legalQuestionsAnswers  {
                    setupUI(controller: controller)
                }
                
                if let controller = generalAnnouncements {
                    removeViewController(controller: controller)
                    generalAnnouncements = nil
                }
                
                if let controller = memberDirectory {
                    removeViewController(controller: controller)
                    memberDirectory = nil
                }
                
                if let controller = profileController {
                    removeViewController(controller: controller)
                    profileController = nil
                }
                
                if let controller = officialDirectory {
                    removeViewController(controller: controller)
                    officialDirectory = nil
                }
                
                if let controller = homeController {
                    removeViewController(controller: controller)
                    homeController = nil
                }
                
                if let controller = barCouncil {
                    removeViewController(controller: controller)
                    barCouncil = nil
                }
                
                if let controller = requestApproval {
                    removeViewController(controller: controller)
                    requestApproval = nil
                }

            }

            else if named == "Member Announcememts" {
                generalAnnouncements = GeneralAnnouncementsViewController()
                if let controller = generalAnnouncements  {
                    setupUI(controller: controller)
                }

                if let controller = legalQuestionsAnswers {
                    removeViewController(controller: controller)
                    legalQuestionsAnswers = nil
                }

                if let controller = memberDirectory {
                    removeViewController(controller: controller)
                    memberDirectory = nil
                }

                if let controller = profileController {
                    removeViewController(controller: controller)
                    profileController = nil
                }

                if let controller = officialDirectory {
                    removeViewController(controller: controller)
                    officialDirectory = nil
                }
                
                if let controller = homeController {
                    removeViewController(controller: controller)
                    homeController = nil
                }

                if let controller = barCouncil {
                    removeViewController(controller: controller)
                    barCouncil = nil
                }
                
                if let controller = requestApproval {
                    removeViewController(controller: controller)
                    requestApproval = nil
                }

            }
        
        else if named == "Bar Announcements" {
            barCouncil = BarCouncilViewController()
            if let controller = barCouncil  {
                    setupUI(controller: controller)
            }

            if let controller = legalQuestionsAnswers {
                removeViewController(controller: controller)
                legalQuestionsAnswers = nil
            }
            
            if let controller = generalAnnouncements {
                removeViewController(controller: controller)
                generalAnnouncements = nil
            }

            if let controller = memberDirectory {
                removeViewController(controller: controller)
                memberDirectory = nil
            }

            if let controller = profileController {
                removeViewController(controller: controller)
                profileController = nil
            }

            if let controller = officialDirectory {
                removeViewController(controller: controller)
                officialDirectory = nil
            }
            
            if let controller = homeController {
                removeViewController(controller: controller)
                homeController = nil
            }

            if let controller = requestApproval {
                removeViewController(controller: controller)
                requestApproval = nil
            }

        }


            else if named == "Members Directory" {
                memberDirectory = MemberDirectoryViewController()
                if let controller = memberDirectory  {
                    setupUI(controller: controller)
                }
                
                if let controller = legalQuestionsAnswers {
                    removeViewController(controller: controller)
                    legalQuestionsAnswers = nil
                }
                
                if let controller = generalAnnouncements {
                    removeViewController(controller: controller)
                    generalAnnouncements = nil
                }
                
                if let controller = profileController {
                    removeViewController(controller: controller)
                    profileController = nil
                }
                
                if let controller = officialDirectory {
                    removeViewController(controller: controller)
                    officialDirectory = nil
                }
                
                if let controller = homeController {
                    removeViewController(controller: controller)
                    homeController = nil
                }
                
                if let controller = barCouncil {
                    removeViewController(controller: controller)
                    barCouncil = nil
                }
                
                if let controller = requestApproval {
                    removeViewController(controller: controller)
                    requestApproval = nil
                }

            }

            else if named == "My Profile" {
                profileController = ProfileViewController()
                if let controller = profileController  {
                    setupUI(controller: controller)
                }
                
                if let controller = legalQuestionsAnswers {
                    removeViewController(controller: controller)
                    legalQuestionsAnswers = nil
                }
                
                if let controller = generalAnnouncements {
                    removeViewController(controller: controller)
                    generalAnnouncements = nil
                }
                
                if let controller = memberDirectory {
                    removeViewController(controller: controller)
                    memberDirectory = nil
                }
                
                if let controller = officialDirectory {
                    removeViewController(controller: controller)
                    officialDirectory = nil
                }
                
                if let controller = homeController {
                    removeViewController(controller: controller)
                    homeController = nil
                }
                
                if let controller = barCouncil {
                    removeViewController(controller: controller)
                    barCouncil = nil
                }
                
                if let controller = requestApproval {
                    removeViewController(controller: controller)
                    requestApproval = nil
                }

            }

            else if named == "Official Directory" {
                officialDirectory = OfficialDirectoryViewController()
                if let controller = officialDirectory  {
                    setupUI(controller: controller)
                }
                
                if let controller = legalQuestionsAnswers {
                    removeViewController(controller: controller)
                    legalQuestionsAnswers = nil
                }
                
                if let controller = generalAnnouncements {
                    removeViewController(controller: controller)
                    generalAnnouncements = nil
                }
                
                if let controller = memberDirectory {
                    removeViewController(controller: controller)
                    memberDirectory = nil
                }
                
                if let controller = profileController {
                    removeViewController(controller: controller)
                    profileController = nil
                }
                
                if let controller = homeController {
                    removeViewController(controller: controller)
                    homeController = nil
                }
                
                if let controller = barCouncil {
                    removeViewController(controller: controller)
                    barCouncil = nil
                }
                
                if let controller = requestApproval {
                    removeViewController(controller: controller)
                    requestApproval = nil
                }
            }
        
        else if named == "Request Approval" {
            requestApproval = ApprovalViewController()
            if let controller = requestApproval  {
                setupUI(controller: controller)
            }
            
            if let controller = legalQuestionsAnswers {
                removeViewController(controller: controller)
                legalQuestionsAnswers = nil
            }
            
            if let controller = generalAnnouncements {
                removeViewController(controller: controller)
                generalAnnouncements = nil
            }
            
            if let controller = memberDirectory {
                removeViewController(controller: controller)
                memberDirectory = nil
            }
            
            if let controller = profileController {
                removeViewController(controller: controller)
                profileController = nil
            }
            
            if let controller = homeController {
                removeViewController(controller: controller)
                homeController = nil
            }
            
            if let controller = barCouncil {
                removeViewController(controller: controller)
                barCouncil = nil
            }
            
            if let controller = officialDirectory {
                removeViewController(controller: controller)
                officialDirectory = nil
            }
        }
        
         else if named == "Logout"  {
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func removeViewController(controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        controller.view.removeFromSuperview()
    }
    
    private func setupUI(controller: UIViewController) {
        
        self.homeController = DashboardViewController()
        if homeController != nil {
            
            self.menu?.pushViewController(controller, animated: false)
            self.navController?.pushViewController(controller, animated: true)
        }

    }

    func pushControllers(controller: UIViewController) {
        
        self.navigationController?.pushViewController(controller, animated: true)
        
//        self.homeController = DashboardViewController()
//        if homeController != nil {
//            
//            self.menu?.pushViewController(controller, animated: false)
//            self.navController?.pushViewController(controller, animated: true)
//        }

    }

}
