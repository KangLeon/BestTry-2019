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
    private var languagePopoverController: UIPopoverPresentationController?
    var languageString = ""
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem as AnyObject? {
            if let label = self.detailDescriptionLabel {
                let dict = detail as! [String: String]
                let urlString = dict["url"]!
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
        configureView()
    }

    var detailItem: [String: String]? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

