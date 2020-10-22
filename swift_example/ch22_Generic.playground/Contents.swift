// 프로토콜과 제네릭을 이용한 전위 연산자 구현과 사용
prefix operator **

prefix func ** <T: BinaryInteger> (value: T) -> T {
    return value * value
}

let minusFive: Int = -5
let five: UInt = 5

let sqrtMinusFive: Int = **minusFive
let sqrtFive: UInt = **five

print(sqrtMinusFive)
print(sqrtFive)

// 제네릭을 사용하지 않은 swapTwoInts 함수
func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temporaryA: Int = a
    a = b
    b = temporaryA
}

var numberOne: Int = 5
var numberTwo: Int = 10

swapTwoInts(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")

// 제네릭을 사용한 swapTwoValues 함수

var stringOne: String = "A"
var stringTwo: String = "B"

var anyOne: Any = 1
var anyTwo: Any = "Two"

func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let temporaryA: T = a
    a = b
    b = temporaryA
}

swapTwoValues(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")

swapTwoValues(&stringOne, &stringTwo)
print("\(stringOne), \(stringTwo)")

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")

//swapTwoValues(&numberOne, &stringOne)

// 제네릭을 사용한 Stack 구조체 타입 + Container 프로토콜 준수
struct Stack<Element>: Container{
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() -> Element{
        return items.removeLast()
    }
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int{
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

var doubleStack: Stack<Double> = Stack<Double>()

doubleStack.push(1.0)
print(doubleStack.items)
doubleStack.push(2.0)
print(doubleStack.items)
doubleStack.pop()
print(doubleStack.items)

var stringStack: Stack<String> = Stack<String>()

stringStack.push("1")
print(stringStack.items)
stringStack.push("2")
print(stringStack.items)
stringStack.pop()
print(stringStack.items)

var anyStack: Stack<Any> = Stack<Any>()

anyStack.push(1.0)
print(anyStack.items)
anyStack.push("2")
print(anyStack.items)
anyStack.push(3)
print(anyStack.items)
anyStack.pop()
print(anyStack.items)

// 익스텐션을 통한 제네릭 타입의 기능 추가
extension Stack{
    var topElement: Element?{
        return self.items.last
    }
}

print(doubleStack.topElement)
print(stringStack.topElement)
print(anyStack.topElement)

// 타입 제약
func substractTwoValue<T: BinaryInteger>(_ a: T, _ b: T) -> T{
    return a - b
}

// 프로토콜의 연관 타입
protocol Container{
    associatedtype ItemType
    var count: Int{get}
    mutating func append(_ item: ItemType)
    subscript(i: Int) -> ItemType{get}
}

class MyContainer: Container{
    var items: Array<Int> = Array<Int>()
    
    var count: Int{
        return items.count
    }
    
    func append(_ item: Int) {
        items.append(item)
    }
    subscript(i: Int) -> Int{
        return items[i]
    }
}

struct IntStack: Container{
    typealias ItemType = Int
    var items = [ItemType]()
    
    mutating func push(_ item: ItemType){
        items.append(item)
    }
    mutating func pop() -> ItemType{
        return items.removeLast()
    }
    
    mutating func append(_ item: ItemType){
        self.push(item)
    }
    var count: ItemType{
        return items.count
    }
    subscript(i: ItemType) -> ItemType {
        return items[i]
    }
}

// Stack 구조체의 제네릭 서브스크립트 구현과 사용
extension Stack{
    subscript<Indices: Sequence>(indices: Indices) -> [Element]
        where Indices.Iterator.Element == Int{
        var result = [ItemType]()
        for index in indices{
            result.append(self[index])
        }
        return result
    }
}

var integerStack: Stack<Int> = Stack<Int>()
integerStack.append(1)
integerStack.append(2)
integerStack.append(3)
integerStack.append(4)
integerStack.append(5)

print(integerStack[0...2])
