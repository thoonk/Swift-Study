// Base Class Person
class Person{
    var name: String = ""
    var age: Int = 0 {
        didSet{
            print("Person age : \(self.age)")
        }
    }
    var koreanAge: Int{
        return self.age + 1
    }
    
    var fullName: String {
        get{
            return self.name
        }
        set{
            self.name = newValue
        }
    }
    
    var introduction: String{
        return "이름: \(name). 나이: \(age)"
    }
    
    func speak(){
        print("가나다라마바사")
    }
    class func introduceClass()-> String{
        return "인류의 소원은 평화입니다."
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction)
yagom.speak()

// Person 클래스를 상속받은 Student 클래스
class Student: Person{
    var grade: String = "F"
    
    override var age: Int{
        didSet{
            print("Student age: \(self.age)")
        }
    }
    func study(){
        print("Study hard...")
    }
    
    override func speak(){
        print("저는 학생입니다.")
    }
    
    override var introduction: String{
        return super.introduction + " " + "학점 : \(self.grade)"
    }
    
    override var koreanAge: Int{
        get{
            return super.koreanAge
        }
        set{
            self.age = newValue - 1
        }
    }
    override var fullName: String{
        didSet{
            print("Full Name : \(self.fullName)")
        }
    }
}

let jay: Student = Student()
jay.name = "jay"
jay.age = 18
jay.grade = "A"
print(jay.introduction)
jay.speak()
jay.study()

// 메서드 재정의
class UniversityStudent: Student{
    var major: String = ""
    
    class func introduceClass(){
        print(super.introduceClass())
    }
    
    override class func introduceClass() -> String {
        return "대학생의 소원은 A+입니다."
    }
    
    override func speak() {
        super.speak()
        print("대학생이죠.")
    }
}

let jenny: UniversityStudent = UniversityStudent()
jenny.speak()

print(Person.introduceClass())
print(Student.introduceClass())
print(UniversityStudent.introduceClass() as String)
UniversityStudent.introduceClass() as Void

// 프로퍼티 재정의
print(yagom.introduction)
print(yagom.koreanAge)

jay.age = 14
jay.koreanAge = 15
print(jay.introduction)
print(jay.koreanAge)

// 프로퍼티 감시자 재정의
yagom.fullName = "Jo yagom"
jay.fullName = "Kim jay"

// 서브스크립트 재정의
class School{
    var students: [Student] = [Student]()
    
    subscript(number: Int) -> Student{
        print("School subscript")
        return students[number]
    }
}

class MiddleSchool: School{
    var middleStudents: [Student] = [Student]()
    
    override subscript(index: Int) -> Student{
        print("Middle subscript")
        return middleStudents[index]
    }
}

let university: School = School()
university.students.append(Student())
university[0]

let middle: MiddleSchool = MiddleSchool()
middle.middleStudents.append(Student())
middle[0]


// 2단계 초기화
class Person2{
    var name: String
    var age: Int
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    convenience init(name: String){
        self.init(name: name, age: 0)
    }
}

class Student2 : Person2{
    var major: String
    
    init(name: String, age: Int, major: String){
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String){
        self.init(name: name, age: 7, major: "")
    }
}

