//
//  ViewController.swift
//  CALayer
//
//  Created by 吉腾蛟 on 2019/10/8.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let redLayer = CALayer()
    let greenLayer = CALayer()
    
    let darwLayer = CALayer()
    let aLayer = ALayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.redLayer.backgroundColor = UIColor.red.cgColor
//        self.redLayer.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
//        self.view.layer.addSublayer(self.redLayer)
//
//        self.greenLayer.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
//        self.greenLayer.backgroundColor=UIColor.green.cgColor
//        self.view.layer.addSublayer(self.greenLayer)
        
//        self.view.layer.addSublayer(self.darwLayer)
//        self.darwLayer.borderColor = UIColor.cyan.cgColor
//        self.darwLayer.borderWidth = 5.0
//        self.darwLayer.contentsScale = UIScreen.main.scale
//        self.darwLayer.delegate = self
        
        self.view.layer.addSublayer(self.aLayer)
        self.aLayer.borderColor = UIColor.cyan.cgColor
        self.aLayer.borderWidth = 5.0
        self.aLayer.contentsScale = UIScreen.main.scale
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        let wh = self.view.frame.width - 40.0
//
//        self.darwLayer.frame = CGRect(x: 20, y: 20, width: wh, height: wh)
        let wh = self.view.frame.width - 40.0
        self.aLayer.frame = CGRect(x: 20, y: 20, width: wh, height: wh)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.darwLayer.setNeedsDisplay()
        self.aLayer.setNeedsDisplay()
    }
}
//
//extension ViewController : CALayerDelegate {
//    func draw(_ layer: CALayer, in ctx: CGContext) {
//        ctx.setStrokeColor(UIColor.red.cgColor)
//        ctx.setLineWidth(2.0)
//        ctx.addEllipse(in: CGRect(x: 10, y: 10, width: 50, height: 50))
//        ctx.strokePath()
//    }
//}

class ALayer: CALayer {
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.addEllipse(in: CGRect(x: 10, y: 10, width: 50, height: 50))
        ctx.fillPath()
    }
}
