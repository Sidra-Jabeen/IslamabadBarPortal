//
//  LegalQuestionsAnswersViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import SideMenu
import Kingfisher

class LegalQuestionsAnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate, BackToQuestionVC {
    
    
    @IBOutlet weak var tblQuesAnswers: UITableView!
    @IBOutlet weak var viewPostQuesBtn: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var noDataFoundView: UIView!
    
    var navController: UINavigationController?
    var postAQuesVC: PostAQuestionViewController?
    var commentsVC: CommentsViewController?
    var arrayOfQueries = [QuesResponseModel]()
    var bitForSearchFilter = true
    
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewPostQuesBtn.setCornerRadiusToView()
        self.tblQuesAnswers.register(UINib(nibName: "QuestionAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionAnswerTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
        self.txtSearch.delegate = self
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
        self.callGetQuestionApi()
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.tblQuesAnswers.addSubview(self.refreshControl!)
    }
    

    @objc func didPullToRefresh() {
        
        self.arrayOfQueries.removeAll()
        self.txtSearch.text = ""
        self.bitForSearchFilter = true
        self.callGetQuestionApi()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        self.callGetQuestionApi()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayOfQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "QuestionAnswerTableViewCell", for: indexPath) as! QuestionAnswerTableViewCell
//        tmpCell.layer.shadowOffset = CGSize(width: 0,height: 0)
//        tmpCell.layer.shadowColor = UIColor.black.cgColor
//        tmpCell.layer.shadowOpacity = 0.25
//        tmpCell.layer.shadowRadius = 4
        if arrayOfQueries.count != 0 {
            tmpCell.lblUsr.text = arrayOfQueries[indexPath.row].postedBy
            tmpCell.lblTime.text = arrayOfQueries[indexPath.row].postedAt
            tmpCell.lblAnswer.text = arrayOfQueries[indexPath.row].censoredTitle
            tmpCell.lblQuestion.text = arrayOfQueries[indexPath.row].censoredDescription
            tmpCell.lblTotalComments.text = arrayOfQueries[indexPath.row].totalComments
            let url = URL(string: "\(Constant.imageDownloadURL)\(arrayOfQueries[indexPath.item].postedByProfileUrl ?? "")")
            tmpCell.img.kf.setImage(with: url, placeholder: UIImage(named: "Group 242"))
            tmpCell.selectionStyle = .none
        }
        
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let vC = CommentsViewController(nibName: "CommentsViewController", bundle: nil)
//        self.navigationController?.pushViewController(vC, animated: true)
        
        self.tblQuesAnswers.deselectRow(at: indexPath, animated: true)
        self.commentsVC = CommentsViewController()
        if let vc = commentsVC {
            vc.questionId = arrayOfQueries[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           tableView.addLoading(indexPath) {
               
               if self.bitForSearchFilter {
                   self.callGetQuestionApi()
               }
//               self.bitForSearchFilter = false
               tableView.stopLoading() // stop your indicator
           }
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tappedOnPostAQues( _sender: UIButton) {
        
        let postVC = PostAQuestionViewController(nibName: "PostAQuestionViewController", bundle: nil)
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    @IBAction func tappedOnSearch( _sender: UIButton) {
        
        self.addAnimations(view: self.searchView, options: UIView.AnimationOptions.transitionCurlDown, duration: 0.5, delay: 0.25)
    }
    
    
    func callGetQuestionsApi() {
        
        self.arrayOfQueries.removeAll()
        self.callGetQuestionApi()
    }
    
    //MARK: - TouchScreenFunction
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view == self.searchView
        {
            self.searchView.alpha = 0
//            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc func onClickCancel() {
        
        self.postAQuesVC?.removeFromParent()
        self.postAQuesVC?.view.removeFromSuperview()
    }
    
    @objc func clickedOnPostAQuestion() {
//        self.callGetPostQuestionApi()
    }
    
    func callGetQuestionApi() {
            
            if  Connectivity.isConnectedToInternet {
                self.startAnimation()
                let dataModel = QuestionRequestModel(source: "2", pagination: PaginationModel(orderBy: "desc", limit: 10, offset: arrayOfQueries.count))
                let signUpUrl = Constant.getQuestionsEP
                let services = QuestionServices()
                services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                    
                    self.stopAnimation()
                    let status = responseData.success ?? false
                    if status {
                        
                        if responseData.questions?.count != 0 {
                            if self.arrayOfQueries.count > 0 {
                                
                                if let arrayData : [QuesResponseModel] = responseData.questions {
                                    
                                    for item in arrayData {
                                        self.arrayOfQueries.append(item)
                                        self.tblQuesAnswers.reloadData()
    //                                    self.searchView.alpha = 0
                                        self.noDataFoundView.isHidden = true
                                        self.tblQuesAnswers.isHidden = false
                                    }
                                }
                            } else {
                                self.arrayOfQueries = responseData.questions ?? []
                                self.tblQuesAnswers.reloadData()
    //                            self.searchView.alpha = 0
                                self.noDataFoundView.isHidden = true
                                self.tblQuesAnswers.isHidden = false
                            }
                        
                        }
                        
    //                    self.arrayOfQueries = responseData.questions ?? []
    //                    print(self.arrayOfQueries)
    //                    self.tblQuesAnswers.reloadData()
    //                    self.noDataFoundView.isHidden = true
    //                    self.tblQuesAnswers.isHidden = false
                    } else {
                        
                        if responseData.code == "401" {
                            self.showAlertForLogin(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                            return
                        }
                        
                        if self.arrayOfQueries.count == 0 {
                            self.searchView.alpha = 0
                            self.noDataFoundView.isHidden = false
                            self.tblQuesAnswers.isHidden = true
                        }
    //                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
    //                    self.noDataFoundView.isHidden = false
    //                    self.tblQuesAnswers.isHidden = true
                    }
                }} else {
                    
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
                }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        self.callSearchQuestionApi()
       return true
    }
    
    func callSearchQuestionApi() {
        
//        self.arrayOfQueries.removeAll()
        self.bitForSearchFilter = false
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let lisenceNo = UserDefaults.standard.string(forKey: "lisenceNumber") ?? ""
            let password = UserDefaults.standard.string(forKey: "password") ?? ""
            let dataModel = SearchQuestionRequestModel(pagination: PaginationModel(orderBy: nil, limit: 10, offset: 0), question: SearchQuestion(isLoadMore: false, id: 0, title: self.txtSearch.text ?? ""), source: "2", user: LoginUser(licenseNumber: lisenceNo, password: password))
            let url = Constant.searchQuestionEP
            let services = QuestionServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
//                    if responseData.questions?.count != 0 {
//                        if self.arrayOfQueries.count > 0 {
//
//                            if let arrayData : [QuesResponseModel] = responseData.questions {
//
//                                for item in arrayData {
//                                    self.arrayOfQueries.append(item)
//                                    self.tblQuesAnswers.reloadData()
//                                    self.searchView.alpha = 0
//                                    self.noDataFoundView.isHidden = true
//                                    self.tblQuesAnswers.isHidden = false
//                                }
//                            }
//                        } else {
//                            self.arrayOfQueries = responseData.questions ?? []
//                            self.tblQuesAnswers.reloadData()
//                            self.searchView.alpha = 0
//                            self.noDataFoundView.isHidden = true
//                            self.tblQuesAnswers.isHidden = false
//                        }
//
//                    }
                    
                    self.arrayOfQueries = responseData.questions ?? []
                    self.tblQuesAnswers.reloadData()
                    self.searchView.alpha = 0
                    self.noDataFoundView.isHidden = true
                    self.tblQuesAnswers.isHidden = false
                    
                } else {
                    
                    if responseData.code == "401" {
                        self.showAlertForLogin(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                        return
                    }
                    
//                    if self.arrayOfQueries.count == 0 {
//                        self.searchView.alpha = 0
//                        self.noDataFoundView.isHidden = false
//                        self.tblQuesAnswers.isHidden = true
//                    }
                    self.searchView.alpha = 0
                    self.noDataFoundView.isHidden = false
                    self.tblQuesAnswers.isHidden = true
                }
            }} else {
                
                self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
            }

    }
    
//    func callGetPostQuestionApi() {
//        
//        if  Connectivity.isConnectedToInternet {
//            self.startAnimation()
//            let dataModel = PostQuestionRequestModel(source: "2", question: Question(title: postAQuesVC?.questionTextView.text ?? "", description: postAQuesVC?.txtwriteSomething.text ?? ""))
//            let url = "api/Question/PostQuestion"
//            let services = PostQuestionsServices()
//            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
//                
//                self.stopAnimation()
//                let status = responseData.success ?? false
//                if status {
//                    self.callGetQuestionApi()
//                } else {
//                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
//                }
//            }
//        } else {
//            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
//        }
//
//    }
}
