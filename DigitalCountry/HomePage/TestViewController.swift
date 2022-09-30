//
//  TestViewController.swift
//  DigitalCountry
//
//  Created by 倪尛 on 2022/9/28.
//

import UIKit

//enum People { case adult, child, senior }
enum People {
    case adult,student,child,senior
}
class TestViewController: BaseVController {

    
    var stringArray = ["james","wade","Bob","lucy"]
    var intArray = [1, 2, 3, 4, 5, 6, 3]
    var doubleArray = [1.0, 2.0, 3.0]
    
    var myUsername: String?
    var myPassword: String?
    var person: People = .adult
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        printStringArray(a: stringArray)
//        print("--------分界线-----------")
//        printintArray(a: intArray)
//        print("--------分界线-----------")
//        printdoubleArray(a: doubleArray)
//        print("--------分界线---------------------------")
//        printElementFromArray(a: stringArray)
//        printElementFromArray(a: intArray)
//        printElementFromArray(a: doubleArray)
//        myUsername = "12132123"
//        myPassword = "23231232"
//        userLoginMethod()
//        person = "Adult"
        
        person = .senior
        
//        enumTypemethod()
//        judgeFilterMethod()
//        ClosureMethod()
        studySwiftString()
    }
    func studySwiftString() {
//       Swift 字符串通过 String 类型来表示，也可以表示为 Character 类型值的集合
//       字符串连接操作只需要简单地通过 + 号将两个字符串相连即可。与 Swift 中其他值一样，能否更改字符串的值，取决于其被定义为常量还是变量。
        
        // 字符串字面量
        let someString = "Some string literal value"
        
        // 初始化空字符串   这两个字符串都为空，并且两者等价
        var emptyString = ""
        var anotherEmptyString = String()
        if emptyString.isEmpty && anotherEmptyString.isEmpty {
            print("字符串为空")
        }
//        Swift 中的字符串可以修改仅通过定义的是变量还是常量来决定
//        字符串可变性
        var variableString = "fire Horse"
        variableString += "and carriage"
//        常量不可以被修改
//        let constantString = "Highlander"
//        constantString += " and another Highlander"
//        Swift 的 String 类型是值类型。如果创建了一个新的字符串值，那么当其进行常量、变量赋值操作或在函数/方法中传递时，会进行值拷贝。在不同情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值。Swift 默认字符串拷贝的方式保证了在函数/方法中传递的是字符串的值，其明确独有该字符串的值，无论它来自哪里。你可以放心传递的字符串本身不会被改，除非是自己更改它。
//        使用字符（Characters）
        for character in "Characters" {
            print(character)
        }
        let character :Character  = "¥"
        var tagCharac :Character  = "$"
        print(character,tagCharac)
        print("String has \(variableString.count) 字符")
        
//        字符串和字符的值可以通过加法运算符 (+) 相加在一起并创建一个新的字符串值
        let string1 = "hello"
        let string2 = " there"
        let character1: Character = "!"
        let character2: Character = "?"
        let stringPlusCharacter = string1 + "\(character1)"
        // 等于 "hello!"
        let stringPlusString = string1 + string2
        // 等于 "hello there"
        let characterPlusString = "\(character1)" + string1
        // 等 于 "!hello"
        let characterPlusCharacter = "\(character1)" + "\(character2)"
        // 等于 "!?"
//        字符串插值是一种全新的构建字符串的方式，可以在其中包含常量、变量、字面量和表达式
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message is "3 times 2.5 is 7.5"
        
//        比较字符串  ==  hasPrefix/hasSuffix（前缀/后缀）
//        大写和小写字符串  uppercaseString 和 lowercaseString
    }
    
    func ClosureMethod(){
        
//        // Closure
//        var sumUsingClosure: (Int, Int) -> (Int) = { $0 + $1 }
//        sumUsingClosure(5, 6) // 11
        var sumClosure: (Int, Int) -> (Int) = {$0 + $1}
        var sum = sumClosure(11,13)
        print("两数和是\(sum)")
    }
    func judgeFilterMethod() {
//        var newEvent = [Int]()
//        for i in 1...10 {
//            if i & 1 == 0 {
//                newEvent.append(i)
//            }
//        }
//        print("偶数是\(newEvent)")
//        var evens = Array(1...10).filter { $0 % 2 == 0 }
        
//       过滤器函数的使用: filter替代上面的For-Loop。这里也推荐大家更多的使用高阶函数。
        
        let resultArray = Array(1...12).filter { (item) -> Bool in
             return item%2 == 0
        }
        let result = Array(1...12).filter { return $0 % 2 == 0 }
        var newevents = Array(1...12).filter { $0 & 1 != 0 }
        print("偶数是\(newevents)")
    }
    func enumTypemethod(){
//        switch person {
//        case "Adult":
//            print("Pay $7")
//        case "Student":
//            print("Pay $5")
//        case "Child":
//            print("Pay $3")
//        case "Senior":
//            print("Pay $1")
//        default:
//            print("You alive, bruh?")
//        }
        switch person {
        case .adult:
            print("Pay $7")
        case .student:
            print("Pay $5")
        case .child:
            print("Pay $3")
        case .senior:
            print("Pay $1")
        default:
            print("You alive, bruh?")
        }
    }
    func userLoginMethod(){
//        1. 普通版本代码结构嵌套冗余，进阶版本更加一目了然。
//        2. 在判断一些前提必要条件的时候，推荐使用guard let。
//        if let username = myUsername,let password = myPassword {
//            print("Welcome, \(username)")
//        }
        //进阶版
        guard let username = myUsername,let password = myPassword else{
            return;
        }
        print("Welcome, \(username)")
    }
    func loopMethod (){
        // 当我们不需要使用循环中的变量时，我们可以使用For Loop和_来代替While Loop
        //第一种
        var i = 0
        while 5 > i {
            print("count\(i)")
            i += 1
        }
        //第二种
        for a in 1...5 {
            print("count\(a)")
        }
    }
    func plus(a: Int, b: Int) -> Int{
        return a + b
    }
    func reduce(a: Int, b: Int, c: Int) -> Int {
        return a + b - c
    }
    func square(x: Int) -> Int {
        return x * x
    }
    func printStringArray(a:[String]){
        for s in a {
            print("stringArray----\(s)")
        }
    }
    func printintArray(a:[Int]){
        for s in a {
            print("printintArray----\(s)")
        }
    }
    func printdoubleArray(a:[Double]){
        for s in a {
            print("printdoubleArray----\(s)")
        }
    }
    func printElementFromArray<T>(a:[T]){
        for element in a {
            print("泛型Generics------\(element)")
        }
    }
}
