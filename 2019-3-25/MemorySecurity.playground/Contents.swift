import UIKit

var one = 1
print("We are number \(one)!")

func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

//输入输出形式参数的访问冲突
var stepSize = 1

func increment(_ number: inout Int){
    number += stepSize
}

//increment(&stepSize)//❌

//一种解决这个冲突的办法是显式地做一个 stepSize 的拷贝：
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

stepSize = copyOfStepSize

//输入输出形式参数的长时写入访问的另一个后果是传入一个单独的变量作为实际形式参数给同一个函数的多个输入输出形式参数产生冲突。
func balance(_ x: inout Int, _ y: inout Int){
    let sum = x+y
    x=sum / 2
    y=sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)

//balance(&playerOneScore, &playerOneScore)//❌

struct Player{
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player{
    mutating func shareHealth(with teammate: inout Player){
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)

//oscar.shareHealth(with: &oscar)//❌

var playerInformation = Player(name: "BIGBOY", health: 10, energy: 20)
//balance(&playerInformation.health, &playerInformation.energy)//❌

//实际上，大多数对结构体属性的访问可以安全的重叠。
func someFunction(){
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)
}

someFunction()






