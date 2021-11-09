//
//  DashboardViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 09/10/2021.
//

import UIKit
import SideMenu
import LocalAuthentication
import Kingfisher
import Alamofire
import MobileCoreServices
import PDFKit

class DashboardViewController: UIViewController, MenuControllerDelegate, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var approvalView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var helpContentView:UIView!
    @IBOutlet weak var imgProfile: UIImageView!

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
    var documentPicker: UIDocumentPickerViewController?
    var pdfFile: URL?
    
//    let kc = KeyChainManager(KeyChain())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
//        self.helpView.applyCircledView()
        
        self.documentPicker?.delegate = self
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
        
//        let url = URL(string: "\(Constant.imageDownloadURL)\(Constant.pdfDownloadUrl)")
//        self.downloadPdf(url: url!, closure: { (file) in
//            self.pdfFile = file
//            print(file)
//        })
        
        let admin = Generic.getAdminValue()
        if admin == "0" {
//            self.approvalView.isHidden = true
        }
//        self.authenticateUserTouchID()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.helpContentView.applyCircledView()
        intForSearchFilter = nil
        intForSetAscDes = nil
        strForFullName = ""
        strFromDate = nil
        strToDate = nil
        strOrderBy = nil
        strName = nil
        strDuration = nil
        self.imgProfile.kf.setImage(with: urlProfile, placeholder: UIImage(named: "Group 242"))
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
        profileVC.intUserValue = loginUserID ?? 0
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

            else if named == "Member Announcements" {
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
                    controller.intUserValue = loginUserID ?? 0
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
                    
                    let pdfView = PDFView()
                    
                    pdfView.translatesAutoresizingMaskIntoConstraints = false
                    view.addSubview(pdfView)
                    
                    pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
                    pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
                    pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
                    pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                    guard let path = Bundle.main.url(forResource: self.pdfFile?.absoluteString, withExtension: "pdf") else { return }

                    if let document = PDFDocument(url: path) {
                        pdfView.document = document
                    }
//                    setupUI(controller: controller)
//                    let importMenu = UIDocumentPickerViewController(documentTypes: ["\(String(describing: self.pdfFile))", kUTTypePDF as String], in: UIDocumentPickerMode.import)
//                    importMenu.delegate = self
//                    self.present(importMenu, animated: true, completion: nil)
                    
                    
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
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = self.pdfFile else {
            return
        }
        print("import result : \(myURL)")
    }
          

//    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
//    }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func downloadPdf(url: URL, closure : @escaping (URL) -> Void) {
        
        //        let component = url.lastPathComponent
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        //        let url = FileManager.default.temporaryDirectory.appendingPathComponent(component)
//        if url.checkFileExist(){
//            print(url)
//            self.pdfFile = url
//        }
        
//        AF.download(url).responseData { response in
//            print("Temporary URL: \(response.fileURL)")
//        }
        
        AF.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, to: destination).downloadProgress(closure: { (progress) in
            self.startAnimation()
        }).response(completionHandler: { (DefaultDownloadResponse) in
            self.stopAnimation()
            
            switch DefaultDownloadResponse.result {
            case .success:
                let fileUrl = DefaultDownloadResponse.fileURL
                if fileUrl != nil{
                    self.pdfFile = fileUrl
                } else {
                    self.showAlertForDashboard(alertTitle: "Islamabad Bar Connect", alertMessage: "\(String(describing: DefaultDownloadResponse.error?.localizedDescription))")
                }
                
            case .failure:
                
//                if let destinationURL = DefaultDownloadResponse {
//                    if FileManager.default.fileExists(atPath: destinationURL.path){
//                        // File exists, so no need to override it. simply return the path.
//                        self.pdfFile = destinationURL
//                    }else {
////                        onError(error.localizedDescription)
////                        assertionFailure()
//                    }
//                }
                self.showAlertForDashboard(alertTitle: "Islamabad Bar Connect", alertMessage: "\(String(describing: DefaultDownloadResponse.error?.localizedDescription))")
                break
            }
            
            
        })
        
        //        let fileManager = FileManager.default
        //        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //
        //        AF.request(url).downloadProgress(closure : { (progress) in
        //            print(progress.fractionCompleted)
        //
        //        }).responseData{ (response) in
        //            print(response)
        //            print(response.result.value!)
        //            print(response.result.description)
        //            let randomString = NSUUID().uuidString
        //            if let data = response.result.value {
        //
        //                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //                let videoURL = documentsURL.appendingPathComponent("\(randomString)")
        //                do {
        //                    try data.write(to: videoURL)
        //
        //                } catch {
        //                    print("Something went wrong!")
        //                }
        //
        //            }
        //        }
        //        }
    }
    

    
    func showAlertForDashboard(alertTitle : String, alertMessage : String) {
    let alert = UIAlertController(title: "Islmabad Bar Connect", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert in
    }))
    self.present(alert, animated: true, completion: nil)
    }
}

