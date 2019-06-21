import UIKit

var str = "Hello, playground"

func greet(person: String) -> String{
    let greeting = "Hello," + person + "!"
    return greeting
}

print(greet(person: "Anna"))

print(greet(person: "Brian"))

func greetAgain(person: String) -> String{
    return "Hello again," + person + "!"
}

print(greetAgain(person: "Anna"))

func sayHelloWorld() -> String {
    return "hello,world"
}

print(sayHelloWorld())

func greet(person: String, alreadyGreeted: Bool) -> String{
    if alreadyGreeted {
        return greetAgain(person: person)
    }else{
        return greet(person: person)
    }
}

print(greet(person: "Tim Cook", alreadyGreeted: true))

func greetNoReturn(person: String){
    print("Hello, \(person)!")
}

greetNoReturn(person: "Dave")

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

func printwithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

printAndCount(string: "hello,world")

printwithoutCounting(string: "hello,world")

func minMax(array:[Int]) -> (min: Int,max: Int)?{
    if array.isEmpty{return nil}
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }else if value > currentMax{
            currentMax = value
        }
    }
    return (currentMin,currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

func greeting(for person: String) -> String{
    return "Hello, " + person + "!"
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}

print(greet(person: "Bill", from: "Cupertino"))

func someFunction(_ firstParameterName: Int, secondParameterName: Int){
    
}

someFunction(1, secondParameterName: 2)

func someFunction(parameterWithDefault: Int = 12){
    print("\(parameterWithDefault)")
}

someFunction(parameterWithDefault: 6)

someFunction()

func arithmeticMean(_ numbers: Double...) -> Double{
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1,2,3,4,5)

arithmeticMean(3,8.25,18.75)

func swapTwoInts(_ a: inout Int,_ b: inout Int){
    let temporary = a
    a = b
    b = temporary
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and another is now \(anotherInt)")

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int{
    return a*b
}

func printHelloWorld() {
    print("hello,world")
}

var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")

mathFunction = multiplyTwoInts

print("Result: \(mathFunction(2, 3))")

let anotherMathFunction = addTwoInts

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int,_ b: Int){
    print("Result is: \(mathFunction(a,b))")
}

printMathResult(addTwoInts, 3, 5)

func stepForward(_ input: Int) -> Int {
    return input + 1
}

func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue>0)


print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")

func chooseStepFunctionWithInline(backward: Bool) -> (Int) -> Int {
    func stepForwardInline(input: Int) -> Int {return input + 1}
    func stepBackwardInline(input: Int) -> Int {return input - 1}
    return backward ? stepBackwardInline : stepForwardInline
}

var currentValueInline = -4
let moveNearerToZeroInline = chooseStepFunction(backward: currentValueInline > 0)

while currentValueInline != 0 {
    print("\(currentValueInline)...")
    currentValueInline = moveNearerToZeroInline(currentValueInline)
}

print("Zero!")


