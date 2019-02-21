import UIKit

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mecury,venus,earth,mars,jupiter,satuen,uranus,neptune
}

var directionToHead = CompassPoint.west

directionToHead = .east

directionToHead = .south
switch directionToHead {
case .north:
    print("北边")
case .south:
    print("南边")
case .east:
    print("东边")
case .west:
    print("西边")
//default:
//    print("Not a safe place for humans")
}

//使用的语法是标记枚举遵循 CaseIterable 协议
enum Beverage: CaseIterable{
    case coffee,tea,juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

enum Barcode {
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

//它们只可以在给定的时间内存储它们它们其中之一。因为每一项都是互斥的？
productBarcode = .qrCode("ABCDJFJFHDKFHFJN")

switch productBarcode {
case .upc(let numberSystem,let manufacturer,let product,let check):
    print("UPC:\(numberSystem),\(manufacturer),\(product),\(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

switch productBarcode {
case let .upc(numberSystem,manufacturer,product,check):
    print("UPC : \(numberSystem),\(manufacturer),\(product),\(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

//关联值在你基于枚举成员的其中之一创建新的常量或变量时设定，并且在你每次这么做的时候这些关联值可以是不同的。
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum PlanetList:Int {
    case mercury = 1,venus,earth,mars,jupiter,saturn,uranus,neptune
}

//CompassPoint.south有一个隐式原始值 "south" ，以此类推。
enum CompassPointList: String{
    case north,south,east,west
}

//你可以用 rawValue属性来访问一个枚举成员的原始值：
let earchsOrder = PlanetList.earth.rawValue

let sunsetDirection = CompassPointList.west.rawValue

// possiblePlanet is of type Planet? and equals Planet.Uranus
let possiblePlanet = PlanetList(rawValue: 7)

let positionToFind = 11
if let somePlanet = PlanetList(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Not a safe place for humans")
    default:
        print("Not a safe place for humans")
    }
}else{
    print("There is not a planet at position \(positionToFind)")
}

//递归枚举
enum ArithmeticExpression1 {
    case number(Int)
    indirect case addition(ArithmeticExpression1,ArithmeticExpression1)
    indirect case multiplication(ArithmeticExpression1,ArithmeticExpression1)
}

indirect enum ArithmeticExpression2{
    case number(Int)
    case addition(ArithmeticExpression2,ArithmeticExpression2)
    case multiplication(ArithmeticExpression2,ArithmeticExpression2)
}

let five = ArithmeticExpression1.number(5)
let four = ArithmeticExpression1.number(4)
let sum = ArithmeticExpression1.addition(five, four)
let product = ArithmeticExpression1.multiplication(sum, ArithmeticExpression1.number(2))

func evaluate(_ expression:ArithmeticExpression1) -> Int{
    switch expression {
    case let .number(value):
        return value
    case let .addition(left,right):
        return evaluate(left)+evaluate(right)
    case let .multiplication(left,right):
        return evaluate(left)*evaluate(right)
}
}

print(evaluate(product))


