//
//  Factory.swift
//  CarWashUK
//
//  Created by Student on 08/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Factory: Synchronizable {

    public var token: DispatchQueue.Token? {
        willSet { self.token?.stop() }
    }
    
    private let queue = DispatchQueue.background
    private let carWash: CarWash
    private let interval: TimeInterval
    
    deinit {
        self.stop()
    }
    
    init(carWash: CarWash, interval: TimeInterval) {
        self.carWash = carWash
        self.interval = interval
    }
    
    func startMakeCars() {
        self.token = self.queue.asyncAfterRepeating(interval: interval) { [weak self] in
            10.times {
                self?.queue.async {
                    let someCar = Car(money: 10, model: "BMW", owner: "Вася")
                    self?.carWash.process(car: someCar)
                }
            }
        }
    }

    func stop() {
        self.token = nil
    }
}


