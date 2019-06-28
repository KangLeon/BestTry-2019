import UIKit

var str = "Hello, playground"

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGrnerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a) + c).truncatingRemainder(dividingBy: m)
        return lastRandom/m
    }
}

let generator = LinearCongruentialGrnerator()
print("Here is a random number: \(generator.random())")

print("And another one: \(generator.random())")

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGrnerator())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewturnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

protocol TextRepresentable {
    var textualDescription: String {get}
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGrnerator())
print(d12.textualDescription)

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}

let myDice = [d6, d12]
print(myDice.textualDescription)

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

let things: [TextRepresentable] = [d6,d12,simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String {get}
}

protocol Named {
    var name: String {get}
}

protocol Aged {
    var age: Int {get}
}

struct PersonMuti: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name),you are \(celebrator.age)!")
}

let birthdayPerson = PersonMuti(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

protocol HasArea {
    var area: Double {get}
}

class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double { return pi * radius * radius}
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    }else{
        print("Something that does not have an area")
    }
}

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int {get}
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generatorExtension = LinearCongruentialGrnerator()
print("Here is a random number: \(generatorExtension.random())")
print("And here is a random Boolean: \(generatorExtension.randomBool())")

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map{ $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ",") + "]"
    }
}

let murryTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHumster = Hamster(name: "Maurice")
let hamsters = [murryTheHamster, morganTheHamster, mauriceTheHumster]

print(hamsters.textualDescription)



