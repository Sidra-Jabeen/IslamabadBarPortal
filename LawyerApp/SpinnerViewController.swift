//
//  SpinnerViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 13/10/2021.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        view.frame.size.height = UIScreen.main.bounds.height
        view.frame.size.width = UIScreen.main.bounds.width

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = #colorLiteral(red: 0.1232226267, green: 0.3896489143, blue: 0.3453142643, alpha: 1)
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
