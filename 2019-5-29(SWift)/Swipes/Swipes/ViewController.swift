//
//  ViewController.swift
//  Swipes
//
//  Created by 吉腾蛟 on 2019/9/25.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    private var gestureStartPoint: CGPoint!
    
    private let minimumGestureLength = Float(25.0)
    private let maximumVariance = Float(5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()!
        gestureStartPoint = touch.location(in: self.view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()!
        let currentPosition = touch.location(in: self.view)
        
        
    }
}

