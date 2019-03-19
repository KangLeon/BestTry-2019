import UIKit

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded:Int)
    case outOfStock
}

struct Item{
    var price: Int
    var count: Int
}

class VendingMachine{
    var inventory = ["Candy Bar" : Item(price: 12, count: 7),
                     "Chips" : Item(price: 10, count: 4),
                     "Pretzls" : Item(price: 7, count: 11)]
    
    var coinsDeposited = 0
    
    func vend(itemNames name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String,vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNames: snackName)
}

struct PurchasedSnack{
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNames: name)
        self.name = name
    }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do{
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
}catch VendingMachineError.invalidSelection{
    print("Invalid Selection.")
}catch VendingMachineError.outOfStock{
    print("Out of Stock")
}catch VendingMachineError.insufficientFunds(let coinsNeeded){
    print("Insufficient funds.Please insert an additional \(coinsNeeded) coins.")
}

func nourish(with item: String) throws {
    do{
        try  vendingMachine.vend(itemNames: item)
    }catch is VendingMachineError{
        print("Invalid selection, Out of stock, or not enough money.")
    }
}

do{
    try nourish(with: "Beet-Flavored Chips")
}catch{
    print("Unexpected non_vending_machine_related error: \(error)")
}

//func fetchData() -> Data?{
//    if let data = try? fetDataFromDisk(){
//        return data
//    }
//    if let data = try? fetchDataFromServer() {
//        return data
//    }
//    return nil
//}

//let photo = try! loadImage("./Resources/john Appleseed.jpg")



