// Receiveable, Sendable 프로토콜
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

class Message: Sendable, Receiveable {
    
    var from: Sendable {
        return self
    }
    
    var to: Receiveable?
    
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable) {
        print("Message received \(data) from \(from)")
    }
    // 상속 가능
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

class Mail: Sendable, Receiveable {
    
    var from: Sendable {
        return self
    }
    
    var to: Receiveable?
    
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Mail has no receiver")
            return
        }
        
        receiver.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable) {
        print("Mail received \(data) from \(from)")
    }
    // 상속 불가
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 두 Message 인스턴스를 생성
let myPhoneMessage: Message = Message()
let yourPhoneMesssage: Message = Message()

// 아직 수신받을 인스턴스가 없음
myPhoneMessage.send(data: "Hello")    // Message has no receiver

myPhoneMessage.to = yourPhoneMesssage
myPhoneMessage.send(data: "Hello")    // Message received Hello from Message

// 두 Mail 인스턴스를 생성
let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi")   // Mail has no receiver

myMail.to = yourMail
myMail.send(data: "Hi")   // Mail received Hi from Mail

myMail.to = myPhoneMessage
myMail.send(data: "Bye")  // Message received Bye from Mail

// String은 Sendable 프로토콜을 준수하지 않음
Message.isSendableInstance("Hello") // false

// Mail과 Message는 Sendable 프로토콜을 준수함
Message.isSendableInstance(myPhoneMessage) // true

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태
Message.isSendableInstance(yourPhoneMesssage) // false
Mail.isSendableInstance(myPhoneMessage) // true
Mail.isSendableInstance(myMail) // true


// Resettable 프로토콜의 가변 메서드 요구
protocol Resettable{
    mutating func reset()
}

class Person: Resettable{
    var name: String?
    var age: Int?
    
    func reset(){
        self.name = nil
        self.age = nil
    }
}
struct Point: Resettable{
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction: Resettable{
    case east, west, south, north, unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}

// 이니셜라이저 요구
protocol Named{
    var name: String {get}
    init?(name: String)
}
struct Animal: Named{
    var name: String
    
    init!(name: String){
        self.name = name
    }
}

struct Pet: Named{
    var name: String
    
    init(name: String){
        self.name = name
    }
}

class Person2: Named{
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class School:Named{
    var name: String
    
    required init?(name: String) {
        self.name = name
    }
}

// 프로토콜 조합 및 프로토콜, 클래스 조합
protocol Named2{
    var name: String {get}
}
protocol Aged{
    var age: Int {get}
}

struct Person3: Named2, Aged{
    var name: String
    var age: Int
}

class Car: Named2{
    var name: String
    
    init(name: String){
        self.name=name
    }
}

class Truck: Car, Aged{
    var age: Int
    
    init(name: String, age: Int){
        self.age = age
        super.init(name: name)
    }
}

func celebrateBirthday(to celebrator: Named2 & Aged){
    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let yagom: Person3 = Person3(name: "yagom", age: 99)
let myCar: Car = Car(name: "Boong Boong")
//celebrateBirthday(to: myCar)

//var someVariable: Car & Truck & Aged
var someVariable: Car & Aged
someVariable = Truck(name: "Truck", age: 5)

// someVariable = myCar

print(yagom is Named2)
print(yagom is Aged)
print(myCar is Named2)
print(myCar is Aged)

if let castedInstance: Named2 = yagom as? Named2{
    print("\(castedInstance) is Named")
}

if let castedInstance: Aged = yagom as? Aged{
    print("\(castedInstance) is Aged")
}

if let castedInstance: Named = myCar as? Named{
    print("\(castedInstance) is Named")
}

if let castedInstance: Aged = myCar as? Aged{
    print("\(castedInstance) is Aged")
}


// 프로토콜의 선택적 요구
import Foundation

@objc protocol Moveable{
    func walk()
    @objc optional func fly()
}

class Tiger: NSObject, Moveable{
    func walk(){
        print("Tiger walks")
    }
}

class Bird: NSObject, Moveable{
    func walk(){
        print("Birds walks")
    }
    func fly(){
        print("Birds fly")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()
bird.walk()
bird.fly()

var movableInstance: Moveable = tiger
movableInstance.fly?()

movableInstance = bird
movableInstance.fly?()

var someNamed: Named = Animal(name: "Animal")
someNamed = Pet(name: "Pet")
someNamed = Person2(name: "Person")
someNamed = School(name: "School")!

