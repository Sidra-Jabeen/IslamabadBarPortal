//
//  DashboardViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit
import SideMenu

class DashboardViewController: UIViewController, MenuControllerDelegate {
    
    @IBOutlet weak var mainView: UIView!

    var sideMenu: SideMenuTableViewController?
    var menu: SideMenuNavigationController?
    var navController: UINavigationController?
    var homeController: DashboardViewController?
    var legalQuestionsAnswers: LegalQuestionsAnswersViewController?
    var generalAnnouncements: GeneralAnnouncementsViewController?
    var barCouncil: BarCouncilViewController?
    var memberDirectory: MemberDirectoryViewController?
    var profileController: ProfileViewController?
    var officialDirectory: OfficialDirectoryViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
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
            if named == "Legal Questions Answers" {
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

            }

            else if named == "General Announcememts" {
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

            }
        
        else if named == "Bar Council Announcememts" {
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
            }
        
        else  {
            
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
