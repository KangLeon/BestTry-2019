import UIKit

class Counter{
    var count = 0
    func increment() {
        count+=1
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

//self 属性
struct Point{
    var x = 0.0,y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x== 1.0")
}

//在实例方法中修改值类型
struct PointMuta{
    var x = 0.0,y = 0.0
    mutating func moveBy(x deltaX: Double,y deltaY: Double){
        x += deltaX
        y += deltaY
    }
}

var somePointMuta = PointMuta(x: 1.0, y: 1.0)
somePointMuta.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePointMuta.x),\(somePointMuta.y))")

//你不能在常量结构体类型里调用异变方法，因为自身属性不能被改变，就算它们是变量属性：

//在异变方法里指定自身
struct PoinySelf{
    var x = 0.0,y = 0.0
    mutating func moveBy(x deltaX: Double,y deltaY: Double){
        self=PoinySelf(x: x+deltaX, y: y+deltaY)
    }
}

enum TriStateSwitch{
    case off,low,high
    mutating func next(){
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

var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()

class SomeClass{
    class func someTypeMethod() {
        
    }
}

SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedlevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int){
        if level > highestUnlockedlevel{highestUnlockedlevel=level}
    }
    
    static func isUnlocked(_ level: Int) -> Bool{
        return level <= highestUnlockedlevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool{
        if LevelTracker.isUnlocked(level) {
            currentLevel=level
            return true
        }else{
            return false
        }
    }
}

class Player{
    var tracker = LevelTracker()
    let playerName:String
    func complete(level: Int) {
        LevelTracker.unlock(level+1)
        tracker.advance(to: level+1)
    }
    init(name:String) {
        playerName=name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedlevel)")

player=Player(name: "Beto")
if player.tracker.advance(to: 6){
    print("player is now on level 6")
}else{
    print("level 6 has not yet been unlocked")
}











