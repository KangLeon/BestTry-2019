import UIKit

var str = "Hello, playground"

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()

counter.increment()
counter.increment(by: 5)
counter.reset()

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

struct PointMutating {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double){
        x += deltaX
        y += deltaY
    }
}

var somePointMutating = PointMutating(x: 1.0, y: 1.0)
somePointMutating.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePointMutating.x), \(somePointMutating.y))")

struct PointSelf {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double){
        self = PointSelf(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovemLight = TriStateSwitch.low
ovemLight.next()
ovemLight.next()

struct LevelTracker {
    static var highestUnLockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int){
        if level > highestUnLockedLevel {
            highestUnLockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnLockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else{
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnLockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6){
    print("player is now on level 6")
}else{
    print("level 6 has not yet been unlocked")
}

