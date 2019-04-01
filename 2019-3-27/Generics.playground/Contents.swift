import UIKit

func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temoraryA = a
    a = b
    b = temoraryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and another is now \(anotherInt)")

func swapTwoValue<T>(_ a: inout T,_ b: inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}

swapTwoValue(&someInt, &anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValue(&someString, &anotherString)

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
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

func findIndex(ofSring valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat","dog","llama","parakeet","terrapin"]
if let foundIndex = findIndex(ofSring: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

func findIndex<T :Equatable>(of valueTofind: T, in array:[T]) -> Int? {
    for (index,value) in array.enumerated() {
        if value == valueTofind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159,0.1,0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike","Malcolm","Andrea"])

protocol Container {
    associatedtype itemType
    mutating func append(_ item: itemType)
    var count: Int { get }
    subscript(i: Int) -> itemType { get }
}

struct IntStackContainer: Container {
    var items = [Int]()
    mutating func push(_ item: Int){
        items.append(item)
    }
    mutating func pop() -> Int{
        return items.removeLast()
    }
    typealias itemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int{
        return items.count
    }
    subscript(i: Int) -> Int{
        return items[i]
    }
}

struct StackContainer<Element>: Container {
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    mutating func append(_ item: Element){
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

protocol ContainerNew {
    associatedtype Item: Equatable
    mutating func append( _ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//protocol SuffixableContainer: Container {
//    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
//    func suffix(_ size: Int) -> Suffix
//}
//
//extension StackSuffixableContainer {
//    func suffix(_ size: Int) -> Stack {
//        var result = Stack()
//        for index in (count-size)..<count {
//            result.append(self[index])
//        }
//        return result
//    }
//}
//
//var stackOfInts = Stack<Int>()
//stackOfInts.append(10)
//stackOfInts.append(20)
//stackOfInts.append(30)
//let suffix = stackOfInts.suffix(2)
//
//extension IntStack: SuffixableContainer {
//    func suffix(_ size: Int) -> Stack<Int> {
//        var result = Stack<Int>()
//        for index in (count - size)..<count {
//            result.append(self[index])
//        }
//        return result
//    }
//}

extension Array: Container {
    
}

func allItemsMatch<C1: Container,C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.itemType == C2.itemType,C1.itemType: Equatable{
    if someContainer.count != anotherContainer.count{
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

var stackOfStringsWhere = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrOfStrings = ["uno","dos","tres"]

//if allItemsMatch(stackOfStringsWhere, arrOfStrings) {
//    print("All items match.")
//}else{
//    print("Not all items match.")
//}

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
}else{
    print("Top element is something else.")
}

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9,9,9].startIndex(42) {
    print("Starts with 42.")
}else{
    print("Starts with something else.")
}

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum/Double(count)
    }
}
print([126.0,1200.0,98.6,37.0].average())

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComarableContainer: Container where Item: Comparable {  }

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}
