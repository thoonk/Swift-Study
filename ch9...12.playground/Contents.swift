//구조체
struct BasicInfo{
    var name: String
    var age: Int
}

var yagomInfo: BasicInfo = BasicInfo(name: "yagom", age: 99)
yagomInfo.age = 100
yagomInfo.name = "taehoon"

let thInfo: BasicInfo = BasicInfo(name: "taehoon", age: 99)

//클래스
class Thoon{
    var heigt: Float = 0.0
    var weight: Float = 0.0
    
    deinit {
        print("Thoon class의 인스턴스가 소멸됩니다")
    }
}

var kth: Thoon = Thoon()
kth.heigt = 188.8
kth.weight = 86.0

var kkk: Thoon? = Thoon()
kkk = nil

let ab: Thoon = Thoon()
let ac: Thoon = ab
let bc: Thoon = Thoon()

print(ab === ac)
print(ab === bc)
print(ac !== bc)

//저장 프로퍼티
struct CoordinatePoint{
    var x: Int = 0
    var y: Int = 0
}

let yagomPoint: CoordinatePoint = CoordinatePoint(x: 10, y:5)

class Position{
    var point: CoordinatePoint
    let name: String

    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
        
    }
}

let yagomPosition: Position = Position(name: "yagom", currentPoint: yagomPoint)

// 옵서녈 저장 프로퍼티
struct CoordPoint{
    var x: Int
    var y: Int
}

class Pos{
    var point: CoordPoint?
    let name: String
    
    init(name: String){
        self.name = name
    }
}

let kthPosition: Pos = Pos(name: "kth")
kthPosition.point = CoordPoint(x: 20, y: 10)

struct CoordiPoint{
    var x: Int
    var y: Int
    
    var oppositePoint: CoordiPoint {
        get{
            return CoordiPoint(x: -x, y: -y)
        }
        set(opposite){
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var thPosition: CoordiPoint = CoordiPoint(x: 10, y: 20)
print(thPosition)

print(thPosition.oppositePoint)

thPosition.oppositePoint = CoordiPoint(x: 15, y: 10)
print(thPosition)

//프로퍼티 감시자

class Account{
    var credit: Int = 0 {
        willSet{
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet{
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    var dollarValue: Double{
        get{
            return Double(credit) / 1000
        }
        set{
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

//let myAccount: Account = Account()
//myAccount.credit = 1000

class ForeignAccount: Account{
    override var dollarValue: Double{
        willSet{
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet{
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
        }
    }
}

let dlAccount: ForeignAccount = ForeignAccount()
dlAccount.credit = 1000

dlAccount.dollarValue = 2

var wonInPocket: Int = 2000{
    willSet {
        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 에정입니다.")
    }
    didSet{
        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
    }
}

var dollarInPocket: Double{
    get{
        return Double(wonInPocket) / 1000.0
    }
    set{
        wonInPocket = Int(newValue * 1000.0)
        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
    }
}

dollarInPocket = 3.5


// keyPath 서브스크립트와 키 경로 활용
class Person{
    let name: String
    init(name: String){
        self.name = name
    }
}

struct Stuff{
    var name: String
    var owner: Person
}

let yagom = Person(name: "yagom")
let hana = Person(name: "hana")
let macbook = Stuff(name: "MacBook Pro", owner: yagom)
var iMac = Stuff(name: "iMac", owner: yagom)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerKeyPath = \Stuff.owner

let ownerNameKeyPath = ownerKeyPath.appending(path: \.name)

print(macbook[keyPath: stuffNameKeyPath])
print(iMac[keyPath: stuffNameKeyPath])
print(iPhone[keyPath: stuffNameKeyPath])

print(macbook[keyPath: ownerNameKeyPath])
print(iMac[keyPath: ownerNameKeyPath])
print(iPhone[keyPath: ownerNameKeyPath])

iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerKeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath])
print(iMac[keyPath: ownerNameKeyPath])


//인스턴스 메서드
class LevelClass{
    var level: Int = 0 {
        didSet{
            print("Level \(level)")
        }
    }
    
    func levelUp(){
        print("Level Up")
        level += 1
    }
    
    func levelDown(){
        print("Level Down")
        level -= 1
        if level < 0{
            reset()
        }
    }
    
    func jumpLevel(to: Int){
        print("Jump to \(to)")
        level = to
    }
    
    func reset(){
        print("Reset")
        level = 0
    }
}

var levelClassInstance: LevelClass = LevelClass()

levelClassInstance.levelUp()
levelClassInstance.levelDown()
levelClassInstance.levelDown()
levelClassInstance.jumpLevel(to: 3)

struct LevelStruct{
    var level: Int = 0{
        didSet{
            print("Level \(level)")
        }
    }
    
    mutating func levelUp(){
        print("Level Up")
        level += 1
    }
    
    mutating func levelDown(){
        print("Level Down")
        level -= 1
        if level < 0{
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int){
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset(){
        print("Reset")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()
levelStructInstance.levelDown()
levelStructInstance.levelDown()
levelStructInstance.jumpLevel(to: 3)

enum OnOffSwitch{
    case on, off
    mutating func nextState() {
        self = self == .on ? .off : .on
    }
}

var toggle: OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle)



struct Area {
    var squareMeter: Double
    
    init (fromPy py: Double){
        squareMeter = py * 3.3058
    }
    
    init(fromSquareMeter squareMeter: Double){
        self.squareMeter = squareMeter
    }
    
    init(value: Double){
        squareMeter = value
    }
    
    init(_ value: Double){
        squareMeter = value
    }
}

let roomOne: Area = Area(fromPy: 15.0)
print(roomOne.squareMeter)

let roomTwo: Area = Area(fromSquareMeter: 33.06)
print(roomTwo.squareMeter)

let roomThree: Area = Area(value: 30.0)
let roomFour: Area = Area(55.0)

class Person2{
    let name: String
    var age: Int?
    
    init(name: String){
        self.name = name
    }
}

let yagom2: Person2 = Person2(name: "yagom")
print(yagom2.name)

print(yagom2.age)

yagom2.age = 98
print(yagom2.age)

//yagom2.name = "Eric"
//print(yagom2.name)

struct Point{
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size{
    var width: Double = 0.0
    var height: Double = 0.0
}

let point: Point = Point(x: 0, y: 0)
let size: Size = Size(width: 50.0, height: 50.0)

let somePoint: Point = Point()
let someSize: Size = Size(width: 50)
let anotherPoint: Point = Point(y: 100)
print(someSize)


enum Student{
    case elementary, middle, high
    case none
    
    init(){
        self = .none
    }
    init (koreanAge: Int){
        switch koreanAge{
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            self = .none
        }
    }
    init (bornAt: Int, currentYear: Int){
        self.init(koreanAge: currentYear - bornAt + 1)
    }
}

var younger: Student = Student(koreanAge: 16)
print(younger)

younger = Student(bornAt: 1998, currentYear: 2016)
print(younger)



struct Student1{
    var name: String?
    var number: Int?
}

class SchoolClass{
    var students: [Student1] = {
        var arr: [Student1] = [Student1]()
        
        for num in 1...15{
            var student: Student1 = Student1(name: nil, number: num)
            arr.append(student)
        }
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count)

class SomeClass{
    deinit {
        print("Instance will be deallocated immediately")
    }
}

var instance: SomeClass? = SomeClass()
instance = nil


class FileManager{
    var fileName: String
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    func openFile(){
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile(){
        print("Modify File: \(self.fileName)")
    }
    
    func writeFIle(){
        print("Write File: \(self.fileName)")
    }
    
    func closeFile(){
        print("Close Files: \(self.fileName)")
    }
    
    deinit{
        print("Deinit instance")
        self.writeFIle()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager {
    manager.openFile()
    manager.modifyFile()
}

fileManager = nil


public struct SomeType{
    private var privateVar = 0
    fileprivate var fileprivateVar = 0
}

extension SomeType{
    public func publicMethod(){
        print("\(self.privateVar), \(self.fileprivateVar)")
    }
    
    private func privateMethod(){
        print("\(self.privateVar), \(self.fileprivateVar)")
    }
    
    fileprivate func fileprivateMethod(){
        print("\(self.privateVar), \(self.fileprivateVar)")

    }
}

struct AnotherType{
    var someInstance: SomeType = SomeType()
    
    mutating func someMethod(){
        self.someInstance.publicMethod()
        
        self.someInstance.fileprivateVar = 100
        self.someInstance.fileprivateMethod()
        
    }
}

var anotherInstance = AnotherType()
anotherInstance.someMethod()


public struct SomeTypes{
    private var count: Int = 0
    
    public var publicStoredPorperty: Int = 0
    
    public private(set) var publicGetOnlyStoredProperty: Int = 0
    
    internal var internalComputedProperty: Int{
        get{
            return count
        }
        set{
            count += 1
        }
    }
    
    internal private(set) var internalGetOnlyComputedProperty: Int{
        get{
            return count
        }
        set{
            count += 1
        }
    }
    
    public subscript()->Int{
        get{
            return count
        }
        set {
            count += 1
        }
    }
    public internal(set) subscript(some: Int)->Int{
        get{
            return count
        }
        set{
            count += 1
        }
    }
}

var someInstance: SomeTypes = SomeTypes()

print(someInstance.publicStoredPorperty)
someInstance.publicStoredPorperty = 100

print(someInstance.publicGetOnlyStoredProperty)
//someInstance.publicGetOnlyStoredProperty = 100

print(someInstance.internalComputedProperty)
someInstance.internalComputedProperty = 100

print(someInstance.internalGetOnlyComputedProperty)
//someInstance.internalGetOnlyComputedProperty = 100

print(someInstance[])
someInstance[] = 100

print(someInstance[0])
someInstance[0] = 100

