//
//  DetailViewController.swift
//  Presidents
//
//  Created by 吉腾蛟 on 2019/9/18.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    private var languagebutton: UIBarButtonItem?
    private var languagePopoverController: UIPopoverController?
    var languageString = "" {
        didSet {
            if (languageString != oldValue) {
                configureView()
            }
            if let popoverController = languagePopoverController {
                popoverController.dismiss(animated: true)
                languagePopoverController = nil
            }
        }
    }
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem as AnyObject? {
            if let label = self.detailDescriptionLabel {
                let dict = detail as! [String: String]
                let urlString = modifyUrlForLanguage(url: dict["url"]!, language: languageString)
                label.text = urlString
                
                let url = URL(string: urlString)
                let request = NSURLRequest(url: url!)
                webView.load(request as URLRequest)
                
                let name = dict["name"]
                title = name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UIDevice.current.userInterfaceIdiom == .pad {
            languagebutton = UIBarButtonItem(title: "Choose Language", style: .plain, target: self, action: #selector(toggleLanguagePopover))
            navigationItem.rightBarButtonItem = languagebutton
        }
        
        configureView()
    }
    
    @objc func toggleLanguagePopover() {
        if languagePopoverController == nil {
            let languageListController = LanguageListController()
            languageListController.detailViewController = self
            languagePopoverController = UIPopoverController(contentViewController: languageListController)
            languagePopoverController?.present(from: languagebutton!, permittedArrowDirections: .any, animated: true)
        }else{
            languagePopoverController?.dismiss(animated: true)
            languagePopoverController = nil
        }
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        if popoverController == languagePopoverController {
            languagePopoverController = nil
        }
    }

    var detailItem: [String: String]? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    private func modifyUrlForLanguage(url: String, language lang: String?) -> String {
        var newUrl = url
        
        if let langStr = lang {
            let range = NSMakeRange(7, 2)
            if !langStr.isEmpty && (url as NSString).substring(with: range) != langStr {
                newUrl = (url as NSString).replacingCharacters(in: range, with: langStr)
            }
        }
        
        return newUrl
    }
}

