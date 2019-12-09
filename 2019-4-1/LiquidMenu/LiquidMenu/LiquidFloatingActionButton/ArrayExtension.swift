//
//  ArrayExtension.swift
//  LiquidMenu
//
//  Created by 吉腾蛟 on 2019/12/9.
//  Copyright © 2019 JiYoung. All rights reserved.
//

import Foundation

//Array扩展
extension Array {
    //传入参数是一个闭包
    func each(_ f: (Element) -> ()) {
        for item in self {
            f(item)
        }
    }
}
