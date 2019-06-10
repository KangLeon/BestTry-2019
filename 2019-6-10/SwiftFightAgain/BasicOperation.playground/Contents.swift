import UIKit

var str = "Hello, playground"

let b = 10
var a = 5
a = b

let (x,y) = (1,2)

print("hello" + "world")

9%4

-9%4

let three = 3
let minusThree = -three
let plusThree = -minusThree

let minusSix = -6
let alsoMinusSix = +minusSix

var a_complex = 1
a_complex += 2

let name = "world"
if name == "world" {
    print("hello,world")
}else{
    print("I am sorry \(name), but i do not recognize you")
}

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

let defaultColorName = "red"
var userDefinedColorName: String?
var colorNametoUse = userDefinedColorName ?? defaultColorName

userDefinedColorName = "green"
colorNametoUse = userDefinedColorName ?? defaultColorName

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let names = ["Anna","Alex","Brian","Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i+1) is called \(names[i])")
}

for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}

let range = ...5
range.contains(7)
range.contains(4)
range.contains(-1)

let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
}else{
    print("ACCESS DENIED")
}

let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
}else{
    print("ACCESS DENIED")
}

if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welocome!")
}else{
    print("ACCESS DENIED")
}







