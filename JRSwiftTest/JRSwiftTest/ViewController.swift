//
//  ViewController.swift
//  JRSwiftTest
//
//  Created by hqtech on 2018/1/14.
//  Copyright © 2018年 tulip. All rights reserved.
//

import UIKit

// MARK: 结构体
struct StudentMarks {
    var Mark1 = 100
    var Mark2 = 90
    var Mark3 = 80
    
    init() {
        
    }
    
    init(mark1: Int?) {
        if mark1 != nil {
            self.Mark1 = mark1!
        }
    }
    
    // 结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中被修改
    // 如果要修改，必须在实例方法前加mutating
    mutating func modify(mark2: Int) {
        self.Mark2 = mark2
    }
}

// MARK: 类
class sample {
    // 延迟存储属性(当第一次被调用的时候才会计算其初始值)
    lazy var no = number()
    
    // 属性观察器
    var counter: Int = 0{
        willSet(newValue) {
            print("counter新值：\(newValue)")
        }
        didSet {
            print("counter旧值：\(oldValue)")
        }
    }
    
}

class number {
    var name = "hongqitech"
    init() {
        print(self.name)
    }
    
    // 析构
    deinit {
        
    }
}

// 测试ARC
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) 被析构") }
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person?
    deinit { print("Apartment #\(number) 被析构") }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 不使用第三个变量，交换两个变量的值
        self.changeTwoVarValueNoOtherVar()
        
        // 可选类型测试
        self.optionTest()
        
        // 运算符测试
        self.operatorTest()
        
        // 数组
        self.arrTest()
        
        // 字典
        self.dicTest()
        
        // 函数
        self.functionTest()
        
        // 结构体
        self.structTest()
        
        // 属性
        self.propertyTest()
        
        // ARC自动引用计数
        self.arcTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toFirstVC(_ sender: Any) {
        let firstVC:JRFirstViewController = JRFirstViewController.init(nibName: "JRFirstViewController", bundle: nil);
        self .present(firstVC, animated: true, completion: nil);
    }
    
    // MARK: 不使用第三个变量，交换两个变量的值
    func changeTwoVarValueNoOtherVar() {
        
        var a = 1
        var b = 2
        print("交换前")
        print("a = \(a)")
        print("b = \(b)")
        //交换
        
        // 不使用第三个变量，交换两个变量的值
        a = a + b // a = 1 + 2 = 3
        b = a - b // b = 3 - 2 = 1 = a
        a = a - b // a = 3 - 1 = 2
        
        print("交换后")
        print("a = \(a)")
        print("b = \(b)")
        
    }
    
    // MARK: 可选类型测试
    func optionTest() {
        // 可选类型测试
        var optionVar : Int?
        optionVar = 10
        if optionVar != nil {
            //optionVar! 为强制解析
            print(optionVar!)
        }else {
            print("optionVar = nil")
        }
        
        // 自动解析
        var myString : String!
        myString = "hello world!"
        print(myString)
    }
    
    // MARK: 运算符测试
    func operatorTest() {
        // 位运算符
        var a = 16
        print("a = \(a)")
        a = a << 1
        print("a按位左移1位后")
        print("a = \(a)")
        
        // 区间运算符
        for i in 1 ... 5 {
            print(i)
        }
    }
    
    // MARK: 数组操作测试
    func arrTest() {
        print("===========数组测试===========")
        var arr = [Int](repeating: 0, count: 3)
        var arr2 : [Int] = [10, 20, 30]
        var arr3 = [Int]()
        if arr3.isEmpty {
            print("arr3是空的")
        }
        arr3 = arr + arr2
        for value in arr3 {
            print(value)
        }
    }
    
    // MARK: 字典操作测试
    func dicTest() {
        print("===========字典测试===========")
        var someDic = [String : String]()
        someDic = ["name" : "jinrui", "age" : "18"]
        print(someDic)
        
        // 修改值
        someDic.updateValue("tulip", forKey: "name")
        print(someDic)
        
        // 删除值
        someDic.removeValue(forKey: "age")
        print(someDic)
        
    }
    
    // 函数测试
    func functionTest() {
        print("===========函数测试===========")
        self.vari(members: 1, 2)
        self.vari(members: "one", "two", "three")
        
        var x = 10
        var y = 20
        print("交换前：x = \(x), y = \(y)")
        self.swapTwoInts(a: &x, b: &y)
        print("交换后：x = \(x), y = \(y)")
        
        // 使用函数类型：类型为函数
        let changeTwoVar: (inout Int, inout Int) -> Void = swapTwoInts
        changeTwoVar(&x, &y)
        print("再次交换后：x = \(x), y = \(y)")
        
        // 使用函数类型：函数作为参数
        self.changeFunc(change: changeTwoVar, a: &x, b: &y)
        print("又一次交换后：x = \(x), y = \(y)")
        
        // 函数嵌套
        // 返回值为函数
        let oppsiteValue = self.getOppositeValue(originalValue: -50)
        // 调用函数，返回最终结果
        var newValue = oppsiteValue()
        print("最终结果：\(newValue)")
        // 再次调用（嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量, 实际上捕获并存储了变量的一个副本，而该副本随着内嵌函数一同被存储）
        newValue = oppsiteValue()
        print("最终结果：\(newValue)")
        //又一次调用
        let oppsiteValue2 = oppsiteValue
        newValue = oppsiteValue2()
        print("最终结果：\(newValue)")
    }
    
    // 函数：可变参数
    // <N>表示泛型
    func vari<N>(members: N...) {
        for i in members {
            print(i)
        }
    }
    
    // 函数：交换两个变量的值
    func swapTwoInts(a: inout Int, b: inout Int) {
        let temp = a
        a = b
        b = temp
    }
    
    // 函数：函数作为参数
    func changeFunc(change: (inout Int, inout Int) -> Void, a: inout Int, b: inout Int) {
        change(&a, &b)
    }
    
    // 函数：函数嵌套
    func getOppositeValue(originalValue value: Int) -> () -> Int {
        var oppositeValue = 0;
        // 嵌套函数，也是特殊的闭包
        func oppValue() -> Int {
            oppositeValue -= value
            return oppositeValue
        }
        // 返回值类型为函数
        return oppValue
    }
    
    // 结构体
    func structTest() {
        print("===========结构体测试===========")
        var student = StudentMarks()
        print("Mark1 = \(student.Mark1), Mark2 = \(student.Mark2), Mark3 = \(student.Mark3)")
        student.Mark1 = 99
        print("Mark1 = \(student.Mark1), Mark2 = \(student.Mark2), Mark3 = \(student.Mark3)")
        
        var people = StudentMarks(mark1: 10)
        print("Mark1 = \(people.Mark1), Mark2 = \(people.Mark2), Mark3 = \(people.Mark3)")
        people.Mark1 = 100
        print("Mark1 = \(people.Mark1), Mark2 = \(people.Mark2), Mark3 = \(people.Mark3)")
    }
    
    //  MARK: 属性
    func propertyTest() {
        print("===========属性测试===========")
        
        let firstSample = sample()
        
        print("调用")
        
        print(firstSample.no)
        
        firstSample.counter = 100
        firstSample.counter = 50
    }
    
    // MARK: ARC测试
    func arcTest() {
        print("===========ARC自动引用计数测试===========")
        // 两个变量都被初始化为nil
        var runoob: Person?
        var number73: Apartment?
        
        // 赋值
        runoob = Person(name: "Runoob")
        number73 = Apartment(number: 73)
        
        // 意感叹号是用来展开和访问可选变量 runoob 和 number73 中的实例
        // 循环强引用被创建
        runoob!.apartment = number73
        number73!.tenant = runoob
        
        // 断开 runoob 和 number73 变量所持有的强引用时，引用计数并不会降为 0，实例也不会被 ARC 销毁
        // 注意，当你把这两个变量设为nil时，没有任何一个析构函数被调用。
        // 强引用循环阻止了Person和Apartment类实例的销毁，并在你的应用程序中造成了内存泄漏
//        runoob!.apartment = nil
//        number73!.tenant = nil
        runoob = nil
        number73 = nil
    }
    
}

