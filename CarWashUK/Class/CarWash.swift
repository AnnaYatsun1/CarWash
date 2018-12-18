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
    private var observers = [ObservableObject<Employee.State>.Observer]()
    
    deinit {
        self.observers.forEach {
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
        
        self.washers.forEach { washer in  //  replacing forEach with map -> "Segmentation fault: 11"
            weak var weakWasher = washer
            
            let washerObserver = washer.observer { state in
                switch state {
                case .available:
                    weakSelf?.carsQueue.dequeue().apply(weakWasher?.doStaffWork)
                case .waitProcessing:
                    weakWasher.do { weakSelf?.accountant.doStaffWork(object: $0) }
                case .busy: return
                }
            }
            
            self.observers.append(washerObserver)
        }
        
        let accountantObserver = self.accountant.observer {
            switch $0 {
            case .available: return
            case .waitProcessing:
                (weakSelf?.accountant).apply(weakSelf?.director.doStaffWork)
            case .busy: return
            }
        }
         self.observers += [accountantObserver]
        
//        let accountantObserver_ = self.accountant.observer(
//            handler: weakify(value1: self.accountant, value2: self.director) { accountant, director, state in
//                switch state {
//                case .available: return
//                case .waitProcessing:
//                    director.doStaffWork(object: accountant)
//                case .busy: return
//                }
//            }
//        )
    }
}




