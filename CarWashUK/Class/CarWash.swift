//
//  CarWash.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class CarWash: Synchronizable {
    
    let accountant: Accountant
    let director: Director
    
    private let queueCars = Queue<Car>()
//    private let queueWashers: Queue<Washer>// free
    private let washers: [Washer]  //  all washers in a car wash
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
//        self.queueWashers = Queue(elements: washers)
        
    }
    
    func wash(car: Car) {
        self.process(car: car)
    }
    
    func process(car: Car) {
        
        self.synchronize {
            let local = washers.filter{ $0.state != .busy }.sorted { $0.objectCount < $1.objectCount  }.first
            if let worker = local {
                print("washer \(worker.name), status \(worker.state)")
                worker.doStaffWork(object: car){
                    let waitingWashers =  self.washers_.value.filter { $0.state == .waitProcessing}
                countMoney(washers: waitingWashers)
                }
                
            } else {
                print("add car to queue")
                self.queueCars.enqueue(car)
            }
        }
        
        func countMoney(washers: [Washer]) {
                washers.forEach { washer in
                    print("washer \(washer.name), status \(washer.state)")
                    self.accountant.doStaffWork(object: washer){
                        print("aqccountent \(self.accountant.name), status \(self.accountant.state)")
                    self.director.doStaffWork(object: self.accountant) {
                        print("Take car from queue")
                        self.queueCars.dequeue().do { car in
                            self.process(car: car)
                            print("car \(car.owner)")
                        }
                    }
                }
            }
        }
    }
}



