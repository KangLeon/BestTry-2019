//
//  Concentration.swift
//  Concentration
//
//  Created by 吉腾蛟 on 2019/10/9.
//  Copyright © 2019 JY. All rights reserved.
//

import Foundation

class Concentration {
    var cards: [Card] = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUo = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                //either no cards or 2
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUo = false
                }
                cards[index].isFaceUo = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for identifier in 0..<numberOfPairsOfCards {
            let card = Card(identifier: identifier)
            let matchingCard = card
            cards.append(card)
            cards.append(matchingCard)
        }
    }
}
