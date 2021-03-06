//
//  Card.swift
//  Concentration
//
//  Created by 吉腾蛟 on 2019/10/9.
//  Copyright © 2019 JY. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
    
    var isFaceUo = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(identifier: Int) {
        self.identifier = Card.getUniqueIdentifier()
    }
}
