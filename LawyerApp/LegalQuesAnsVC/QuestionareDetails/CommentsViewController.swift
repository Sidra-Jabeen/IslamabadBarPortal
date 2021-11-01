//
//  CommentsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 15/10/2021.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - IBOutlet
    
    @IBOutlet weak var customTableView: UITableView!
    
    //MARK: - Variable
    
    var arrayQuestionAttachment: [(String, Bool)] = [("",false)]
    var questionDetailsData: QuestionDetailResponseModel?
    var selectedCategoryBtn = 1
    var questionId = 0
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customTableView.register(UINib(nibName: "UIQuestionDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "UIQuestionDetailTableViewCell")
        self.customTableView.register(UINib(nibName: "UIQuestionAttachmentTableViewCell", bundle: nil), forCellReuseIdentifier: "UIQuestionAttachmentTableViewCell")
        self.customTableView.register(UINib(nibName: "UICommentSelectorTableViewCell", bundle: nil), forCellReuseIdentifier: "UICommentSelectorTableViewCell")
        self.customTableView.register(UINib(nibName: "QueriesTableViewCell", bundle: nil), forCellReuseIdentifier: "QueriesTableViewCell")
        self.callGetQuestionApi()
    }
    
    //MARK: - IBAction

    @IBAction func onBackNavigation(_sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 145
        } else if indexPath.section == 1 {
            return self.questionDetailsData?.questionAttachments?.count ?? 0 > 0 ? 125 : 0
        } else if indexPath.section == 2 {
            return 40
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 && self.arrayQuestionAttachment[section - 3].1 ? self.arrayQuestionAttachment.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UIQuestionDetailTableViewCell", for: indexPath) as! UIQuestionDetailTableViewCell
            tmpCell.lblTitle.text = self.questionDetailsData?.title
            tmpCell.lblPostedAt.text = self.questionDetailsData?.postedAt
            tmpCell.lblPostedBy.text = self.questionDetailsData?.postedBy
            tmpCell.lblDescription.text = self.questionDetailsData?.description
            tmpCell.selectionStyle = .none
            return tmpCell
        } else if indexPath.section == 1 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UIQuestionAttachmentTableViewCell", for: indexPath) as! UIQuestionAttachmentTableViewCell
//            tmpCell.config()
            tmpCell.arrayForAttachments = questionDetailsData?.questionAttachments ?? []
            tmpCell.config()
            tmpCell.selectionStyle = .none
            return tmpCell
        } else if indexPath.section == 2 {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "UICommentSelectorTableViewCell", for: indexPath) as! UICommentSelectorTableViewCell
            tmpCell.selectionStyle = .none
            tmpCell.btnAll.tag = 1
            tmpCell.btnToday.tag = 2
            tmpCell.btnYesterday.tag = 3
            tmpCell.btnLastWeek.tag = 4
            tmpCell.viewAll.layer.backgroundColor = selectedCategoryBtn == tmpCell.btnAll.tag ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            tmpCell.viewToday.layer.backgroundColor = selectedCategoryBtn == tmpCell.btnToday.tag ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            tmpCell.viewYesterday.layer.backgroundColor = selectedCategoryBtn == tmpCell.btnYesterday.tag ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            tmpCell.viewLastWeek.layer.backgroundColor = selectedCategoryBtn == tmpCell.btnLastWeek.tag ? #colorLiteral(red: 0.8715899587, green: 0.6699344516, blue: 0.3202168643, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            tmpCell.btnAll.addTarget(self, action: #selector(onClickCallCommentsAPI), for: .touchUpInside)
            tmpCell.btnToday.addTarget(self, action: #selector(onClickCallCommentsAPI), for: .touchUpInside)
            tmpCell.btnYesterday.addTarget(self, action: #selector(onClickCallCommentsAPI), for: .touchUpInside)
            tmpCell.btnLastWeek.addTarget(self, action: #selector(onClickCallCommentsAPI), for: .touchUpInside)
            return tmpCell
        } else {
            
            let tmpCell = tableView.dequeueReusableCell(withIdentifier: "QueriesTableViewCell", for: indexPath) as! QueriesTableViewCell
            tmpCell.cellDelegate = self
            tmpCell.selectionStyle = .none
            tmpCell.viewReplyBtn.isHidden = true
            tmpCell.config()
            
            if indexPath.row == 0 {
                
                tmpCell.leadingConst.constant = 20
                tmpCell.viewReplyBtn.isHidden = false
                tmpCell.viewReplyBtn.tag = indexPath.section - 3
                tmpCell.viewReplyBtn.setTitle(self.arrayQuestionAttachment[indexPath.section - 3].1 ? "Hide Replies" : "View Replies", for: .normal)
                tmpCell.viewReplyBtn.addTarget(self, action: #selector(onClickShowHideReply(_:)), for: .touchUpInside)
                return tmpCell
            }
            
            tmpCell.leadingConst.constant = 75
            return tmpCell
        }
    }
    
    //MARK: - API Calls
    
    func callGetQuestionApi() {
        
        if  Connectivity.isConnectedToInternet {
            
            self.startAnimation()
            
            let paginationModel = Pagination(limit: 10, offset: 0)
            let questionModel = QuestionModel(id: questionId)
            let dataModel = QuestionareRequestModel(pagination: paginationModel, source: "2", question: questionModel).params
            
            let questionareDetailUrl = Constant.getQuestionDetailsEP
            
            let services = QuestionareServices()
            services.getQuestionareDetails(urlString: questionareDetailUrl, dataModel: dataModel, completion: { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.questionDetailsData = responseData.questionDetail
                    print(self.questionDetailsData!)
                    self.customTableView.reloadData()
//                    self.arrayOfQueries = responseData.questions ?? []
//                    self.tblQuesAnswers.reloadData()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            })
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    func callGetCommentsApi() {
        
        if  Connectivity.isConnectedToInternet {
            
            self.startAnimation()
            
            let paginationModel = Pagination(limit: 10, offset: 0)
            let questionModel = QuestionModel(id: questionId)
            let dataModel = QuestionareRequestModel(pagination: paginationModel, source: "2", question: questionModel).params
            
            let questionareDetailUrl = Constant.getQuestionDetailsEP
            
            let services = QuestionareServices()
            services.getQuestionareDetails(urlString: questionareDetailUrl, dataModel: dataModel, completion: { (responseData) in
                
                self.stopAnimation()
                let status = responseData.success ?? false
                if status {
                    
                    self.questionDetailsData = responseData.questionDetail
                    print(self.questionDetailsData!)
                    self.customTableView.reloadData()
//                    self.arrayOfQueries = responseData.questions ?? []
//                    self.tblQuesAnswers.reloadData()
                } else {
                    self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: responseData.desc ?? "")
                }
            })
        } else {
            self.showAlert(alertTitle: "Islamabad Bar Connect", alertMessage: "No Internet Connection")
        }
    }
    
    //MARK: - Others
    
    func previousDay() -> Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = -1
        let theCalendar     = Calendar.current
        let day        = theCalendar.date(byAdding: dayComponent, to: Date())!
        return day
    }
    
    func getPreviousWeekStartDay() -> Date? {
        
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from:
        gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        return gregorian.date(byAdding: .day, value: -6, to: sunday!)!
    }

    // Getting last day of previous week
    func getPreviousWeekEndDay() -> Date? {
        
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        return gregorian.date(byAdding: .day, value: 0, to: sunday!)!
    }
    
    func checkDays(allClear: Bool) {
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
        
            let yesterday = previousDay()
            let weekFirstDay = getPreviousWeekEndDay()
            let weekLastDay = getPreviousWeekStartDay()
            
//            if self.txtToDate.text == dateFormatter.string(from: Date()) && self.txtFromDate.text == dateFormatter.string(from: Date()){
//                self.todayBtnTapped(UIButton())
//
//            }else if self.txtToDate.text == dateFormatter.string(from: yesterday) && self.txtFromDate.text == dateFormatter.string(from: yesterday){
//
//                self.yesterdayTapped(UIButton())
//
//            }else if self.txtToDate.text == dateFormatter.string(from: weekLastDay!) && self.txtFromDate.text == dateFormatter.string(from: weekFirstDay!){
//
//                self.lastWeekTapped(UIButton())
//            }else if allClear == false {
//                self.allTapped(UIButton())
//            }
            
        }
    
    @objc func onClickCallCommentsAPI(_ sender: UIButton) {
        
//        self.arrayQuestionAttachment[sender.tag].1 = !self.arrayQuestionAttachment[sender.tag].1
        self.selectedCategoryBtn = sender.tag
        self.customTableView.reloadData()
    }
    
    @objc func onClickShowHideReply(_ sender: UIButton) {
        
        self.arrayQuestionAttachment[sender.tag].1 = !self.arrayQuestionAttachment[sender.tag].1
        self.customTableView.reloadData()
    }
    
}

extension CommentsViewController: GrowingCellProtocol {
    
    func updateHeightOfRow(_ cell: QueriesTableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = customTableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            customTableView?.beginUpdates()
            customTableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = customTableView.indexPath(for: cell) {
                customTableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
