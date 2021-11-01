//
//  LegalQuestionsAnswersViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import SideMenu

class LegalQuestionsAnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tblQuesAnswers: UITableView!
    @IBOutlet weak var viewPostQuesBtn: UIView!
    
    //MARK: - Variable
    
    var navController: UINavigationController?
    var postAQuesVC: PostAQuestionViewController?
    var arrayOfQueries = [QuesResponseModel]()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewPostQuesBtn.setCornerRadiusToView()
        self.tblQuesAnswers.register(UINib(nibName: "QuestionAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionAnswerTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.callGetQuestionApi()
    }
    
    //MARK: - IBAction
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedOnPostAQues( _sender: UIButton) {
        
        postAQuesVC = PostAQuestionViewController()
        if let postQVC = postAQuesVC {
            
            self.view.addSubview(postQVC.view)
            postQVC.btnPostAQuestion.addTarget(self, action: #selector(clickedOnPostAQuestion), for: .touchUpInside)
        }
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayOfQueries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "QuestionAnswerTableViewCell", for: indexPath) as! QuestionAnswerTableViewCell
        tmpCell.layer.shadowOffset = CGSize(width: 0,height: 0)
        tmpCell.layer.shadowColor = UIColor.black.cgColor
        tmpCell.layer.shadowOpacity = 0.25
        tmpCell.layer.shadowRadius = 4
        tmpCell.configCell(data: arrayOfQueries[indexPath.row])
        tmpCell.selectionStyle = .none
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vC = CommentsViewController(nibName: "CommentsViewController", bundle: nil)
        vC.questionId = self.arrayOfQueries[indexPath.row].qId ?? 0
        self.navigationController?.pushViewController(vC, animated: true)
    }
    
    //MARK: - API Calls
    
    func callGetQuestionApi() {
        
        if  Connectivity.isConnectedToInternet {
            
            self.startAnimation()
            let dataModel = QuestionRequestModel(source: "2", pagination: PaginationModel(orderBy: "", limit: 10, offset: self.arrayOfQueries.count))
            let signUpUrl = "api/Question/GetQuestions"
            let services = QuestionServices()
            services.postMethod(urlString: signUpUrl, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.arrayOfQueries = responseData.questions ?? []
                    self.tblQuesAnswers.reloadData()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    func callGetPostQuestionApi() {
        
        if  Connectivity.isConnectedToInternet {
            self.startAnimation()
            let dataModel = PostQuestionRequestModel(source: "2", question: Question(title: postAQuesVC?.questionTextView.text ?? "", description: postAQuesVC?.txtwriteSomething.text ?? ""))
            let url = "api/Question/PostQuestion"
            let services = PostQuestionsServices()
            services.postMethod(urlString: url, dataModel: dataModel.params) { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    self.callGetQuestionApi()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            }
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    //MARK: - Others
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            self.navigationController?.popViewController(animated: true)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
        }
    }
    
    @objc func onClickCancel() {
        
        self.postAQuesVC?.removeFromParent()
        self.postAQuesVC?.view.removeFromSuperview()
    }
    
    @objc func clickedOnPostAQuestion() {
        self.callGetPostQuestionApi()
    }
}
