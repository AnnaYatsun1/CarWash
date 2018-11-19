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
    
    private let queueCars = Queue<Car>()
    private let queueOfWashers = Queue<Washer>()
    
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
        let queueCars = self.queueCars
        
        self.synchronize {
            if queueCars.isEmpty && self.washer.state == .available {
                self.process(car: car)
            } else {
                queueCars.enqueue(car)
            }
        }
    }
    
    func process(car: Car) {
        self.washer.doStaffWork(object: car) {
            self.countMoney(washer: self.washer)
        }
    }
    
    func countMoney(washer: Washer) {
//        let washer = self.washer
        let accountant = self.accountant
        
        accountant.doStaffWork(object: washer) {
            self.queueCars.dequeue().do(self.process)
            self.director.doStaffWork(object: accountant) {
                self.queueOfWashers.dequeue().do(self.countMoney)
//                if washer.state == .waitProcessing {
//                    self.countMoney()
//                }
            }
        } .do(self.queueOfWashers.enqueue)
    }
}
