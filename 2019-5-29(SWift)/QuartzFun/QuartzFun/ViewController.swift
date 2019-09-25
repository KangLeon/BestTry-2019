//
//  ViewController.swift
//  QuartzFun
//
//  Created by 吉腾蛟 on 2019/9/25.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeColor(_ sender: UISegmentedControl) {
        let drawingColorSelection = DrawingColor(rawValue: UInt(sender.selectedSegmentIndex))
        if let drawingColor = drawingColorSelection {
            let funView = view as! QuartzFunView
            switch drawingColor {
            case .Red:
                funView.currentColor = UIColor.red
                funView.useRandomColor = false
            case .Blue:
                funView.currentColor = UIColor.blue
                funView.useRandomColor = false
            case .Yellow:
                funView.currentColor = UIColor.yellow
                funView.useRandomColor = false
            case .Green:
                funView.currentColor = UIColor.green
                funView.useRandomColor = false
            case .Random:
                funView.useRandomColor = true
            }
        }
    }
    
    @IBAction func changeShape(_ sender: UISegmentedControl) {
        let shapeSelection = Shape(rawValue: UInt(sender.selectedSegmentIndex))
        if let shape = shapeSelection {
            let funView = view as! QuartzFunView
            funView.shape = shape
            colorControl.isHidden = shape == Shape.Image
        }
    }
}

