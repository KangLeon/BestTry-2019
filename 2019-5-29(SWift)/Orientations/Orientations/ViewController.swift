//
//  ViewController.swift
//  Orientations
//
//  Created by admin on 2019/6/2.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var _orientations = UIInterfaceOrientationMask.portrait.rawValue | UIInterfaceOrientationMask.landscapeLeft.rawValue
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{return UIInterfaceOrientationMask(rawValue: self._orientations)}
        set{self._orientations = newValue.rawValue}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

