// 순차적, 순간적 메모리 접근
func oneMore(than number: Int) -> Int{
    return number + 1
}

// 입출력 매개변수에서의 메모리 접근 충돌 해결
var myNumber: Int = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

var step: Int = 1
var copyOfStep: Int = step

func increment(_ number: inout Int){
    number += copyOfStep
}
increment(&step)

// 복수의 입출력 매개변수로 하나의 변수를 전달하여 메모리 접근 충돌
func balance(_ x: inout Int, _ y: inout Int){
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var playerOneScore: Int = 42
var playerTwoScore: Int = 30
balance(&playerOneScore, &playerTwoScore)
//balance(&playerOneScore, &playerOneScore)

struct GamePlayer{
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth(){
        self.health = GamePlayer.maxHealth
    }
    mutating func shareHealth(with teammate: inout GamePlayer){
        balance(&teammate.health, &health)
    }
}

var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
var maria: GamePlayer = GamePlayer(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)

// oscar.shareHealth(with: &oscar)

// balance(&oscar.health, &oscar.energy)

// 지역변수로의 메모리 접근
func someFunction(){
    var oscar = GamePlayer(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)
}


