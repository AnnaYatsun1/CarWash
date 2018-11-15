//
//  CarWash.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class CarWash: Synchronizable {
    
    let washer: Washer
    let accountant: Accountant
    let director: Director
    
    var isWashing = false
    private let queueCars = Queue<Car>()
    
    init(
        washer: Washer,
        accountant: Accountant,
        director: Director
    ) {
        self.washer = washer
        self.accountant = accountant
        self.director = director
    }
    
    func wash(car: Car) {
        self.synchronize {
            if !self.isWashing {
                self.isWashing = true
                self.process(car: car)
            } else {
                self.queueCars.enqueue(car)
            }
        }
    }
    //  нужно проверять очередь машин, что бы выйти из рекурсии
    //  давай это уже завтра, тут недолго
    
    func process(car: Car) {
        self.washer.doStaffWork(object: car) {
          if self.accountant.state == .available {
                self.countMoney()
            }
        }
    }
    
    func countMoney() {
        let washer = self.washer
        let accountant = self.accountant
        
        if accountant.state == .available {
            accountant.doStaffWork(object: washer) {
                self.queueCars.dequeue().do(self.process)
                self.director.doStaffWork(object: accountant) {
                    if washer.state == .waitProcessing {
                        self.countMoney()
                    }
                }
            }
        }
    }
}
