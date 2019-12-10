//
//  LiquidTableCircle.swift
//  LiquidMenu
//
//  Created by 吉腾蛟 on 2019/12/10.
//  Copyright © 2019 JiYoung. All rights reserved.
//

import Foundation
import UIKit

open class LiquittableCircle : UIView {
    var points: [CGPoint] = []
    var radius: CGFloat {
        didSet {
            self.frame = CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2*radius)
            setUp()
        }
    }
    
    var color: UIColor = UIColor.red {
        didSet {
            setUp()
        }
    }
    
    open override var center: CGPoint {
        didSet {
            self.frame=CGRect(x: self.center.x-radius, y: self.center.y-radius, width: 2*radius, height: 2*radius)
            setUp()
        }
    }
    
    let circleLayer = CAShapeLayer()
    init(center: CGPoint, radius: CGFloat, color: UIColor) {
        let frame = CGRect(x: center.x-radius, y: center.y-radius, width: 2*radius, height: 2*radius)
        self.radius=radius
        self.color=color
        //必须该类的属性都实现才能继续向上委托让父类实现
        super.init(frame: frame)
        setUp()
        self.layer.addSublayer(circleLayer)
        self.isOpaque = false
    }
    
    init() {
        self.radius=0
        super.init(frame: CGRect.zero)
        setUp()
        self.layer.addSublayer(circleLayer)
        self.isOpaque=false
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init()coder: 已经被实现了")
    }
    
    fileprivate func setUp() {
        self.frame=CGRect(x: center.x-radius, y: center.y-radius, width: 2*radius, height: 2*radius)
        drawCircle()
    }
    
    func drawCircle() {
        let bezierPath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: CGSize(width: radius*2, height: radius*2)))
        draw(bezierPath)
    }
    
    @discardableResult
    func draw(_ path: UIBezierPath) -> CAShapeLayer {
        circleLayer.lineWidth=3.0
        circleLayer.fillColor=self.color.cgColor
        circleLayer.path=path.cgPath
        return circleLayer
    }
    
    func circlePoint(_ rad: CGFloat) -> CGPoint {
        return CGMath.circlePoint(center, radius: radius, rad: rad)
    }
    
    open override func draw(_ rect: CGRect) {
        drawCircle()
    }
}

