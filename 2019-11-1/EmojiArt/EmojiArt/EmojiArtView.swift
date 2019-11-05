//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by 吉腾蛟 on 2019/11/4.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {

    var backgroundImage: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        backgroundImage?.draw(in: bounds)
    }

}
