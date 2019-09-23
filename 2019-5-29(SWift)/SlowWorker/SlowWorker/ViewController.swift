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
    
    func processData(data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        return "Number of chars: \(data.count)"
    }
    
    func calculateSecondResult(data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
    
    @IBAction func doWork(sender: AnyObject) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        let fetchdData = self.fetchSomethingFormServer()
        let processdData = self.processData(data: fetchdData)
        let firstResult = self.calculateFirstResult(data: processdData)
        let secondResult = self.calculateSecondResult(data: processdData)
        let resultsSummary = "First: [\(firstResult)\nSecond:[\(secondResult)]]"
        self.resultsTextView.text = resultsSummary
        let endTime = NSDate()
        print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

