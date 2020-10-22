// 오류의 종류 표현
enum VendingMachineError: Error{
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// 자판기 동작 도중 발생한 오류 던지기
struct Item{
    var price: Int
    var count: Int
}

class VendingMachine{
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Biscuit": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String){
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws{
        guard let item = self.inventory[name] else{
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else{
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= self.coinsDeposited else{
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - self.coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventory[name] = newItem
        
        self.dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom" : "Chips",
    "jinsung" : "Biscuit",
    "heejin" : "Chocolate"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws{
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    //try vendingMachine.vend(itemNamed: snackName)
    tryingVend(itemNamed: snackName, vendingMachine: vendingMachine)
}

struct PurchasedSnack{
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws{
        //try vendingMachine.vend(itemNamed: name)
        tryingVend(itemNamed: name, vendingMachine: vendingMachine)
        self.name = name
    }
}

let machine: VendingMachine = VendingMachine()
//machine.coinsDeposited = 30

var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)

//print(purchase.name)

//for (person, favoriteSnack) in favoriteSnacks{
//    print(person, favoriteSnack)
//    try buyFavoriteSnack(person: person, vendingMachine: machine)
//}

// do-catch 구문 오류 처리
func tryingVend(itemNamed: String, vendingMachine: VendingMachine){
    do{
        try vendingMachine.vend(itemNamed: itemNamed)
    }catch VendingMachineError.invalidSelection{
        print("유효하지 않은 선택")
    }catch VendingMachineError.outOfStock{
        print("품절")
    }catch VendingMachineError.insufficientFunds(let coinsNeeded){
        print("자금부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
    }catch {
        print("그 외 오류 발생: ", error)
    }
}

machine.coinsDeposited = 20
//var purchase: PurchasedSnack = PurchasedSnack(name: "Biscuit", vendingMachine: machine)

//print(purchase.name)

purchase = try PurchasedSnack(name: "Ice Cream", vendingMachine: machine)

for (person, favoriteSnack) in favoriteSnacks{
    print(person, favoriteSnack)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}

// 옵셔널 값으로 오류 처리
func someThrowingFunction(shouldThrowError: Bool) throws -> Int{
    if shouldThrowError{
        enum SomeError: Error{
            case justSomeError
        }
        throw SomeError.justSomeError
    }
    return 100
}

let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x)

let y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y)

// 옵셔널 오류 처리 + 기존 옵셔널 반환 타입
typealias Data = Int

func fetchDataFromDisk() throws -> Data{
    return Data()
}

func fetchDataFromServer() throws -> Data{
    return Data()
}

func fetchData() -> Data?{
    if let data = try? fetchDataFromDisk(){
        return data
    }
    if let data = try? fetchDataFromServer(){
        return data
    }
    return nil
}

// 오류가 발생하지 않음을 확신하여 오류 처리
func someThrowingFunc(shouldThrowError: Bool) throws -> Int{
    if shouldThrowError{
        enum SomeError: Error{
            case justSomeError
        }
        throw SomeError.justSomeError
    }
    return 100
}

let b: Int = try! someThrowingFunc(shouldThrowError: false)
print(b)
//let a: Int = try! someThrowingFunc(shouldThrowError: true)

// 오류의 다시 던지기
func reThrowingFunction() throws{
    enum SomeError: Error{
        case justSomeError
    }
    throw SomeError.justSomeError
}

func someFunction(callback: () throws -> Void) rethrows{
    try callback()
}

do{
    try someFunction(callback: reThrowingFunction)
}catch{
    print(error)
}

// 다시 던지기 함수의 오류 던지기
func reThrowingFunc() throws{
    enum SomeError: Error{
        case justSomeError
    }
    throw SomeError.justSomeError
}
func someFunc(callback: () throws -> Void) rethrows{
    enum AnotherError: Error{
        case justAnotherError
    }
    
    do{
        try callback()
    }catch{
        throw AnotherError.justAnotherError
    }
    
    do{
        try reThrowingFunc()
    }catch{
        //throw AnotherError.justAnotherError // 매개변수로 전달한 오류 던지기 X
    }
    
    //throw AnotherError.justAnotherError // catch절 외부에서 단독으로 오류 던지기 X
}

// 프로토콜과 상속에서 던지기 함수와 다시 던지기 함수
protocol SomeProtocol{
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws
    func someReThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows
}

class SomeClass: SomeProtocol{
    func someThrowingFunction(callback: () throws -> Void) throws { }
    func someFunction(callback: () throws -> Void) rethrows { }
    
    func someReThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows {    }
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws {    }
}

class SomeChildClass: SomeClass{
    override func someThrowingFunction(callback: () throws -> Void) throws {    }
    // override func someFunction(callback: () throws -> Void) throws {    }
}

// defer 구문의 실행 순서
func throwingFunction(shouldThrowError: Bool) throws -> Int{
    defer{
        print("First")
    }
    
    if shouldThrowError{
        enum SomeError: Error{
            case justSomeError
        }
        throw SomeError.justSomeError
    }
    
    defer{
        print("Second")
    }
    defer{
        print("Third")
    }
    return 100
}

try? throwingFunction(shouldThrowError: true)
try? throwingFunction(shouldThrowError: false)

// 복합적인 defer 구문의 실행 순서
func function(){
    print("1")
    
    defer{
        print("2")
    }
    
    do{
        defer{
            print("3")
        }
        print("4")
    }
    
    defer {
        print("5")
    }
    
    print("6")
}

function()
