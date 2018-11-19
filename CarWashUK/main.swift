//
//  main.swift
//  CarWash
//
//  Created by Student on 19.10.2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

let washer =  Washer(id: 1, name: "Lika", queue: .background)
let director = Director(id: 2, name: "Nila", queue: .background)
let accountant =  Accountant(id: 3, name: "Fima", queue: .background)
let iterval = TimeInterval(4.0)

let carWash = CarWash(washer: washer, accountant: accountant, director: director)
let factory = Factory(carWash: carWash, interval: iterval)
let token = DispatchQueue.background.asyncAfterRepeating(interval: 4.0, execute: factory.startMakeCars)

//sleep(5)
//token.isRunning.value = false

RunLoop.current.run()
















//func A(a: Int, b: Int, _: (_ a: Int, _ b: Int) -> Int, _: ( ) -> Void ) -> Int{
//
//}
//func A (a: Int, b: Int) -> Int{
//    var result: Int
//    result = a + b
//
//
//    return result
//
//}
//func B (result: Int){
//    print(result)
//}
//
//func C (a: Int, b: Int) {
//    var a = 10
//    var   b = 16
//}

//func D(a: Int, b: Int, result: (Int, Int) -> Int, result2: (Int) -> ()) {
//    let a = 3
//    let b = 5
//    let res =  result(a, b)
//    result2(res)
// result(a, b ) -> Int {
////        var results = a + b
////        return results
////    }
////
//}//let res = D(a: 10, b: 5, result: { $0 * $1 }, result2: { print($0) } )
//
////
//func D4<T, U>(a: T, b: T, result: (T, T) -> U, result2: (U) -> ()) -> U {
//    let res2 = result(a, b)
//    result2(res2)
//    return res2
//}
//
//let res2 = D4(a: 9, b: 8, result: { $0 / $1 } , result2: { print($0) } )
////
////func D<T, U>(a: T, b: T, result: (K2: (T, T) -> U,  result2: (U) -> ())) {
////        let a = 3
////        let b = 5
////    let resu = K2
////    let result2 = (res2)
////    let results = result(resu, result2 )
////
////
////}
//
//func D(a: Int, b: Int, result: ((Int, Int) -> Int,  result2: (Int) -> ())) {
//    let a = 3
//    let b = 5
////    var resu = lokkl(a, b)
//    let result2 = (res2)
//    let results = result(lokkk(a, b), result2(.lokkk))
//
//
//}

