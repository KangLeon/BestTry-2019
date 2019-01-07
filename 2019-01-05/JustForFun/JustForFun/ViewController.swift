//
//  ViewController.swift
//  JustForFun
//
//  Created by admin on 2019/1/5.
//  Copyright © 2019 Sony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBAction func showAlert(_ sender: UIButton) {
        let alert=UIAlertController(title: "Hello", message: "Hello,world!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.textLabel.text="点击了"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

