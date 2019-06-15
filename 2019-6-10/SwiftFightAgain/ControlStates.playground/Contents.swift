import UIKit

var str = "Hello, playground"

let names = ["Anna","Alex","Brian","Jack"]

for name in names {
    print("Hello, \(name)")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]

for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

print("\(base) to the power of \(power) is \(answer)")

let minutes = 60
for tickMark in 0..<minutes {
    print("当前时间为：\(tickMark)minutes")
}

let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print("每隔5分钟报时一次，当前时间为：\(tickMark)minutes")
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, to: hours, by: hourInterval) {
    print("\(tickMark)")
}

var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It is very cold.Consider wearing a scarf.")
}

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It is very cold. Consider wearing a scarf.")
}else{
    print("It is not that cold.Wear a t-shirt.")
}

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It is very cold. Consider wearing a scarf.")
}else if temperatureInFahrenheit >= 86 {
    print("It is really warm. Do not forget to wear sunscreen.")
}else{
    print("It is not that cold. Wear a t-shirt.")
}

let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not thr letter A")
}

let approximateCount = 62
let countedThings = "Moons orbiting Saturn"
var naturaicount: String
switch approximateCount {
case 0:
    naturaicount = "no"
case 1..<5:
    naturaicount = "a few"
case 5..<12:
    naturaicount = "several"
case 12..<100:
    naturaicount = "dozens of"
case 100..<1000:
    naturaicount = "hundreds of"
default:
    naturaicount = "many"
}

print("There are \(naturaicount) \(countedThings)")

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

let anotherPoint = (2,0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let(x, y):
    print("somewhere else at \(x), \(y)")
}

let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x) ,\(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x ,y):
    print("(\(x), \(y)) is just some arbitrary point")
}

let someCharacterMuti: Character = "e"
switch someCharacterMuti {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y","z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}

let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a","e","i","o"," "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }else{
        puzzleOutput.append(character)
    }
}

print(puzzleOutput)

let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
case "一":
    possibleIntegerValue = 1
case "二":
    possibleIntegerValue = 2
case "三":
    possibleIntegerValue = 3
case "四":
    possibleIntegerValue = 4
default:
    break
}

if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
}else{
    print("An integer value could not be found for \(numberSymbol).")
}

let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2,3,5,7,11,13,17,19:
    description += "a prime number, and also"
    fallthrough
default:
    description += "an integer."
}

print(description)

func greet(person: [String: String]){
    guard let name = person["name"] else {
        return
    }
    
    print("Hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the wether is nice near you.")
        return
    }
    
    print("I hope the wether is nice in \(location).")
}

greet(person: ["name": "John"])

greet(person: ["name": "Jane", "location": "Cupertino"])

if #available(iOS 10, iOSMac 10.12, *) {
    print("ios 10,iosMac 10.12")
}else{
    print("ios 10 below")
}
