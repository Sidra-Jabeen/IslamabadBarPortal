//
//  GeneralAnnouncementsViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class GeneralAnnouncementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblAnnouncements: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblAnnouncements.register(UINib(nibName: "GeneralAnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "GeneralAnnouncementTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
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
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
//        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true, completion: nil)
//        self.view.removeFromSuperview()
        
    }

}
