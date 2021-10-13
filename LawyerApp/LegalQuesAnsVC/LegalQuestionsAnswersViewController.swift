//
//  LegalQuestionsAnswersViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit
import SideMenu

class LegalQuestionsAnswersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblQuesAnswers: UITableView!
    @IBOutlet weak var viewPostQuesBtn: UIView!
    
    var navController: UINavigationController?
    var postAQuesVC: PostAQuestionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewPostQuesBtn.setCornerRadiusToView()
        self.tblQuesAnswers.register(UINib(nibName: "QuestionAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionAnswerTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            print("Swipe Right")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "QuestionAnswerTableViewCell", for: indexPath) as! QuestionAnswerTableViewCell
        tmpCell.layer.shadowOffset = CGSize(width: 0,height: 0)
        tmpCell.layer.shadowColor = UIColor.black.cgColor
        tmpCell.layer.shadowOpacity = 0.25
        tmpCell.layer.shadowRadius = 4

        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func tappedOnPostAQues( _sender: UIButton) {
        
        postAQuesVC = PostAQuestionViewController()
        if let postQVC = postAQuesVC {

            self.view.addSubview(postQVC.view)
        }
        
        
    }
    
    @objc func onClickCancel() {
        
        self.postAQuesVC?.removeFromParent()
        self.postAQuesVC?.view.removeFromSuperview()
    }
}
