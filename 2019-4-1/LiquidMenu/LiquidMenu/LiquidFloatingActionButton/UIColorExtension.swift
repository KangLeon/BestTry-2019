//
//  UIColorExtension.swift
//  LiquidMenu
//
//  Created by 吉腾蛟 on 2019/12/10.
//  Copyright © 2019 JiYoung. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    var redC: CGFloat {
        get {
            let components = self.cgColor.components
            return components![0]
        }
    }
    var greenC: CGFloat {
        get {
            let components = self.cgColor.components
            return components![1]
        }
    }
    var blueC: CGFloat {
        get {
            let components = self.cgColor.components
            return components![2]
        }
    }
    var alpha: CGFloat {
        get {
            return self.cgColor.alpha
        }
    }
    func alpha(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: self.redC, green: self.greenC, blue: self.blueC, alpha: alpha)
    }
    func white(_ scale: CGFloat) -> UIColor {
        return UIColor(red: self.redC+(1.0-self.redC)*scale, green: self.greenC+(1.0-self.greenC)*scale, blue: self.blueC+(1.0-self.blueC)*scale, alpha: 1.0)
    }
}
