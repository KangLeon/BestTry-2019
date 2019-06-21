import UIKit

var str = "Hello, playground"

let names = ["Chris","Alex","Ewa","Barry","Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})

reversedNames = names.sorted(by: {s1, s2 in s1 > s2})

reversedNames = names.sorted(by: { $0 > $1 })

reversedNames = names.sorted(by: >)

reversedNames = names.sorted(){ $0 > $1 }

reversedNames = names.sorted { $0 > $1 }

let digitNames = [
    0: "Zero",1: "One",2: "Two", 3: "Three",4: "Four",
    5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
]

let numbers = [16,58,510]

let strings = numbers.map{
    (number) -> String in
    var number = number
    var output = ""
    repeat{
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    return output
}

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runnigTotal = 0
    func incrementer() -> Int {
        runnigTotal += amount
        return runnigTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()

incrementByTen()

incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)

incrementBySeven()

incrementByTen()

let alsoIncrementByTen = incrementByTen

alsoIncrementByTen()

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonesacapingClosure(closure: () -> Void){
    closure()
}

class SomeClass{
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonesacapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

var customersInLine = ["Chris","Alex","Ewa","Barry","Daniella"]
print(customersInLine.count)

let custeomerProvide = {customersInLine.remove(at: 0)}
print(customersInLine.count)

print("Now serving \(custeomerProvide())!")

print(customersInLine.count)

func serve(customer customerProvide: () -> String){
    print("Now serving \(customerProvide())!")
}

serve(customer: { customersInLine.remove(at: 0) })

func serve(customer customerProvide: @autoclosure () -> String){
    print("Now serving \(customerProvide())!")
}

serve(customer: customersInLine.remove(at: 0))

var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String){
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}




