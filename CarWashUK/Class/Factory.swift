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
    let interval: TimeInterval
    
    var token: Token?
    
    init(carWash: CarWash, interval: TimeInterval) {
        self.carWash = carWash
        self.interval = interval
    }
    
    func startMakeCars() {
	        self.token = self.queue.asyncAfterRepeating(interval: interval) {
            10.times {
                self.queue.async {
                    let someCar = Car(money: 10, model: "BMW", owner: "Вася")
                    self.carWash.wash(car: someCar)
                }
            }
        }
    }
    
    func stop() {
        self.token?.stop()
    }
}


