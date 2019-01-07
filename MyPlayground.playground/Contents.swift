import UIKit

var str = "Hello, playground"


func sunNumbers(numbers:Int...)->Int{
    var total = 0
    for number in numbers {
        total+=number
    }
    return total
}
let sum = sunNumbers(numbers: 2,3,4,5)
print(sum)

if 1+1==2 {
    print("结果相等")
}

let loopingArray = [1,2,3,4,5]
var loopSum = 0
for number in loopingArray {
    loopSum+=number
}
print(loopSum)

var firstCounter = 0
//Immutable value 'index' was never used; consider replacing with '_' or removing it
for _ in 1..<10 {
    firstCounter+=1
}




