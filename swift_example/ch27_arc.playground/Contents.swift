// 강한참조의 참조 횟수 확인
class Person{
    let name: String
    
    var card: CreditCard?
    
    init(name: String){
        self.name  = name
        print("\(name) is being initalized")
    }
    
    var room: Room?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "yagom") // 1
reference2 = reference1 // 2
reference3 = reference1 // 3

reference3 = nil // 2
reference2 = nil // 1
reference1 = nil // 0

// 강한참조 지역변수(상수)의 참조 횟수
func foo(){
    let yagom: Person = Person(name: "yagom") // 1
    // 함수 종료 시점 0
}
foo()

// 강한참조 지역변수(상수)의 참조 횟수과 전역변수
var  globalReference: Person?

func foo2(){
    let yagom: Person = Person(name: "yagom") // 1
    
    globalReference = yagom // 2
    
    // 함수 종료 시점 0
}
foo2()

// 강한참조 순환 문제
class Room{
    let number: String
    
    init(number: String){
        self.number = number
    }
    
    weak var host: Person?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var yagom: Person? = Person(name: "yagom") // Person 1
var room: Room? = Room(number: "505") // Room 1

//room?.host = yagom // Person 2
//yagom?.room = room // Room 2
//
//// 강한참조 순환 문제를 수동으로 해결
//room?.host = nil // Room 1
//yagom?.room = nil // Person 1
//
//yagom = nil // Person 0
//room = nil // Room 0

// 강한참조 순환 문제를 약한참조로 해결
room?.host = yagom // Person 1
yagom?.room = room // Room 2

yagom = nil // Person 0 Room 1
print(room?.host)
room = nil // Room 0

// 미소유참조
class CreditCard{
    let number: UInt
    
    unowned let owner: Person
    
    init(number: UInt, owner: Person){
        self.number = number
        self.owner = owner
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var jisoo: Person? = Person(name: "jisoo") // Person 1

if let person: Person = jisoo {
    // CreditCard 1
    person.card = CreditCard(number: 1004, owner: person)
    // Person 1
}
jisoo = nil // Person 0
// Credit 0

// 미소유참조의 암시적 추출 옵셔널 프로퍼티
class Company{
    let name: String
    
    var ceo : CEO!
    
    init(name: String, ceoName: String){
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    
    func introduce(){
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}

class CEO {
    let name: String
    
    unowned let company: Company
    
    init(name: String, company: Company){
        self.name = name
        self.company = company
    }
    func introduce(){
        print("\(name)는 \(company.name)의 CEO입니다.")
    }
}

let company: Company = Company(name: "무한상사", ceoName: "김태호")
company.introduce()
company.ceo.introduce()

// 클로저의 강한참조 순환 문제
class Person2{
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else{
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)."
        
        return introduction
    }
    init(name: String, hobby: String? = nil){
        self.name = name
        self.hobby = hobby
    }
    deinit {
        print("\(name) is being deinitializered")
    }
}

var yg: Person2? = Person2(name: "yg", hobby: "eating")
print(yg?.introduce())
yg=nil // deinit 호출되지 않음

// 획득목록을 통한 값 획득
var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
    b = 20
}

a = 10
b = 10
closure()
print(b)

// 참조 타입의 획득목록 동작
class SimpleClass{
    var value: Int = 0
}

var x = SimpleClass()
var y = SimpleClass()

let closure2 = { [x] in
    print(x.value, y.value)
}
x.value = 10
y.value = 10

closure2()

var c: SimpleClass? = SimpleClass()
var d = SimpleClass()

let closure3 = { [weak c, unowned d] in
    print(c?.value, d.value)
}

c = nil
d.value = 10

closure3()

// 획득목록을 통한 클로저의 강한참조 순환 문제 해결
class Person3{
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = { [unowned self] in
           
           var introduction: String = "My name is \(self.name)."
           
           guard let hobby = self.hobby else {
               return introduction
           }
           
           introduction += " "
           
           introduction += "My hobby is \(hobby)."
           
           return introduction
       }
       
    init(name: String, hobby: String? = nil) {
           self.name = name
           self.hobby = hobby
       }
       
    deinit {
        print("\(name) is being deinitialized")
    }
}

var th: Person3? = Person3(name: "th", hobby: "reading")
print(th?.introduce())
th = nil

// 획득목록의 미소유참조로 인한 차후 접근 문제 발생
var ya: Person3? = Person3(name: "ya", hobby: "sleeping")
var gom: Person3? = Person3(name: "gom", hobby: "baking")

gom?.introduce = ya?.introduce ?? {" "}
print(ya?.introduce())

ya = nil
// print(gom?.introduce()) // 오류
