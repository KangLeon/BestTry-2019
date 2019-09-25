//
//  ViewController.swift
//  TouchExplorer
//
//  Created by 吉腾蛟 on 2019/9/25.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tapsLabel: UILabel!
    @IBOutlet weak var touchesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    func updateLabelsFromTouches(touches: Set<UITouch>!) {
        let touch = touches.randomElement()!
        let numTaps = touch.tapCount
        let tapMessage = "\(numTaps) taps detected"
        tapsLabel.text = tapMessage
        
        let numTouches = touches.count
        let touchMsg = "\(numTouches) touches detected"
        touchesLabel.text = touchMsg
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Began"
        updateLabelsFromTouches(touches: event?.allTouches)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Cancelled"
        updateLabelsFromTouches(touches: event?.allTouches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Ended"
        updateLabelsFromTouches(touches: event?.allTouches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Drag Detected"
        updateLabelsFromTouches(touches: event?.allTouches)
    }
}

