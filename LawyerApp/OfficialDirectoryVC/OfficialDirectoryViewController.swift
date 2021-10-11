//
//  OfficialDirectoryViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 10/10/2021.
//

import UIKit

class OfficialDirectoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblDirectories: UITableView!
    @IBOutlet weak var btnAddDirectory: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnAddDirectory.layer.cornerRadius = self.btnAddDirectory.frame.size.height / 2
        self.tblDirectories.register(UINib(nibName: "OfficialDirectoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OfficialDirectoryTableViewCell")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tmpCell = tableView.dequeueReusableCell(withIdentifier: "OfficialDirectoryTableViewCell", for: indexPath) as! OfficialDirectoryTableViewCell
        tmpCell.layer.shadowOffset = CGSize(width: 0,height: 0)
        tmpCell.layer.shadowColor = UIColor.black.cgColor
        tmpCell.layer.shadowOpacity = 0.25
        tmpCell.layer.shadowRadius = 4
        return tmpCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    

    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
