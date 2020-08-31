// 익스텐션을 통한 프로토콜의 실제 구현 -> 프로토콜 초기구현
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

extension Receiveable{
    func received(data: Any, from: Sendable){
        print("\(self) received \(data) from \(from)")
    }
}
 
protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

extension Sendable {
    var from: Sendable{
        return self
    }
    
    func send(data: Any){
        guard let receiver: Receiveable = self.to else{
            print("Message has no receiver")
            return
        }
        receiver.received(data: data, from: self.from)
    }
    
    static func isSendableInstance(_ instance: Any) -> Bool{
        if let sendableInstance: Sendable = instance as? Sendable{
            return sendableInstance.to != nil
        }
        return false
    }
}

class Message: Sendable, Receiveable {
    var to: Receiveable?
}

class Mail: Sendable, Receiveable{
    var to: Receiveable?
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

// 익스텐션을 통해 구현된 메서드 재정의
class Mail2: Sendable, Receiveable{
    var to: Receiveable?
    
    func send(data: Any){
        print("Mail의 send 메서드는 재정의되었습니다.")
    }
}

let mailIntance: Mail2 = Mail2()
mailIntance.send(data: "Hello")

// 제너릭, 프로토콜, 익스텐션을 통한 재사용 가능한 코드 작성
protocol SelfPrintable{
    func printSelf()
}

extension SelfPrintable where Self: Container{
    func printSelf(){
        print(items)
    }
}

protocol Container: SelfPrintable{
    associatedtype ItemType
    
    var items: [ItemType] {get set}
    var count: Int {get}
    
    mutating func append(item: ItemType)
    subscript(i: Int) -> ItemType {get}
}

extension Container {
    
    mutating func append(item: ItemType) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> ItemType {
        return items[i]
    }
}

protocol Popable: Container{
    mutating func pop() -> ItemType?
    mutating func push(_ item: ItemType)
}

extension Popable{
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }
    mutating func push(_ item: ItemType){
        self.append(item: item)
    }
}

protocol Insertable: Container{
    mutating func delete() -> ItemType?
    mutating func insert(_ item: ItemType)
}

extension Insertable{
    mutating func delete() -> ItemType? {
        return items.removeFirst()
    }
    mutating func insert(_ item: ItemType){
        self.append(item: item)
    }
}

struct Stack<Element>: Popable{
    var items: [Element] = [Element]()
    
    // 맵 메서드
    func map<T>(transform: (Element) -> T) -> Stack<T>{
        var transforemdStack: Stack<T> = Stack<T>()
        
        for item in items{
            transforemdStack.items.append(transform(item))
        }
        return transforemdStack
    }
    // 필터 메서드
    func filter(includeElement: (Element) -> Bool) -> Stack<Element>{
        
        var filteredStack: Stack<ItemType> = Stack<ItemType>()
        
        for item in items{
            if includeElement(item){
                filteredStack.items.append(item)
            }
        }
        return filteredStack
    }
    
    func reduce<T>(_ initialResult: T, nextpartialResult: (T, Element) -> T) -> T{
        var result: T = initialResult
        
        for item in items{
            result = nextpartialResult(result, item)
        }
        return result
    }

}

struct Queue<Element>: Insertable{
    var items: [Element] = [Element]()
}

var myIntStack: Stack<Int> = Stack<Int>()
var myStringStack: Stack<String> = Stack<String>()

var myIntQueue: Queue<Int> = Queue<Int>()
var myStringQueue: Queue<String> = Queue<String>()

myIntStack.push(3)
myIntStack.printSelf()

myIntStack.push(2)
myIntStack.printSelf()

myIntStack.pop()
myIntStack.printSelf()

myStringStack.push("A")
myStringStack.printSelf()


myStringStack.push("B")
myStringStack.printSelf()

myStringStack.pop()
myStringStack.printSelf()


myIntQueue.insert(3)
myIntQueue.printSelf()

myIntQueue.insert(2)
myIntQueue.printSelf()

myIntQueue.delete()
myIntQueue.printSelf()

myStringQueue.insert("A")
myStringQueue.printSelf()

myStringQueue.insert("B")
myStringQueue.printSelf()

myStringQueue.delete()
myStringQueue.printSelf()


myIntStack.push(1)
myIntStack.push(5)
myIntStack.push(2)
var myStrStack: Stack<String> = myIntStack.map{ "\($0)"}
myStrStack.printSelf()

let filteredStack: Stack<Int> = myIntStack.filter{ (item: Int) -> Bool in
    return item < 5
}
filteredStack.printSelf()

let combinedInt: Int = myIntStack.reduce(100) {(result: Int, next: Int) -> Int in
    return result + next
}
print(combinedInt)

let combinedDouble: Double = myIntStack.reduce(100.0) {(result: Double, next: Int) -> Double in
    return result + Double(next)
}
print(combinedDouble)

let combinedString: String = myIntStack.reduce("") {(result: String, next: Int) -> String in
    return result + "\(next) "
}
print(combinedString)

