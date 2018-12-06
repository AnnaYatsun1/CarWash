////
////  main.swift
////  CarWash
////
////  Created by Student on 19.10.2018.
////  Copyright © 2018 Student. All rights reserved.
////
//
import Foundation
//
let washer1 =  Washer(name: "Lika", queue: .background)
let washer2 =  Washer(name: "Tanay", queue: .background)
let washer3 =  Washer( name: "Lika", queue: .background)

let director = Director(name: "Nila")
let accountant =  Accountant(name: "Fima")
let interval = 4.0
let washers = [washer1, washer2]

let carWash = CarWash(washers: washers, accountant: accountant, director: director)
let factory = Factory(carWash: carWash, interval: interval)
factory.startMakeCars()
//sleep(11)
//factory.stop()
RunLoop.current.run()






























//factory.stop()

// Task

//func task(fuu: @escaping (_ a: Int) -> Int, fuu2: @escaping (Int) ->() ) {
//    var a = 0
//
//    DispatchQueue.background.asyncAfter(deadline: .after(interval: 5.0)) {
//        10.times  {
//            a += 1
//        }
//        fuu2(fuu(a))
//    }
//
//}
////
//task(
//    fuu: { return $0 * 2 },
//    fuu2: { print($0/2) }
//)
//let arra = ["J", "Q", "K", "A"]
//let splitDeck = arra.split()
//print(splitDeck)
//func mass( f1: (), f2: ())  {
//    let k: Int = 0
//
//    var arra: [Int] = []
//    arra.insert(0, at: 1)
//    arra.insert(0, at: 2)
//    print(arra)
//    print(arra.count)

    //    arra.append(1)
//    10.times {
//         arra.append(k+1)
//        print(arra)
//    }
//    let splitDeck = arra.split()
//    print(splitDeck)
//    f1: do {
//        let kkk = splitDeck.last
//        print(kkk as Any)
//    }
   
//}





RunLoop.current.run()
//
//
//let queue: Queue<Int> = Queue()
////
////let acc = Accountant
////acc.washer.dequeue().do(doWork)
//
//queue.enqueue(5)
//queue.enqueue(10)
//
//let a = queue.peek()
//let b = queue.next()
//
//print(a)
//print(b)

//sleep(1000)


//
////func A(a: Int, b: Int, _: (_ a: Int, _ b: Int) -> Int, _: ( ) -> Void ) -> Int{
////
////}
////func A (a: Int, b: Int) -> Int{
////    var result: Int
////    result = a + b
////
////
////    return result
////
////}
////func B (result: Int){
////    print(result)
////}
////
////func C (a: Int, b: Int) {
////    var a = 10
////    var   b = 16
////}
//
////func D(a: Int, b: Int, result: (Int, Int) -> Int, result2: (Int) -> ()) {
////    let a = 3
////    let b = 5
////    let res =  result(a, b)
////    result2(res)
//// result(a, b ) -> Int {
//////        var results = a + b
//////        return results
//////    }
//////
////}//let res = D(a: 10, b: 5, result: { $0 * $1 }, result2: { print($0) } )
////
//////
////func D4<T, U>(a: T, b: T, result: (T, T) -> U, result2: (U) -> ()) -> U {
////    let res2 = result(a, b)
////    result2(res2)
////    return res2
////}
////
////let res2 = D4(a: 9, b: 8, result: { $0 / $1 } , result2: { print($0) } )
//////
//////func D<T, U>(a: T, b: T, result: (K2: (T, T) -> U,  result2: (U) -> ())) {
//////        let a = 3
//////        let b = 5
//////    let resu = K2
//////    let result2 = (res2)
//////    let results = result(resu, result2 )
//////
//////
//////}
////
////func D(a: Int, b: Int, result: ((Int, Int) -> Int,  result2: (Int) -> ())) {
////    let a = 3
////    let b = 5
//////    var resu = lokkl(a, b)
////    let result2 = (res2)
////    let results = result(lokkk(a, b), result2(.lokkk))
////
////
////}
//
