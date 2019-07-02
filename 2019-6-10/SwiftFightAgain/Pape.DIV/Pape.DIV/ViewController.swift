//
//  ViewController.swift
//  Pape.DIV
//
//  Created by admin on 2019/6/30.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moneyTextFileld: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func moneyCount(_ sender: Any) {
        moneyLabel.text = moneyTextFileld.text
        UserDefaults.standard.set(moneyLabel.text, forKey: "moneyKey")
    }
    
    @IBAction func timeCount(_ sender: Any) {
        timeLabel.text = timeTextField.text
        UserDefaults.standard.set(timeLabel.text, forKey: "timeKey")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moneyTextFileld.resignFirstResponder()
        timeTextField.resignFirstResponder()
        moneyLabel.text=String(UserDefaults.standard.float(forKey: "moneyKey"))
        timeLabel.text=String(UserDefaults.standard.float(forKey: "timeKey"))
        moneyTextFileld.text=""
        timeTextField.text=""
    }
}

