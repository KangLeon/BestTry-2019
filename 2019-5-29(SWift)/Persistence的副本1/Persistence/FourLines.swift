//
//  FourLines.swift
//  Persistence
//
//  Created by 吉腾蛟 on 2019/9/20.
//  Copyright © 2019 JY. All rights reserved.
//

import UIKit

class FourLines: NSObject,NSCoding,NSCopying {
    
    
    var lines: [String]?
    let linesKey = "linesKey"
    
    override init() {
        
    }
    
    required init(coder decoder: NSCoder) {
        lines = decoder.decodeObject(forKey: linesKey) as? [String]
    }
    
    func encode(with aCoder: NSCoder) {
        if let saveLines = lines {
            aCoder.encode(saveLines, forKey: linesKey)
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = FourLines()
        if let linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            copy.lines = newLines
        }
        return copy
    }
}
