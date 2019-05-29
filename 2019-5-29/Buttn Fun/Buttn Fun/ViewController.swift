//
//  ViewController.swift
//  Buttn Fun
//
//  Created by admin on 2019/5/29.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let title = sender.title(for: .normal)
        let plainText = "\(String(describing: title)) button pressed"
        statusLabel.text=plainText
    }
}

