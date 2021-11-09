//
//  UIImageViewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 03/11/2021.
//

import UIKit
import Kingfisher

class UIImageViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    var getImage: UIImageView?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let paths = ImageCache.default.cachePath(forKey: name ?? "")
        let image = UIImage(contentsOfFile: paths)
//        let imageView = UIImageView(image: image)
        self.img.image = image
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .right
        self.view.addGestureRecognizer(swipeLeft)
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
    
    @IBAction func tappedOnBack( _sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
