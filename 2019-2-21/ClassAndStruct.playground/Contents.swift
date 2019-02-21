import UIKit

struct Resolution{
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var  interlaced = false
    var frameRate = 0.0
    var  name:String?
}

//类与结构体实例
let someResolution = Resolution()
let someVideoModel = VideoMode()

print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoModel.resolution.width)")

someVideoModel.resolution.width=1280
print("The width of somevideoMode is now \(someVideoModel.resolution.width)")

let vga = Resolution(width: 640, height: 480)
let hd = Resolution(width: 1920, height: 1080)

//Swift 中所有的结构体和枚举都是值类型，这意味着你所创建的任何结构体和枚举实例——和实例作为属性所包含的任意值类型——在代码传递中总是被拷贝的。

//这种行为规则同样适用于枚举：
enum CompassPoint{
    case North,South,East,West
}
var currentdirection = CompassPoint.West
let rememberedDirection = currentdirection
currentdirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}

//类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution=hd
tenEighty.interlaced=true
tenEighty.name="1080i"
tenEighty.frameRate=25.0

let  alsoTenEighty = tenEighty
alsoTenEighty.frameRate=30.0

print("The frameRate property if tenEighty is now \(tenEighty.frameRate)")

//比较引用
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

//存储属性
struct FixedLengthRange{
    var firstValue : Int
    let length : Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue=6

//如果你创建了一个结构体的实例并且把这个实例赋给常量，你不能修改这个实例的属性，即使是声明为变量的属性：
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)

//如果被标记为 lazy 修饰符的属性同时被多个线程访问并且属性还没有被初始化，则无法保证属性只初始化一次。

//计算属性
struct Point{
    var x = 0.0,y = 0.0
}

struct Size{
    var width = 0.0,height = 0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
    var center : Point {
        get{
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter){
            origin.x=newCenter.x-(size.width/2)
            origin.y=newCenter.y-(size.height/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter=square.center
square.center=Point(x: 15.0, y: 15.0)
print("square.origin is now at(\(square.origin.x),\(square.origin.y))")




