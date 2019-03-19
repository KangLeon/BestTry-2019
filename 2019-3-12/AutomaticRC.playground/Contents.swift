import UIKit

class Person{
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "Kang Leon")
reference2 = reference1
reference3 = reference1

reference1=nil
reference2=nil
reference3=nil

class PersonARC{
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment{
    let unit:String
    init(unit: String) {
        self.unit=unit
    }
    var tenant: PersonARC?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: PersonARC?
var unit4A: Apartment?

john = PersonARC(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

//强引用
john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil

class PersonWeak{
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: ApartmentWeak?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class ApartmentWeak{
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    weak var tenant: PersonWeak?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var johnWeak: PersonWeak?
var unit4AWeak: ApartmentWeak?

johnWeak = PersonWeak(name: "John Appleseed")
unit4AWeak = ApartmentWeak(unit: "4A")

johnWeak!.apartment=unit4AWeak
unit4AWeak!.tenant=johnWeak

//为什么不会释放
johnWeak = nil
unit4AWeak = nil

class Customer{
    let name: String
    var card: CreditCard?
    init(name:String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard{
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) us being deinitialized")
    }
}

var johnUnknow: Customer?
johnUnknow = Customer(name: "John Appleseed")
johnUnknow!.card = CreditCard(number: 1234_5678_9012_3456, customer: johnUnknow!)

johnUnknow = nil

class Country{
    let name: String
    var capatalCity: City!
    init(name: String, capitalName: String) {
        self.name=name
        self.capatalCity=City(name: capitalName, country: self)
    }
}

class City{
    let name: String
    unowned let country: Country
    init(name:String, country: Country) {
        self.name=name
        self.country=country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)`s capital city is called \(country.capatalCity.name)")

class HTMLElement{
    let name: String
    let text: String?
    lazy var asHTML: ()-> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else{
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)<\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello world")
print(paragraph!.asHTML())

paragraph = nil

class HTMLElementNoHost{
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else{
            return "<\(self.name) />"
        }
    }
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraphNoHost: HTMLElement? = HTMLElement(name: "p", text: "hello world")
print(paragraphNoHost!.asHTML())

paragraphNoHost = nil


