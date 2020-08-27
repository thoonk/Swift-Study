// School 클래스 서브스크립트 구현

struct Student{
    var name: String
    var number: Int
}

class School{
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String){
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...){
        for name in names{
            self.addStudent(name: name)
        }
    }
    
//    subscript(index: Int) -> Student?{
//        if index < self.number{
//            return self.students[index]
//        }
//        return nil
//    }
    
    subscript(index: Int) ->Student?{
        get{
            if index < self.number{
                return self.students[index]
            }
            return nil
        }
        set{
            guard var newStudent: Student = newValue else{
                return
            }
            var number: Int = index
            
            if index > self.number{
                number = self.number
                self.number += 1
            }
        }
    }
    
    subscript(name: String) -> Int? {
        get{
            return self.students.filter{$0.name == name}.first?.number
        }
        set{
            guard var number: Int = newValue else{
                return
            }
            if number > self.number{
                number = self.number
                self.number += 1
            }
            let newStudent: Student = Student(name: name, number: number)
            self.students[number] = newStudent
        }
    }
    subscript(name: String, number: Int) -> Student?{
        return self.students.filter{$0.name == name && $0.number == number}.first
    }
}

let highSchool: School = School()
highSchool.addStudents(names: "MiJeong", "JuHyun", "JiYoung", "SeongUk", "MoonDuk")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)")

// 복수의 서브스크립트 구현
print(highSchool["MiJeong"])
print(highSchool["DongJin"])

highSchool[0] = Student(name: "HongEui", number: 0)
highSchool["MangGu"] = 1

print(highSchool[0])
print(highSchool["JuHyun"])
print(highSchool["MangGu"])
print(highSchool["SeongUk", 3])
print(highSchool["HeeJin", 3])

// 타입 서브스크립트 구현
enum Academy: Int{
    case elementary = 1, middle, high, university
    
    static subscript(level: Int) -> Academy?{
        return Self(rawValue: level)
    }
}

let academy: Academy? = Academy[2]
print(academy)
