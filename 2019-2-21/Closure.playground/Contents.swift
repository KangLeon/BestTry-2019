import UIKit

let names = ["Chris","Alex","Ewa","Barry","Daniella"]

func backward(_ s1:String,_ s2:String)->Bool{
    return s1>s2
}

var reversedNames = names.sorted(by:backward)

//下面这个栗子展示一个之前 backward(_:_:) 函数的闭包表达版本：
reversedNames=names.sorted(by:{(s1:String,s2:String)->Bool in
    return s1>s2
})

reversedNames=names.sorted(by:{(s1:String,s2:String)->Bool in return s1>s2})

//从语境中推断类型
reversedNames=names.sorted(by: { s1,s2 in return s1 > s2})
//从单表达式闭包隐式返回
reversedNames=names.sorted(by:{s1,s2 in s1>s2})

//简写的实际参数名
reversedNames=names.sorted(by:{$0 > $1})

//运算符函数
reversedNames=names.sorted(by: > )
//如果你需要将一个很长的闭包表达式作为函数最后一个实际参数传递给函数，使用尾随闭包将增强函数的可读性。尾随闭包是一个被书写在函数形式参数的括号外面（后面）的闭包表达式：
reversedNames=names.sorted(){$0>$1}

reversedNames=names.sorted{$1>$1}

//当闭包很长以至于不能被写成一行时尾随闭包就显得非常有用了。
let digitNames = [0:"Zero",1:"One",2:"Two",3:"Three",4:"Four",5:"Five",6:"Six",7:"Seven",8:"Eight",9:"Nine"]

let numbers = [16,58,510]

//你现在可以通过传递一个闭包表达式到数组的 map(_:) 方法中作为尾随闭包，利用 number 数组来创建一个 String 类型的数组。值得注意的是 number.map不需要在 map 后面加任何圆括号，因为 map(_:)方法仅仅只有一个形式参数，这个形式参数将以尾随闭包的形式来书写：
let strings = numbers.map{
    (number)->String in//你不需要指定闭包的输入形式参数 number 的类型，因为它能从数组中将被映射的值来做推断。
    var number = number
    var output = ""
    repeat{
        output=digitNames[number%10]!+output
        number/=10
    }while number>0
    return output
}

func makeIncrementer(forIncrement amount:Int) -> () ->Int {
    var runningTotal = 0
    func incrementer() -> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incermentByTen=makeIncrementer(forIncrement: 10)

incermentByTen()
incermentByTen()
incermentByTen()

let incrementBuSeven = makeIncrementer(forIncrement: 7)
incrementBuSeven()

incermentByTen()

//逃逸闭包
var completionHandlers:[()->Void] = []
func someFunctionWithEscapingClosure(completionHandler:@escaping () -> Void){
    completionHandlers.append(completionHandler)
}

//非逃逸闭包
func someFunctionWithNonescapingClosure(closure:() -> Void){
    closure()
}

class SomeClass{
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x=100
        }
        someFunctionWithNonescapingClosure {
            x=200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

//自动闭包,延迟求值。
var customersInLine = ["Chris","Alex","Ewa","Barry","Daniella"]
print(customersInLine.count)

let customerProvider = {customersInLine.remove(at: 0)}
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)





