//
//  ViewController.swift
//  TestConvert
//
//  Created by 吉腾蛟 on 2019/2/22.
//  Copyright © 2019 mj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var beforeView: UIView!
    var bebeforeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.beforeView=UIView(frame: CGRect(x: 200, y: 200, width: 400, height: 400))
        self.beforeView.backgroundColor=UIColor.blue
        self.bebeforeView=UIView(frame: CGRect(x: 200, y: 200, width: 300, height: 300))
        self.bebeforeView.backgroundColor=UIColor.green
        
        self.bebeforeView.addSubview(self.beforeView)
        self.view.addSubview(self.bebeforeView)
    }
    
    func conventaaaa() {
        let newPoint=self.bebeforeView.convert(self.beforeView.frame.origin, to: self.view)
        self.beforeView.removeFromSuperview()
        self.beforeView=UIView(frame: CGRect(x: newPoint.x, y: newPoint.y, width: 400, height: 400))
        self.view.addSubview(self.beforeView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.conventaaaa()
    }
}

