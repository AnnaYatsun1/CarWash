//
//  Factory.swift
//  CarWashUK
//
//  Created by Student on 08/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Factory: Synchronizable {
    
    let queue = DispatchQueue.background
    let carWash: CarWash

//    var token = Token()
    
    deinit {
        
    }
    
    init(carWash: CarWash) {
        self.carWash = carWash
    }
    
    func startMakeCars() {

//        self.token = DispatchQueue.background.timer(interval: 5.0) {
        10.times {
            print("make new car")
//            self.queue.somthing {
            self.queue.async {
                let someCar = Car(money: 10, model: "BMW", owner: "Вася")
                self.carWash.wash(car: someCar)
//            }
        }
    }
}
}


