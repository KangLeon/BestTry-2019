//
//  ViewController.swift
//  TestConvert
//
//  Created by 吉腾蛟 on 2020/1/2.
//  Copyright © 2020 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewA = UIView()
    var viewB = UIView()
    var viewC = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewA = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        viewA.backgroundColor=UIColor.white
        
        viewB = UIView(frame: CGRect(x: 283, y: 50, width: 613, height: 500))
        viewB.backgroundColor=UIColor.red
        viewA.addSubview(viewB)
        
        viewC = UIView(frame: CGRect(x: 10, y: 180, width: 580, height: 310))
        viewC.backgroundColor=UIColor.green
        viewB.addSubview(viewC)
        
        self.view.addSubview(viewA)
        self.view.backgroundColor=UIColor.gray
        
        
        let button = UIButton(frame: CGRect(x: 800, y: 600, width: 100, height: 50))
        button.backgroundColor=UIColor.black
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
    }

    @objc func click() {
        let rect=viewB.convert(viewC.frame, to: viewA)
        print(rect)
        viewA.addSubview(viewC)
        viewC.frame=rect
    }

}

