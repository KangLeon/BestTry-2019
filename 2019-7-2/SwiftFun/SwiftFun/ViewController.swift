//
//  ViewController.swift
//  SwiftFun
//
//  Created by 吉腾蛟 on 2019/7/3.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let label = UILabel()
    
    private 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor=UIColor.orange
        label.frame=CGRect(origin: CGPoint(x: 200, y: 400), size: CGSize(width: 100, height: 40))
        label.text="Hello world"
        label.font=UIFont.systemFont(ofSize: 20)
        label.textColor=UIColor.yellow
        label.textAlignment = .right
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeTextContent))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled=true
        
//        view.addSubview(label)
    }

    @objc func changeTextContent() {
        if label.text=="你好" {
            label.text="Hello world"
        }else{
            label.text="你好"
        }
    }
    
    
}

