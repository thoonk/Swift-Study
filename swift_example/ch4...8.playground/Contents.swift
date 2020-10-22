var str = "Hello, playground"

print(str)

var j: Int = 0

for i in 0...3{
    j+=i
}

struct BasicInformation{
    let name: String
    var age: Int
}

var yagomInformation: BasicInformation = BasicInformation(name: "Taehoon", age: 19)

class Person{
    var height: Float = 0.0
    var weight: Float = 0.0
    
}

let yagom: Person = Person()
yagom.height = 188.5
yagom.weight = 86.0


print(yagomInformation)
dump(yagomInformation)

let name: String = "taehoon"
print("My name is \(name)")


var integer: Int = -100
let unsignedInteger: UInt = 50

print("integer 값: \(integer), unsignedInteger 값: \(unsignedInteger)")
print("Int 최댓값: \(Int.max), Int 최솟값: \(Int.min)")
print("UInt 최댓값: \(UInt.max), UInt 최솟값: \(UInt.min)")

let largeInteger: Int64 = Int64.max
let smallUnsignedInteger: UInt8 = UInt8.max
print("Int64 최댓값: \(largeInteger), UInt8 최댓값: \(smallUnsignedInteger)")

//let tooLarge: Int = Int.max + 1
//let cannotBeNegative: UInt = -5

//integer = unsignedInteger
//integer = Int(unsignedInteger)



var intro: String = String()
intro.append("제 이름은")
intro = intro + " " + name + "입니다."

print(intro)
print("name의 글자 수: \(name.count)")
print("intro가 비어있습니까?: \(intro.isEmpty)")


var person: (name: String, age: Int, height: Double) = ("taehoon", 26, 188.5)
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

person.1 = 12
person.2 = 190.0
print("이름: \(person.name), 나이: \(person.1), 신장: \(person.2)")


var array: [Int] = [0,1,2,3,4]
var set: Set<Int> = [0,1,2,3,4]
var dict: [String: Int] = ["a":1, "b":2, "c":3]
var string: String = "string"

print(set.shuffled())
print(dict.shuffled())

//사용자 정의 함수 중위 연산자 구현
class Car{
    var modelYear: Int?
    var modelName: String?
}

struct SmartPhone{
    var company: String?
    var model: String?
}

func == (lhs: Car, rhs: Car) -> Bool{
    return lhs.modelName == rhs.modelName
}

func == (lhs: SmartPhone, rhs: SmartPhone) -> Bool {
    return lhs.model == rhs.model
}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model  = "6"

print(myCar == yourCar)
print(myPhone == yourPhone)

//switch case
let integerValue: Int = 5

switch integerValue{
case 0:
    print("Value == Zero")
case 1...10:
    print("value == 1~10")
    fallthrough
case Int.min..<0, 101..<Int.max:
    print("Value < 0 or Value > 100")
    break
default:
    print("10 < Value <= 100")
}


//where 사용하여 switch case 확장
let 직급: String = "사원"
let 연차: Int = 1
let 인턴인가: Bool = false

switch 직급 {
case "사원" where 인턴인가 == true:
    print("인턴입니다.")
case "사원" where 연차 < 2 && 인턴인가 == false:
    print("신입사원입니다.")
case "사원" where 연차 > 5:
    print("연식 좀 된 사원입니다.")
case "사원":
    print("사원입니다.")
case "대리":
    print("대리입니다.")
default:
    print("사장입니까?")
}

enum Menu{
    case chicken
    case pizza
    case hamburger
}

let lunchMenu: Menu = .chicken

switch lunchMenu {
case .chicken:
    print("반반 무 많이")
case .pizza:
    print("핫 소스 많이 주세여")
@unknown case _:
    print("오늘 메뉴가 뭐죠 ?")
}

let helloSwift: String = "Hello Swift!"

for char in helloSwift {
    print(char)
}


var result: Int = 1

for _ in 1...3 {
    result *= 10
    print(result)
}

let friends: [String: Int] = ["Jay" : 35, "Joe":29, "Jenny":31]

for tuple in friends {
    print(tuple)
}

var names: [String] = ["Joker", "Jenny", "Nova", "yagom"]

while names.isEmpty == false{
    print("Good bye \(names.removeFirst())")
}

var namess: [String] = ["John", "Jenny", "Joe", "yagom"]

repeat{
    print("Good bye \(namess.removeFirst())")
}while namess.isEmpty == false

var numbers: [Int] = [3, 2342, 6, 3252]

numbersLoop: for num in numbers {
    if num > 5 || num < 1 {
        continue numbersLoop
    }
    
    var count: Int = 0
    
    printLoop: while true{
        print(num)
        count += 1
        
        if count == num{
            break printLoop
        }
    }
    
    removeLoop: while true{
        if numbers.first != num{
            break numbersLoop
        }
        numbers.removeFirst()
    }
}

//ch7
func hello(name: String) -> String {
    return "Hello \(name)"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny)


func sayHello(from myName: String, to name: String) -> String{
    return "Hello \(name)! I'm \(myName)"
}

print(sayHello(from: "yagom", to: "Jenny"))

func sayHello(_ name: String, times: Int = 3) -> String{
    var result: String = ""
    
    for _ in 0..<times{
        result += "Hello \(name)" + ". "
    }
    return result
}

print(sayHello("Hana"))
print(sayHello("Joe", times: 2))

func sayHelloToFirends(me: String, friends names: String...) -> String{
    var result: String = ""
    
    for friend in names{
        result += "Hello \(friend)" + " "
    }
    
    result += "I'm " + me + "!"
    return result
}

print(sayHelloToFirends(me: "taehoon", friends: "Johansson", "Jay", "Wizplan"))
print(sayHelloToFirends(me: "yagom"))


typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int , _ b: Int) -> Int{
    return a+b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int{
    return a*b
}

var mathFunction: CalculateTwoInts = addTwoInts

print(mathFunction(2,5))

mathFunction = multiplyTwoInts
print(mathFunction(2,5))

func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int){
    print("Result: \(mathFunction(a,b))")
}
printMathResult(addTwoInts, 3, 5)

func chooseMathFunction(_ toAdd: Bool) -> CalculateTwoInts{
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5)

//원점으로 이동하기 위한 함수

typealias MoveFunc = (Int) -> Int


func functionForMove(_ shoudGoLeft: Bool) -> MoveFunc{
    
    func goRight(_ currentPosition: Int) -> Int{
        return currentPosition + 1
    }
    func goLeft(_ currentPosition: Int) -> Int{
        return currentPosition - 1
    }
    
    return shoudGoLeft ? goLeft : goRight
}
var position: Int = 3

let moveToZero: MoveFunc = functionForMove(position > 0)
print("원점 Go")

while position != 0{
    print("\(position)")
    position = moveToZero(position)
}
 
print("원점 도착")

//종료되지 않는 함수
func crashAndBurn() -> Never{
    fatalError("Somethig very, very bad happend")
}

//crashAndBurn()

func someFunction(isAllIsWell: Bool){
    guard isAllIsWell else{
        print("마을에 도둑이 들었습니다.")
        crashAndBurn()
    }
    print("All is well")
}

//someFunction(isAllIsWell: true)
//someFunction(isAllIsWell: false)


//반환 값을 무시할 수 있는 함수
func say(_ something: String) -> String{
    print(something)
    return something
}

@discardableResult func discadableResultSay(_ something: String) -> String{
    print(something)
    return something
}

say("hello")

discadableResultSay("hello")
    

//switch를 통한 옵셔널 값의 확인
let numberss: [Int?] = [2, nil, -4, nil, 100]

for number in numberss{
    switch number {
    case .some(let value) where value < 0:
        print("Negative value \(value)")
    case .some(let value) where value > 10:
        print("Large value \(value)")
    case .some(let value):
        print("Value \(value)")
    case .none:
        print("nil")
    }
}
// 옵셔널 값 강제 추출

var myName: String? = "yagom"
var yagoms: String = myName!

//myName = nil
//yagoms = myName!

//옵셔널 바인딩을 사용한 옵셔널 값의 추출
if let name = myName{ // name 임시 상수 할당
    print("My name is \(name)")
}else {
    print("myName == nil")
}

if var name = myName{
    name = "wizplan"
    print("My name is \(name)")
}else{
    print("myName == nil")
}

// 옵셔널 바인딩을 사용한 여러 개의 옵셔널 값 추출
var yourName: String? = nil

if let name = myName, let friend = yourName{
    print("We are friend \(name) & \(friend)")
}

yourName = "eric"

if let name = myName, let friend = yourName{
    print("WE are friend! \(name) & \(friend)")
}

var myNames: String! = "taehoon"
//print(myNames)
myNames = nil

if let name = myNames{
    print("My name is \(name)")
} else {
    print("myName == nil")
}

//myNames.isEmpty

