// 실패 가능한 Int 이니셜라이저
var stringValue: String = "123"
var integerValue: Int? = Int(stringValue)
print(integerValue)

stringValue = "A123"
integerValue = Int(stringValue)
print(integerValue)

// 스위프트 타입캐스팅
class Coffee{
    let name: String
    let shot: Int
    
    var description: String{
        return "\(shot) shot(s) \(name)"
    }
    
    init(shot: Int){
        self.shot = shot
        self.name = "coffee"
    }
}

class Latte: Coffee{
    var flavor: String
    
    override var description: String{
        return  "\(shot) shot(s) \(flavor) latte"
    }
    
    init(flavor: String, shot: Int){
        self.flavor = flavor
        super.init(shot: shot)
    }
}

class Americano: Coffee{
    let iced: Bool
    
    override var description: String{
         return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool){
        self.iced = iced
        super.init(shot: shot)
    }
}

// 데이터 타입 확인
let coffee: Coffee = Coffee(shot: 1)
print(coffee.description)

let myCoffee: Americano = Americano(shot: 2, iced: false)
print(myCoffee.description)

let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
print(yourCoffee.description)

print(coffee is Coffee)
print(coffee is Americano)
print(coffee is Latte)

print(myCoffee is Coffee)
print(yourCoffee is Coffee)

print(myCoffee is Latte)
print(yourCoffee is Latte)

// 메타 타입
protocol SomeProtocol{}
class SomeClass: SomeProtocol{}

let intType: Int.Type = Int.self
let stringType: String.Type = String.self
let classType: SomeClass.Type = SomeClass.self
let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self

var someType: Any.Type

someType = intType
print(someType)

someType = stringType
print(someType)

someType = classType
print(someType)

someType = protocolProtocol
print(someType)

// type(:of) 함수와 .self의 사용
print(type(of: coffee) == Coffee.self)
print(type(of: coffee) == Americano.self)
print(type(of: coffee) == Latte.self)

print(type(of: coffee) == Americano.self)
print(type(of: myCoffee) == Americano.self)
print(type(of: yourCoffee) == Americano.self)

print(type(of: coffee) == Latte.self)
print(type(of: myCoffee) == Latte.self)
print(type(of: yourCoffee) == Latte.self)

// 다운 캐스팅
let actingConstant: Coffee = Latte(flavor: "vanila", shot: 2)
print(actingConstant)

if let actingOne: Americano = coffee as? Americano {
    print("This is Americano")
}else{
    print(coffee.description)
}

if let actionOne: Latte = coffee as? Latte{
    print("This is Latte")
} else {
    print(coffee.description)
}

if let actingOne: Coffee = coffee as? Coffee{
    print("This is Just Coffee")
} else {
    print(coffee.description)
}

if let actingOne: Americano = myCoffee as? Americano{
    print("This is Americano")
} else {
    print(coffee.description)
}

if let actingOne: Latte = myCoffee as? Latte{
    print("This is Latte")
} else {
    print(coffee.description)
}

if let actingOne: Coffee = myCoffee as? Coffee{
    print("This is Just Coffee")
}else {
    print(coffee.description)
}

let castedCoffee: Coffee = yourCoffee as! Coffee

//let castedAmericano: Americano = coffee as! Americano

// AnyObject의 타입 확인
func checkType(of item: AnyObject){
    if item is Latte{
        print("item is Latte")
    }else if item is Americano {
        print("item is Americano")
    } else if item is Coffee{
        print("item is Coffee")
    }else{
        print("Unknown Type")
    }
}

checkType(of: coffee)
checkType(of: myCoffee)
checkType(of: yourCoffee)
checkType(of: actingConstant)

// AnyObject의 타입캐스팅
func castTypeToAppropriate(item: AnyObject){
    if let castedItem: Latte = item as? Latte{
        print(castedItem.description)
    }else if let castedItem: Americano = item as? Americano{
        print(castedItem.description)
    }else if let castedItem: Coffee = item as? Coffee{
        print(castedItem.description)
    }else{
        print("Unknown Type")
    }
}

castTypeToAppropriate(item: coffee)
castTypeToAppropriate(item: myCoffee)
castTypeToAppropriate(item: yourCoffee)
castTypeToAppropriate(item: actingConstant)

// Any의 타입캐스팅
func checkAnyType(of item: Any){
    switch item{
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as an Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I done't want to print")
    case let someString as String:
        print("a string vlaue of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x,y) point at \(x), \(y)")
    case let latte as Latte:
        print(latte.description)
    case let stringConverter as (String) -> String:
        print(stringConverter("yagom"))
    default:
        print("something else : \(type(of: item))")
    }
}

checkAnyType(of: 0)
checkAnyType(of: 0.0)
checkAnyType(of: 42)
checkAnyType(of: 3.14159)
checkAnyType(of: -0.25)
checkAnyType(of: "hello")
checkAnyType(of: (3.0, 5.0))
checkAnyType(of: yourCoffee)
checkAnyType(of: coffee)
checkAnyType(of: {(name: String) -> String in "Hello, \(name)"})
