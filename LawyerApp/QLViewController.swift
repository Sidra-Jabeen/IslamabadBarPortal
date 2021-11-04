//
//  QLPreviewController.swift
//  LawyerApp
//
//  Created by Sidra Jabeen on 01/11/2021.
//

import UIKit
import QuickLook

class PreviewItem: NSObject, QLPreviewItem {
    var previewItemURL: URL?
}

class QLViewController: UIViewController {
    
    //MARK: - Propertities
    var previewItems: [PreviewItem] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - QuickLookFunction
    func  showPreview(index: Int){
        
        guard previewItems.count>index else{return}
        let quickLookViewController = QLPreviewController()
        quickLookViewController.dataSource = self
        quickLookViewController.currentPreviewItemIndex = index
        present(quickLookViewController, animated: true)
    }
    
    func quickLook(url: URL, closure : @escaping (String) -> Void) {
        
        let component = url.lastPathComponent
        let previewURL = FileManager.default.temporaryDirectory.appendingPathComponent(component)
        
//        MARK:- previewURL.checkFileExist() will check iff file exists no netwok calling just save the url
        if previewURL.checkFileExist(){
            let previewItem = PreviewItem()
            previewItem.previewItemURL = previewURL
            self.previewItems.append(previewItem)
        }
        //        MARK:- make netwok calls and save the url
        else{
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {return}
                guard
                    let _ = response as? HTTPURLResponse else {return}
                do {
                    try data.write(to: previewURL, options: .atomic)   // atomic option overwrites it if needed
    //                previewURL.hasHiddenExtension = true
                    let previewItem = PreviewItem()
                    previewItem.previewItemURL = previewURL
                    self.previewItems.append(previewItem)
                    closure("")
    //                self.previewItems[index] = previewItem
                    print(self.previewItems)
                } catch {
                    print(error)
                    return
                }
            }.resume()
        }
    }
}

// MARK: - QLPreviewControllerDataSource
extension QLViewController: QLPreviewControllerDelegate,QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        self.previewItems.count
    }
    
    
    func previewController(
        _ controller: QLPreviewController,
        previewItemAt index: Int
    ) -> QLPreviewItem {
        
        self.previewItems[index]
        
    }
}

extension URL    {
    func checkFileExist() -> Bool {
        let path = self.path
        if (FileManager.default.fileExists(atPath: path))   {
            print("FILE AVAILABLE")
            return true
        }else        {
            print("FILE NOT AVAILABLE")
            return false;
        }
    }
}
