import UIKit
class Person{
    var residence: Residence?
}

//class Residence{
//    var numberOfRooms = 1
//}

let john = Person()

//触发一个运行时错误
//let roomCount = john.residence!.numberOfRooms

if let roomCount = john.residence?.numberOfRooms{
    print("John`s residence has \(roomCount) rooms(s).")
}else{
    print("Unable to retrive the number of rooms.")
}

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John`s residence has \(roomCount) room(s).")
}else{
    print("Unable to retrive the number of rooms.")
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room{
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(String(describing: buildingNumber)) \(String(describing: street))"
        } else {
            return nil
        }
    }
}


let johnOption = Person()
if let roomCount = johnOption.residence?.numberOfRooms{
    print("John`s residence has \(roomCount) room(s).")
}else{
    print("Unable to retrive the number of rooms.")
}

//= 运算符右手侧的代码都不会被评判
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
johnOption.residence?.address = someAddress

func createAddress() -> Address{
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
johnOption.residence?.address = createAddress()

if johnOption.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
}else{
    print("It was not possible to print the number of rooms.")
}

if (johnOption.residence?.address = someAddress) != nil {
    print("It was possible to the address.")
}else{
    print("It was not possible to set the address.")
}

if let firstRoomName = johnOption.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else{
    print("Unable to retrive the first room name.")
}

johnOption.residence?[0] = Room(name: "Bathroom")

let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Living Room"))
johnHouse.rooms.append(Room(name: "Kitchen"))
johnOption.residence = johnHouse

if let firstRoomName = johnOption.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else{
    print("Unable to retrieve the first room name.")
}

var testScores = ["Dave": [86,82,84],"Bev":[79,94,81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

if let johnsStreet = johnOption.residence?.address?.street{
    print("John`s street name is \(johnsStreet).")
}else{
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
johnOption.residence?.address = johnsAddress

if let johnsStreet = johnOption.residence?.address?.street {
    print("John` street name is \(johnsStreet).")
}else{
    print("Unable to retrive the address.")
}

if let buildingIdentifier = johnOption.residence?.address?.buildingIdentifier() {
    print("John`s building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = johnOption.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John`s building identifier begins with \"The\".")
    }else{
        print("John`s building identifier does not begin with \"The \".")
    }
}
