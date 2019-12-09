//
//  CGRectExtension.swift
//  LiquidMenu
//
//  Created by 吉腾蛟 on 2019/12/9.
//  Copyright © 2019 JiYoung. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    var rightBottom: CGPoint {
        return CGPoint(x: origin.x+width, y: origin.y+height)
    }
    var center: CGPoint {
        return origin.plus(rightBottom).mul(0.5)
    }
    
}
