//
//  ViewController.swift
//  SlowWorker
//
//  Created by 吉腾蛟 on 2019/9/20.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var startButton: UIButton!
    @IBOutlet var resultsTextView: UITextView!
    
    func fetchSomethingFormServer() -> String {
        Thread.sleep(forTimeInterval: 1)
        return "Hi three"
    }
    
    func porcessData(data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        return "Number of chars: \(data.count)"
    }
    
    func calculateSecondResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.r
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

