//
//  ViewController.swift
//  PlayingCard
//
//  Created by 吉腾蛟 on 2019/10/11.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
            
        }
    }


}

