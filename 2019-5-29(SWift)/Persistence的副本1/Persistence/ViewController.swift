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
    private let rootKey = "rootKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let filePath = self.dataFilePath()
        if FileManager.default.fileExists(atPath: filePath) {
            let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            let fourLines = unarchiver.decodeObject(forKey: rootKey) as! FourLines
            unarchiver.finishDecoding()
            
            if let newLines = fourLines.lines {
                for index in 0..<newLines.count {
                    lineFields[index].text = newLines[index]
                }
            }
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(notification:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
        
    }

    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as NSString
        return documentDirectory.appendingPathComponent("data.archive") as String
        
    }
    
    
    @objc func applicationWillResignActive(notification: NSNotification) {
        let filePath = self.dataFilePath()
        let fourLines = FourLines()
        let array = (self.lineFields as NSArray).value(forKey: "text") as! [String]
        fourLines.lines = array
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(fourLines, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
}

