import UIKit

var str = "Hello, playground"

class Person {
    var residence: Residence?
}

//class Residence {
//    var numberOfRooms = 1
//}
//
//let john = Person()
//
//if let roomCount = john.residence?.numberOfRooms {
//    print("John is residence has \(roomCount) rooms(s).")
//}else{
//    print("Unable to retrive the number of rooms.")
//}
//
//john.residence = Residence()
//
//if let roomCount = john.residence?.numberOfRooms {
//    print("John is residence has \(roomCount) room(s).")
//}else{
//    print("Unable to retrive the number of rooms.")
//}

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

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentidier() -> String? {
        if buildingName != nil {
            return buildingName
        }else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        }else{
            return nil
        }
    }
}

let john = Person()
if let roomCount = john.residence?.numberOfRooms{
    print("John is residence has \(roomCount) room(s).")
}else{
    print("Unable to retrive the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john.residence?.address = createAddress()

if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
}else{
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
}else{
    print("It was not possible to set the address.")
}

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else{
    print("Unable to retrive the first room name.")
}

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
}else{
    print("Unable to retrive the first room name.")
}

if let johnsStreet = john.residence?.address?.street {
    print("John is street name is \(johnsStreet)")
}else{
    print("Unable to retrive the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address=johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John is street name is \(johnsStreet).")
}else{
    print("Unable to retrive the address.")
}

if let buildingIdentifier = john.residence?.address?.buildingIdentidier() {
    print("John is building identifier is \(buildingIdentifier).")
}

if let beginswithThe = john.residence?.address?.buildingIdentidier()?.hasPrefix("The") {
    if beginswithThe {
        print("John is building identifier begins with \"The\".")
    }else{
        print("John is building identifier does not begin with \"The\".")
    }
}
