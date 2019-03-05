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

