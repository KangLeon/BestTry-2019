//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by 吉腾蛟 on 2019/9/25.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat(Double((arc4random()%256))/255)
        let green = CGFloat(Double(arc4random()%256)/255)
        let blue = CGFloat(Double(arc4random()%256)/255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

enum Shape: UInt {
    case Line = 0, Rect, Ellipse, Image
}

enum DrawingColor: UInt {
    case Red = 0, Blue, Yellow, Green, Random
}

class QuartzFunView: UIView {

    
    
    var shape = Shape.Line
    var currentColor = UIColor.red
    var useRandomColor = false
    
    private let image = UIImage(named: "iphone")!
    private var firstTouchlocation: CGPoint = CGPoint.zero
    private var lastTouchLocation: CGPoint = CGPoint.zero
    private var redrawRect: CGRect = CGRect.zero
    private var currentRect:CGRect = CGRect.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        let touch = touches.randomElement()!
        firstTouchlocation = touch.location(in: self)
        lastTouchLocation = firstTouchlocation
        redrawRect = CGRect.zero
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()!
        lastTouchLocation = touch.location(in: self)
        
        if shape == .Image {
            let horizontalOffset = image.size.width/2
            let verticalOffset = image.size.height/2
            redrawRect.union(CGRect(x: lastTouchLocation.x-horizontalOffset, y: lastTouchLocation.y-verticalOffset, width: image.size.width, height: image.size.height))
        }else{
            redrawRect.union(currentRect)
        }
        setNeedsDisplay(redrawRect)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()!
        lastTouchLocation = touch.location(in: self)
        
        if shape == .Image {
            let horizontalOffset = image.size.width/2
            let verticalOffset = image.size.height/2
            redrawRect.union(CGRect(x: lastTouchLocation.x-horizontalOffset, y: lastTouchLocation.y-verticalOffset, width: image.size.width, height: image.size.height))
        }else{
            redrawRect = CGRect.zero
        }
        setNeedsDisplay(redrawRect)
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(2.0)
        context?.setStrokeColor(currentColor.cgColor)
        context?.setFillColor(currentColor.cgColor)
        currentRect = CGRect(x: firstTouchlocation.x, y: firstTouchlocation.y, width: lastTouchLocation.x-firstTouchlocation.x, height: lastTouchLocation.y-firstTouchlocation.y)
        
        switch shape {
        case .Line:
            context?.move(to: firstTouchlocation)
            context?.addLine(to: lastTouchLocation)
            context?.strokePath()
        case .Rect:
            context?.addRect(currentRect)
            context?.drawPath(using: .fillStroke)
        case .Ellipse:
            context?.addEllipse(in: currentRect)
            context?.drawPath(using: .fillStroke)
        case .Image:
            let horizontalOffset = image.size.width/2
            let verticalOffset = image.size.height/2
            let drawPoint = CGPoint(x: lastTouchLocation.x-horizontalOffset, y: lastTouchLocation.y-verticalOffset)
            image.draw(at: drawPoint)
        }
        
    }

}
