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




