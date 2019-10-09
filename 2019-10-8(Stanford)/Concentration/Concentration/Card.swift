//
//  Card.swift
//  Concentration
//
//  Created by 吉腾蛟 on 2019/10/9.
//  Copyright © 2019 JY. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUo = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    static func getUniqueIdentifier () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init(identifier: Int) {
        self.identifier = Card.getUniqueIdentifier()
    }
}
