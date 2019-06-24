import UIKit

var str = "Hello, playground"

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()

print("The default temperature is \(f.temperature) Fahrenheit")

struct FahrenheitSingle {
    var temperature = 32.0
}

struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)

struct Color {
    let red, green, blue: Double
    init(R red: Double, G green: Double, B blue: Double) {
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

let magenta = Color(R: 1.0, G: 0.0, B: 1.0)
let halfGray = Color(white: 0.5)

struct CelsiusNone {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let bodyTemperature = CelsiusNone(37.0)

class SurveyQustion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQustion(text: "do you like cheese?")
cheeseQuestion.ask()

cheeseQuestion.response = "Yes, I do like cheese"


class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)

let zeroByTwo = Size()

print(zeroByTwo.width, zeroByTwo.height)

//struct Size {
//    var width = 0.0, height = 0.0
//}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {
    }
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect ()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

let centerRect = Rect (center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")

let mysteryMeat = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name:"Eggs", quantity: 6)

class ShoppintListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) * \(name)"
        output += purchased ? "right" : "wrong"
        
        return output
    }
}

var breakfastList = [
    ShoppintListItem(),
    ShoppintListItem(name: "Bacon"),
    ShoppintListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
}

let wholeNumber: Double = 12345.0
let pi = 3.1415926

if Int(exactly: wholeNumber) != nil {
    print("\(wholeNumber) conversion to int maintains value")
}

let valueChanged = Int(exactly: pi)

if valueChanged == nil {
    print("\(pi) conversion to int does not maintain value")
}

struct Animal {
    let  species: String
    init?(spicies: String) {
        if spicies.isEmpty {
            return nil
        }
        self.species = spicies
    }
}

let someCreature = Animal(spicies: "Giraffe")

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(spicies: "")

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

enum TemperatureUnit {
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

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

enum TemperatureUnitRawValue: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnitRawValue = TemperatureUnitRawValue(rawValue: "F")
if fahrenheitUnitRawValue != nil {
    print("This ia a defined temperature unit, so initialization succeeded.")
}

let unknownUnitRawValue = TemperatureUnitRawValue(rawValue: "X")
if unknownUnitRawValue == nil {
    print("This is not be a defined temperature unit, so initialization failed.")
}

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int){
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem(name: "sock", quantity: 2){
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
}else{
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
}else{
    print("Unable to initialize one unnamed product")
}

class Document {
    var name: String?
    init() {}
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init?(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        }else{
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

struct Chessboard {
    let boardcolors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardcolors[(row * 8) + column]
    }
}



