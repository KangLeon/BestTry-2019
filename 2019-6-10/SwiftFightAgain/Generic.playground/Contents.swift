import UIKit

var str = "Hello, playground"

func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 4
var anotherInt = 107
swap(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt_1 = 3
var anotherInt_1 = 107
swapTwoValues(&someInt_1, &anotherInt_1)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element>{
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cautro")

let fromTheTop = stackOfStrings.pop()





