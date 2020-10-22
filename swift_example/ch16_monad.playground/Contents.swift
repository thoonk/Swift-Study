// 옵셔널에 맵 메서드와 클로저의 사용
var value: Int? = 2
print(value.map {$0 + 3})
value = nil
value.map{$0 + 3}

//  플랫맵의 사용
func doubledEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2){
        return num * 2
    }
    return nil
}

print(Optional(3).flatMap(doubledEven))

// 맵과 컴팩트의 차이
let optionals: [Int?] = [1,2,nil,5]

let mapped: [Int?] = optionals.map{$0}
let compactMapped: [Int] = optionals.compactMap{$0}

print(mapped)
print(compactMapped)

// 중첩된 컨테이너에서 맵과 플랫맵(컴팩트맵)의 차이
let multipleContainer = [[1,2,Optional.none], [3, Optional.none], [4,5,Optional.none]]

let mappedMultipleContainer = multipleContainer.map{$0.map{$0}}
let flatmappedMultipleContainer = multipleContainer.flatMap{$0.compactMap{$0}}
print(mappedMultipleContainer)
print(flatmappedMultipleContainer)

// 플랫맵의 활용
func stringToInteger(_ string: String) -> Int?{
    return Int(string)
}

func integerToString(_ integer: Int) -> String? {
    return "\(integer)"
}

var optionalString: String? = "2"

let flattenResult = optionalString.flatMap(stringToInteger).flatMap(integerToString).flatMap(stringToInteger)
print(flattenResult)

let mappedResult = optionalString.map(stringToInteger)
print(mappedResult)

// 옵셔널 바인딩을 통한 연산
var result: Int?
if let string: String = optionalString{
    if let number: Int = stringToInteger(string){
        if let finalString: String = integerToString(number){
            if let finalNumber: Int = stringToInteger(finalString){
                result = Optional(finalNumber)
            }
        }
    }
}
print(result)

if let string:String = optionalString,
    let number: Int = stringToInteger(string),
    let finalString: String = integerToString(number),
    let finalNumber: Int = stringToInteger(finalString){
    result = Optional(finalNumber)
}
print(result)

// 플랫맵 체이닝 중 빈 컨텍스트를 만났을 때의 결과
func intergerToNil(param: Int) -> String?{
    return nil
}

optionalString = "2"
result = optionalString.flatMap(stringToInteger).flatMap(intergerToNil).flatMap(stringToInteger)
print(result)
