//
//  ViewController.swift
//  PersistenceCoreData
//
//  Created by 吉腾蛟 on 2019/9/20.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var lineFields: [UITextField]!
    private let lineEntityName = "Line"
    private let lineNumberKey = "lineNumber"
    private let lineTextKey = "lineText"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: lineEntityName)
        
        let objects = try? context.execute(request)
        if let objectList = objects {
            for oneObject in objectList {
                
            }
        }
    }


}

