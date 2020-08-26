let numbers: [Int] = [0, 1, 2, 3, 4, 5]

var doubledNumbers: [Int] = [Int]()
var strings: [String] = [String]()

for number in numbers{
    doubledNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubledNumbers)
print(strings)

// map 메서드 사용
doubledNumbers = numbers.map({(number: Int) -> Int in
    return number * 2
})
strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubledNumbers)
print(strings)

// 클로저 표현의 간략화
// 매개변수 및 반환 타입 생략
doubledNumbers = numbers.map({return $0 * 2})
print(doubledNumbers)

// 반환 키워드 생략
doubledNumbers = numbers.map({ $0 * 2})
print(doubledNumbers)

// 후행 클로저 사용
doubledNumbers = numbers.map {$0 * 2}
print(doubledNumbers)

// 클로저의 반복 사용
let evenNumbers: [Int] = [0, 2, 4, 6, 8]
let oddNumbers: [Int] = [0, 1, 3, 5, 7]
let multiplyTwo: (Int) -> Int = {$0 * 2}

let doubledEvenNumbers = evenNumbers.map(multiplyTwo)
print(doubledEvenNumbers)
let doubledOddNumbers = oddNumbers.map(multiplyTwo)
print(doubledOddNumbers)

// 다양한 컨테이너 타입에서의 맵의 활용
let alphabetDictionary: [String: String] = ["a":"A", "b":"B"]

var keys: [String] = alphabetDictionary.map {(tuple: (String, String))->String in
    return tuple.0
}

keys = alphabetDictionary.map{$0.0}

let values: [String] = alphabetDictionary.map{$0.1}
print(keys)
print(values)

var numberSet: Set<Int> = [1,2,3,4,5]
let resultSet = numberSet.map{$0 * 2}
print(resultSet)

let optionalInt: Int? = 3
let resultInt: Int? = optionalInt.map{$0 * 2}
print(resultInt)

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map {$0 * 2}
print(resultRange)

// 필터 메서드의 사용
let evenNum: [Int] = numbers.filter{(number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNum)

let oddNum: [Int] = numbers.filter {$0 % 2 == 1}
print(oddNum)

// 맵과 필터 메서드의 연계 사용
let mappedNumbers: [Int] = numbers.map{$0 + 3}

let evenNumber: [Int] = mappedNumbers.filter{ (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumber)

let oddNumber: [Int] = numbers.map{$0 + 3}.filter{$0 % 2 == 1}
print(oddNumber)

//리듀스 메서드의 사용
let nums: [Int] = [1, 2, 3]

var sum: Int = nums.reduce(0, { (result: Int, next: Int)-> Int in
    print("\(result) + \(next)")
    return result + next
})
print(sum)

let subtract: Int = nums.reduce(0, {(result: Int, next: Int) -> Int in
    print("\(result) - \(next)")
    return result - next
})

print(subtract)

let sumFromThree: Int = nums.reduce(3){
    print("\($0) + \($1)")
    return $0 + $1
}

print(sumFromThree)

var subtractFromThree: Int = nums.reduce(3){
    print("\($0) - \($1)")
    return $0 - $1
}

print(subtractFromThree)

let names: [String] = ["Chope", "Jay", "Joker", "Nova"]

let reducedNames: String = names.reduce("yagom's friend : "){
    return $0 + ", " + $1
}
print(reducedNames)

sum = nums.reduce(into: 0, {(result: inout Int, next: Int) in
    print("\(result) + \(next)")
    result += next
})

print(sum)

subtractFromThree = nums.reduce(into: 3,{
    print("\($0) - \($1)")
    $0 -= $1
})
print(subtractFromThree)

var doubledNums: [Int] = nums.reduce(into: [1,2]){(result: inout [Int], next: Int) in
    print("result: \(result) next: \(next)")
    
    guard next.isMultiple(of: 2) else{
        return
    }
    
    print("\(result) append \(next)")
    result.append(next * 2)
}
print(doubledNums)

doubledNums = [1,2] + nums.filter{$0.isMultiple(of: 2)}.map{$0 * 2}
print(doubledNums)

var upperCasedNames: [String] = names.reduce(into: [], {
    $0.append($1.uppercased())
})
print(upperCasedNames)

upperCasedNames = names.map{$0.uppercased()}
print(upperCasedNames)

// 맵, 필터 리듀스 메서드의 연계 사용
let num: [Int] = [1,2,3,4,5,6,7]

var result: Int = num.filter{$0.isMultiple(of:2)}.map{$0*3}.reduce(0){
    $0+$1
}
print(result)

result = 0
for number in num{
    guard number.isMultiple(of: 2) else{
        continue
    }
    result += number * 3
}

print(result)


// 조건에 맞는 친구 결과 출력
enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: [Friend] = [Friend]()

friends.append(Friend(name: "Yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "JiSoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender: .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender: .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))

var results: [Friend] = friends.map{Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1)}

results = results.filter{$0.location != "서울" && $0.age >= 25}

let string: String = results.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") {
    $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"
}
print(string)
