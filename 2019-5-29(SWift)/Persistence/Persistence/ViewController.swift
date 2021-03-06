//
//  ViewController.swift
//  Persistence
//
//  Created by 吉腾蛟 on 2019/9/19.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lineFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let filePath = self.dataFilePath()
        if FileManager.default.fileExists(atPath: filePath) {
            let array = NSArray(contentsOfFile: filePath) as! [String]
            for index in 0..<array.count {
                lineFields[index].text = array[index]
            }
        }
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
    }

    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as NSString
        return documentDirectory.appendingPathComponent("data.plist") as String
        
    }
    
    
    @objc func applicationWillResignActive(notification: NSNotification) {
        let filePath = self.dataFilePath()
        let array = (self.lineFields as NSArray).value(forKey: "text") as! NSArray
        array.write(toFile: filePath, atomically: true)
    }
}

