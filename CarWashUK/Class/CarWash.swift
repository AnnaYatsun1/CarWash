//
//  CarWash.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class CarWash: Synchronizable {
    
    public let accountant: Accountant
    public let director: Director
    
    private let carsQueue = Queue<Car>()
    private var washersQueue = Queue<Washer>()
    private let washers: [Washer]  //  all
    private let washers_: Atomic<[Washer]>
    
    init(
        washers: [Washer],
        accountant: Accountant,
        director: Director
    ) {
        self.washers = washers
        self.accountant = accountant
        self.director = director
        self.washers_ = Atomic(washers)
        self.washersQueue = Queue(elements: washers)
    }
    
    func wash(car: Car) {
        self.process(car: car)
    }
    
    func process(car: Car) {
        self.synchronize {
            let firstAvalibleWasher = washers.filter { $0.state == .available }
                .sorted { $0.objectCount < $1.objectCount }
                .first
            if let washer = firstAvalibleWasher {
                washer.doStaffWork(object: car) {
                   // print("washer \(washer.name) do staff work")
                    self.countMoney(washer: washer)
                }
            } else {
              //  print("add car to queue")
                self.carsQueue.enqueue(car)
            }
        }
    }
    
    func countMoney(washer: Washer?) {
        let accountant = self.accountant
        print("accountent status start  \(accountant.state)")
        accountant.doStaffWork(object: washer) {
             print("accountent status in work \(accountant.state)")
          //  print("account completion ")
            self.washersQueue.enqueueForOptional(washer)
          //  print("Take car from queue")
            self.carsQueue.dequeue().do { car in
                self.process(car: car)
              //  print("car \(car.owner)")
            }
            
            self.director.doStaffWork(object: self.accountant) {
             //   print(" its director do work")
            }
        }
    }
}



