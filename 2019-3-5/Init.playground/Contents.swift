import UIKit

struct Fahrenheit{
    var temperature:Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temprature is \(f.temperature) Fahrenheit")

//如果一个属性一直保持相同的初始值，可以提供一个默认值而不是在初始化器里设置这个值。最终结果是一样的，但是默认值将属性的初始化与声明更紧密地联系到一起。它使得你的初始化器更短更清晰，并且可以让你属性根据默认值推断类型。如后边的章节所述，默认值也让你使用默认初始化器和初始化器继承更加容易。

struct FahrenheitStruct{
    var temperature = 32.0
}

struct Celsius{
    var temeratureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temeratureInCelsius = (fahrenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin: Double) {
        temeratureInCelsius = kelvin - 273.15
    }
    //无实际参数标签的初始化器形式参数
    init(_ celsius: Double) {
        temeratureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

struct Color{
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let bodyTemperature = Celsius(37.0)

class SurveyQuestion{
    var text:String
    var response: String?
    init(text: String) {
        self.text=text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes,I do like cheese."

class SurveyQuestionConst{
    let text:String
    var response: String?
    init(text:String) {
        self.text=text
    }
    func ask() {
        print(text)
    }
}

let beetsQuetion = SurveyQuestionConst(text: "How about beets?")
beetsQuetion.ask()
beetsQuetion.response="I also like beets.(But not with cheese.)"

class ShoppingListItem{
    var name:String?
    var quantity = 1
    var perchased = false
}
var item = ShoppingListItem()

struct SizeDefault{
    var width = 0.0, height = 0.0
}
let twoByTwo = SizeDefault(width: 2.0, height: 2.0)

struct Size{
    var width = 0.0, height=0.0
}

struct Point{
    var x = 0.0, y=0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point,size:Size) {
        self.origin=origin
        self.size=size
    }
    init(center:Point,size:Size) {
        let originX = center.x-(size.width/2)
        let originY = center.y-(size.height/2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let asicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

class Vehicle{
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle{
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Food{
    var name:String
    init(name: String) {
        self.name=name
    }
    convenience init(){
        self.init(name: "[unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food()

class RecipeIngredient: Food{
    var quantity: Int
    init(name:String, quantity:Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItemAnother: RecipeIngredient{
    var purchased = false
    var description:String{
        var output = "\(quantity) x \(name)"
        output += purchased ? "🙆" : "🙅"
        return output
    }
}

var breakfastList = [
    ShoppingListItemAnother(),
    ShoppingListItemAnother(name: "Bacon"),
    ShoppingListItemAnother(name: "Eggs", quantity: 6)
]

breakfastList[0].name="Orange juice"
breakfastList[0].purchased=true
for item in breakfastList{
    print(item.description)
}

let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber){
    print("\(wholeNumber) conversion to int maintains value")
}

let valueChanged = Int(exactly: pi)

if valueChanged == nil {
    print("\(pi) conversion to int does not maintain value")
}

struct Animal{
    let species:String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

let somCreature = Animal(species: "Giraffe")

if let giraffe = somCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreture = Animal(species: "")

if anonymousCreture == nil {
    print("The anonymous creature could not be initialized")
}

enum TemperatureUnit{
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character){
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

//你可以使用可失败初始化器为可能的三种状态来选择一个合适的枚举情况，当参数的值不能与任意一枚举成员相匹配时，该枚举类型初始化失败：
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil{
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil{
    print("This is not a defined temperature unit, so initialization failed.")
}

//带有原始值的枚举会自动获得一个可失败初始化器 init?(rawValue:) ，该可失败初始化器接收一个名为 rawValue 的合适的原始值类型形式参数如果找到了匹配的枚举情况就选择其一，或者没有找到匹配的值就触发初始化失败。
enum TemperatureUnitDefault: Character{
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnitDefault = TemperatureUnitDefault(rawValue: "F")
if fahrenheitUnitDefault != nil{
    print("This is a defined temperature unit,so initialization succeeded.")
}

let unknownUnitDefault = TemperatureUnitDefault(rawValue: "X")
if unknownUnitDefault == nil{
    print("This is not a defined temperature unit, so initialization failed.")
}

class Product{
    let name:String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name=name
    }
}

class CarItem: Product{
    let quantity: Int
    init?(name:String,quantity: Int) {
        if quantity < 1{
            return nil
        }
        self.quantity=quantity
        super.init(name: name)
    }
}

if let twoSocks = CarItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name),quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CarItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name),quantity: \(zeroShirts.quantity)")
}else{
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CarItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name),quantity: \(oneUnnamed.quantity)")
}else{
    print("Unable to initialize one unnamed product")
}

class Document{
    var name: String?
    init() {
        
    }
    init?(name: String) {
        self.name=name
        if name.isEmpty{
            return nil
        }
    }
}

class AutomaticallyNamedDocument: Document{
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty{
            self.name = "[Untitled]"
        }else{
            self.name=name
        }
    }
}

//强制展开
class UntitledDocument: Document{
    override init() {
        super.init(name: "[Untitled]")!
    }
}

struct Chessboard{
    let voardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8{
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row:Int, column: Int) -> Bool {
        return voardColors[(row*8)+column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))

