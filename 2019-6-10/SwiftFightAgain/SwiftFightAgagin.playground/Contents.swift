import UIKit

var str = "Hello, playground"

let maxmumNumberOfLoginAttempts=10

var currentLoginAttempt = 0

var welcomeMessage: String

welcomeMessage = "Hello"

var red,green,blue: Double

let pi = 3.1415926

let 你好 = "你好世界"
let  ？？ = "dogcow"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

print(friendlyWelcome)

print(friendlyWelcome, separator: "hhhh", terminator: "")

print("The current value of friendlyWelcome is \(friendlyWelcome)")

let cat = "?"; print(cat)

let minValue = UInt8.min
let maxValue = UInt8.max

let meaningOfLife = 42

let pi_1 = 3.1415926

let anotherPi = 3+0.1415926

let decimalInteger = 17
let binaryInteger = 0b10001
let octalIntger = 0o21
let hexoadecimalInteger = 0x11

let twoThousand: UInt16 = 2000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

let three = 3
let pointOneFourOneFiveNine = 0.1415927
let pi_2 = Double(three) + pointOneFourOneFiveNine

let integerPi = Int(pi_2)

let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
}else{
    print("Eww, turnips are horrible.")
}

let http404Error = (404, "Not Found")

let (statusCode,statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")

print("The status code is \(http200Status.statusCode)")
print("The status messafe is \(http200Status.description)")

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

var serverResponseCode: Int? = 404
serverResponseCode = nil

var surveyAnswer: String?

if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
}else{
    print("\'\(possibleNumber)\' could not be converted to an integer")
}

if let firstNumber = Int("4"),let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString

if assumedString != nil {
    print(assumedString)
}

if let definiteString = assumedString {
    print(definiteString)
}

//func makeASandwich() throws{
//
//}
//
//do {
//    try makeASandwich()
//    eatASandwich()
//} catch Error.outOfCleanDishes {
//    washDishes()
//} catch Error.MissingIngredients (let ingredients) {
//    buyGroceries(ingredients)
//}

let age = -3
//assert(age>=0, "A person's age cannot be less than zero")

//assert(age >= 0)

if age > 10{
    print("You can ride the roller-coaster or the ferris wheel.")
}else if age > 0{
    print("You can ride the ferris wheel.")
}else{
//    assertionFailure("A person's age can not be less than zero.")
}

let index_1 = 3
precondition(index_1 > 0, "Index must be greater than zero.")

















