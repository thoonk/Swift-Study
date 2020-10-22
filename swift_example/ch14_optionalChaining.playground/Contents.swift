class Room{
    var number: Int
    
    init(number: Int){
        self.number = number
    }
}
class Building{
    var name: String
    var room: Room?
    
    init(name: String){
        self.name = name
    }
}

struct Address{
    var province: String
    var city: String
    var street: String
    var building: Building?
    var detailAddress: String?
    
    init(province: String, city: String, street: String){
        self.province = province
        self.city = city
        self.street = street
    }
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building{
            restAddress = buildingInfo.name
        }else if let detail = self.detailAddress{
            restAddress = detail
        }
        if let rest: String = restAddress{
            var fullAddress: String = self.province
            
            fullAddress += " " + self.city
            fullAddress += " " + self.street
            fullAddress += " " + rest
            
            return fullAddress
        } else{
            return nil
        }
    }
    func printAddress(){
        if let address: String = self.fullAddress(){
            print(address)
        }
    }
}

class Person{
    var name: String
    var address: Address?
    
    init(name: String){
        self.name = name
    }
}
// 옵셔널 체이닝 문법
let yagom: Person = Person(name: "yagom")
let yagomRommViaOptionalChaining: Int? = yagom.address?.building?.room?.number
//let yagomRoomViaOptionalUnwrapping: Int = yagom.address!.building!.room!.number
print(yagomRommViaOptionalChaining)

// 옵셔널 바인딩의 사용
var roomNumber: Int? = nil

if let yagomAddress: Address = yagom.address{
    if let yagomBuilding: Building = yagomAddress.building{
        if let yagomRoom: Room = yagomBuilding.room{
            roomNumber = yagomRoom.number
        }
    }
}

if let number: Int = roomNumber{
    print(number)
}else{
    print("Can not find room number")
}

// 옵셔널 체이닝의 사용
if let roomNumber: Int = yagom.address?.building?.room?.number {
    print(roomNumber)
}else{
    print("Can not find room number")
}

// 옵셔널 체이닝을 통한 값 할당 시도
yagom.address?.building?.room?.number = 505
print(yagom.address?.building?.room?.number)

// 옵셔널 체이닝을 통한 값 할당
yagom.address = Address(province: "경기도", city: "부천시", street: "상동로")
yagom.address?.building = Building(name: "빌딩")
yagom.address?.building?.room = Room(number: 0)
yagom.address?.building?.room?.number = 505

print(yagom.address?.building?.room?.number)

// 옵셔널 체이닝을 통한 매서드 호출

print(yagom.address?.fullAddress()?.isEmpty)
yagom.address?.printAddress()

let optionalArray: [Int]? = [1, 2, 3]
print(optionalArray?[1])

var optionalDictionary: [String: [Int]]? = [String: [Int]]()
optionalDictionary?["numberArray"] = optionalArray
print(optionalDictionary?["numberArray"]?[2])

// 빠른 종료 (guard)
for i in 0...3{
    guard i == 2 else{
        continue
    }
    print(i)
}

// guard 구문의 옵셔널 바인딩 활용
func greet(_ person: [String: String]){
    guard let name: String = person["name"] else{
        return
    }
    print("Hello \(name)")
    
    guard let location: String = person["location"] else{
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}
var personInfo: [String: String] = [String: String]()
personInfo["name"] = "Jenny"
greet(personInfo)

personInfo["location"] = "Korea"
greet(personInfo)

// guard구문에 구체적인 조건을 추가
func enterClub(name: String?, age: Int?){
    guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else{
        print("You are too young to enter the club")
        return
    }
    print("Welcome \(name)")
}

var club: Void = enterClub(name: "hi", age: 13)

// guard 구문이 사용될 수 없는 경우
let first: Int = 3
let second: Int = 5

//guard first > second else{
//    return
//}
