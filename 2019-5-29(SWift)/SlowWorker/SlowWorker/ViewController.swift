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
    @IBOutlet var spinner: UIActivityIndicatorView!
    
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
        let startTime = Date()
        resultsTextView.text = ""
        startButton.isEnabled = false
        spinner.startAnimating()
        let queue = DispatchQueue.global()
        
        queue.async {
            let fetchdData = self.fetchSomethingFormServer()
            let processdData = self.processData(data: fetchdData)
            
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            queue.async(group: group, qos: .default, flags: []) {
                firstResult = self.calculateFirstResult(data: processdData)
            }
            
            queue.async(group: group, qos: .default, flags: []) {
                secondResult = self.calculateSecondResult(data: processdData)
            }
            
            group.notify(qos: .default, flags: [], queue: queue) {
                let resultsSummary = "First: [\(firstResult)\nSecond:[\(secondResult)]]"
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.startButton.isEnabled = true
                    self.spinner.stopAnimating()
                }
                let endTime = Date()
                print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
}

