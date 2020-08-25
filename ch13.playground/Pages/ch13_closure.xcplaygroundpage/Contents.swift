let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

func backwards(first: String, second: String) -> Bool{
    return first > second
}

let rvs: [String] = names.sorted(by: backwards)
print(rvs)

//기본 클로저
let reversed: [String] = names.sorted (by: { (first: String, second: String) -> Bool in
    return first > second
})

print(reversed)

//후행 클로저
let reversed_after: [String] = names.sorted() {(first: String, second: String) -> Bool in
    return first > second
}
// 소괄호 생략 가능
let reversed_after2: [String] = names.sorted {(first: String, second: String) -> Bool in
    return first > second
}
// 클로저의 타입 유추
let reversed_after3: [String] = names.sorted {(first, second) in
    return first > second
}
//단축 인자 이름을 사용한 표현
let reversed_short: [String] = names.sorted{
    return $0 > $1
}
//암시적 반환 표현
let reversed_implicit: [String] = names.sorted {$0 > $1}

func makeIncrementer(forIncrement amount: Int) -> (()->Int){
    var runningTotal = 0
    func incrementer() -> Int{
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTwo: (()-> Int) = makeIncrementer(forIncrement: 2)

let first: Int = incrementByTwo()
let second: Int = incrementByTwo()
let third: Int =  incrementByTwo()
print(first, second, third)

let incrementByTwo2: (()->Int) = makeIncrementer(forIncrement: 2)

let first2: Int = incrementByTwo2()
let second2: Int = incrementByTwo2()
let third2: Int =  incrementByTwo2()
print(first2, second2, third2)

let incrementByTen : (()->Int) = makeIncrementer(forIncrement: 10)

let ten : Int = incrementByTen()
let twenty: Int = incrementByTen()
let thirty: Int = incrementByTen()
print(ten, twenty, thirty)

//클로저는 참조 타입
let sameWithIncrementByTwo: (()-> Int) = incrementByTwo

let fir: Int = incrementByTwo()
let sec: Int = sameWithIncrementByTwo()
print(fir, sec)

//탈출 클로저 예
typealias VoidVoidClosure = () -> Void

let firstClosure: VoidVoidClosure = {
    print("Closure A")
}
let secondClosure: VoidVoidClosure = {
    print("Closure B")
}

func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure,
                      shouldReturnFirstClosure: Bool) -> VoidVoidClosure{
    return shouldReturnFirstClosure ? first : second
}

let returnClosure: VoidVoidClosure = returnOneClosure(first:
    firstClosure, second: secondClosure, shouldReturnFirstClosure: true)

returnClosure()

var closures: [VoidVoidClosure] = []

func appendClosure(closure: @escaping VoidVoidClosure){
    closures.append(closure)
}

//클래스 인스턴스 매서드에 사용되는 탈출, 비탈출 클로저
func functionWithNoescapeClosure(closure: VoidVoidClosure){
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure{
    return completionHandler
}

class SomeClass{
    var x = 10
    
    func runNoescapeClosure(){
        functionWithNoescapeClosure {
            x = 200
        }
    }
    
    func runEscapingClosure() -> VoidVoidClosure{
        return functionWithEscapingClosure {
            self.x = 100
        }
    }
}

let instance: SomeClass = SomeClass()
instance.runNoescapeClosure()
print(instance.x)

let returnedClosure: VoidVoidClosure = instance.runEscapingClosure()
returnedClosure()
print(instance.x)


let numbers: [Int] = [2, 4, 6, 8]

let evenNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 0
}
let oddNumberPredicate = {(number: Int) -> Bool in
    return number % 2 == 1
}

func hasElements(in array: [Int], match predicate: (Int)->Bool) -> Bool{
    return withoutActuallyEscaping(predicate, do: { escapablePredicate in
        return (array.lazy.filter {escapablePredicate($0)}.isEmpty == false)
    })
}

let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)

print(hasEvenNumber)
print(hasOddNumber)

//클로저를 이용한 연산 지연
var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaWi"]
print(customersInLine)

let customerProvider: () -> String =  {
    return customersInLine.removeFirst()
}
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)

//함수의 전달인자로 전달하는 클로저
func serveCustomer(_ customerProvider: ()->String){
    print("Now serving \(customerProvider())")
}

serveCustomer({customersInLine.removeFirst()})

//자동 클로저의 사용
func serveCustomer(_ customerProvider: @autoclosure () -> String){
    print("Now serving \(customerProvider())")
}
serveCustomer(customersInLine.removeFirst())

//자동 클로저의 탈출
func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (()-> String){
    return customerProvider
}
let customerProvider2: () -> String = returnProvider(customersInLine.removeFirst())
print("\(customerProvider2())")
