class Person{
    enum Job{
        case jobless, programmer, student
    }
    var job: Job = .jobless
}

class Student: Person{
    enum School{
        case elementary, middle, high
    }
    
    var school: School
    
    init(school: School){
        self.school = school
        super.init()
        self.job = .student
    }
}

let personJob: Person.Job = .jobless
let studentJob: Student.Job = .student

let student: Student = Student(school: .middle)
print(student.job)
print(student.school)

struct Sports{
    enum GameType{
        case football, basketball
    }
    
    var gameType: GameType
    
    struct GameInfo{
        var time: Int
        var player: Int
    }
    
    var gameInfo: GameInfo{
        switch self.gameType{
        case .basketball:
            return GameInfo(time: 40, player: 5)
        case .football:
            return GameInfo(time: 90, player: 11)
        }
    }
}

struct Esports{
    enum GameType{
        case online, offline
    }
    
    var gameType: GameType
    
    struct GameInfo{
        var location: String
        var pakage: String
    }
    
    var gameInfo: GameInfo{
        switch self.gameType{
        case.online:
            return GameInfo(location: "www.liveonline.co.kr", pakage: "LOL")
        case .offline:
            return GameInfo(location: "제주", pakage: "SA")
        }
    }
}

var basketball: Sports = Sports(gameType: .basketball)
print(basketball.gameInfo)

var sudden: Esports = Esports(gameType: .offline)
print(sudden.gameInfo)

let someGameType: Sports.GameType = .football
let anotherGameType: Esports.GameType = .online
// let errorIfYouWantIt: Sports.GameType = .online // 오류

