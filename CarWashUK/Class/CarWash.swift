//
//  CarWash.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class CarWash: Synchronizable {
    
    public var id: String
    public let accountant: Accountant
    public let director: Director
    
    private let carsQueue = Queue<Car>()
    private var washersQueue = Queue<Washer>()
    private let washers: [Washer]
    private let observers = Atomic([Employee.Observer]())
    
    deinit {
        self.observers.value.forEach {
            $0.cancel()
        }
    }
    
    init(
        washers: [Washer],
        accountant: Accountant,
        director: Director
    ) {
        self.washers = washers
        self.accountant = accountant
        self.director = director
        self.washersQueue = Queue(elements: washers)
        self.id = UUID().uuidString
        self.setup()
    }
    
    func process(car: Car) {
        if let washer = self.washersQueue.dequeue() {
            washer.doStaffWork(object: car)
        } else {
            self.carsQueue.enqueue(car)
        }
    }
    
    func setup() {
        weak var weakSelf = self
        
        self.washers.forEach { washer in 
            weak var weakWasher = washer
            
            let washerObserver = washer.observer { state in
                switch state {
                case .available:
                    weakSelf?.carsQueue.dequeue().apply(weakWasher?.doStaffWork)
                case .waitProcessing:
                    weakWasher.apply(weakSelf?.accountant.doStaffWork) 
                case .busy: return
                }
            }
            
            self.observers.value.append(washerObserver)
        }
        
        let accountantObserver = self.accountant.observer {
            switch $0 {
            case .available: return
            case .waitProcessing:
                (weakSelf?.accountant).apply(weakSelf?.director.doStaffWork)
            case .busy: return
            }
        }
        
         self.observers.value += [accountantObserver]
    }
}




