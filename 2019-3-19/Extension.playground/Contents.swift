import UIKit

extension Double{
    var km:Double{return self * 1_000.0}
    var m:Double{return self}
    var cm:Double{return self/100.0}
    var mm:Double{return self/1_000.0}
    var ft:Double{return self/3.28084}
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.0.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.0.km+195.0.m
print("A marathon is \(aMarathon) meters long")

//扩展能为类添加新的便捷初始化器，但是不能为类添加指定初始化器或反初始化器。指定初始化器和反初始化器 必须由原来类的实现提供。
struct Size{
    var width = 0.0, height = 0.0
}

struct Point{
    var x = 0.0, y = 0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect{
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size:size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

extension Int{
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

extension Int{
    mutating func square(){
        self = self * self
    }
}

var someInt = 3
someInt.square()

extension Int{
    subscript(digitIndex: Int) -> Int{
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self/decimalBase)%10
    }
}

746381295[0]

746381295[1]

746381295[2]

746381295[8]

//若 Int 值没有所需索引的那么多数字，下标实现返回 0 ，就像是这个数左边用零填充：
746381295[9]

extension Int{
    enum Kind {
        case negative, zero, positive
    }
    
    var kind: Kind{
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]){
    for number in numbers {
        switch number.kind {
        case .negative:
            print("_", terminator: "")
        case .zero:
            print("0", terminator: "")
        case .positive:
            print("+", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3,19,-27,0,-6,0,7])

