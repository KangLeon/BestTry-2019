//
//  File.swift
//  LiquidMenu
//
//  Created by 吉腾蛟 on 2019/12/10.
//  Copyright © 2019 JiYoung. All rights reserved.
//

import Foundation
import UIKit

func withBezier(_ f: (UIBezierPath) -> ()) -> UIBezierPath {
    let bezierPath = UIBezierPath()
    f(bezierPath)
    bezierPath.close()
    return bezierPath
}

extension CALayer {
    func appendShadow() {
        shadowColor=UIColor.black.cgColor
        shadowRadius=2.0
        shadowOpacity=0.1
        shadowOffset=CGSize(width: 4, height: 4)
        masksToBounds=false
    }
    
    func reaseShadow() {
        shadowRadius=0.0
        shadowColor=UIColor.clear.cgColor
    }
}

class CGMath {
    static func radToDeg(_ rad: CGFloat) -> CGFloat {
        return rad*180/CGFloat(Double.pi)
    }
    
    static func degToRad(_ deg: CGFloat) -> CGFloat {
        return deg*CGFloat(Double.pi)/180
    }
    
    static func circlePoint(_ center: CGPoint, radius: CGFloat, rad: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(rad)
        let y = center.y + radius * sin(rad)
        return CGPoint(x: x, y: y)
    }
    
    static func linSpace(_ from: CGFloat, to: CGFloat, n: Int) -> [CGFloat] {
        var values: [CGFloat] = []
        for index in 0..<n {
            values.append((to-from)*CGFloat(index)/CGFloat(n-1)+from)
        }
        return values
    }
}