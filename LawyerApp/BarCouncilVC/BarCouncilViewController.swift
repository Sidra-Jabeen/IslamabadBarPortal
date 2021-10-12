//
//  BarCouncilViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 11/10/2021.
//

import UIKit

class BarCouncilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tblBarCouncilList: UITableView!
    @IBOutlet weak var scrollBar: UIScrollView!
    @IBOutlet weak var HStack: UIStackView!
    
    var search: SearchForBarCouncilViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblBarCouncilList.register(UINib(nibName: "GeneralAnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralAnnouncementTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
        self.scrollBar.contentSize = (CGSize(width: self.view.frame.size.width + self.view.frame.size.width, height: 30))
    }
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "GeneralAnnouncementTableViewCell", for: indexPath) as! GeneralAnnouncementTableViewCell

        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    @IBAction func tappedOnSearch( _sender: UIButton) {
        
        self.search = SearchForBarCouncilViewController()
        if let searchVC = search {

            self.view.addSubview(searchVC.view)
        }
    }

}
