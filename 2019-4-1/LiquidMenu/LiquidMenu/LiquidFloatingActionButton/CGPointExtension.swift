//
//  CGPointExtension.swift
//  LiquidMenu
//
//  Created by 吉腾蛟 on 2019/12/9.
//  Copyright © 2019 JiYoung. All rights reserved.
//

import Foundation
import UIKit

//CGPoint的扩展
extension CGPoint {
    //加运算
    func plus(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x+point.x, y: self.y+point.y)
    }
    
    //减运算
    func minus(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x-point.x, y: self.y-point.y)
    }
    
    //横坐标减运算
    func minusX(_ dx:CGFloat) -> CGPoint {
        return CGPoint(x: self.x-dx, y: self.y)
    }
    
    //纵坐标运算
    func minusY(_ dy:CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y-dy)
    }

    //乘运算
    func mul(_ rhs: CGFloat) -> CGPoint {
        return CGPoint(x: self.x*rhs, y: self.y*rhs)
    }
    
    //除运算
    func div(_ rhs: CGFloat) -> CGPoint {
        return CGPoint(x: self.x/rhs, y: self.y/rhs)
    }
    
    //斜边长，x^2+y^2后开根号
    func length() -> CGFloat {
        return sqrt(self.x*self.x+self.y*self.y)
    }
    
    //正规化：？？
    func normalized() -> CGPoint {
        return self.div(length())
    }
    
    //将x、y分别相乘后相加 ：内積 ？？
    func dot(_ point: CGPoint) -> CGFloat {
        return self.x*point.x+self.y*point.y
    }
    
    //外積：？？
    func cross(_ point: CGPoint) -> CGFloat {
        return self.x*point.y-self.y*point.x
    }
    
    func split(_ point: CGPoint, ratio: CGFloat) -> CGPoint {
        return self.mul(ratio).plus(point.mul(1.0-ratio))
    }
    
    func mid(_ point: CGPoint) -> CGPoint {
        return split(point, ratio: 0.5)
    }
    
    static func intersection(_ from: CGPoint,to: CGPoint,from2: CGPoint, to2: CGPoint) -> CGPoint? {
        let ac = CGPoint(x: to.x-from.x, y: to.y-from.y)
        let bd = CGPoint(x: to2.x-from2.x, y: to2.y-from2.y)
        let ab = CGPoint(x: from2.x-from.x, y: from2.y-from.y)
        let bc = CGPoint(x: to.x-from2.x, y: to.y-from2.y)
        
        let area = bd.cross(ab)
        let area2 = bd.cross(bc)
        
        if abs(area+area2) >= 0.1 {
            let ratio = area/(area+area2)
            return CGPoint(x: from.x+ratio*ac.x, y: from.y+ratio*ac.y)
        }
        
        return nil
    }
}
