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
    private var observers = [Emploee.Observer]()
    
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
        self.washers.forEach { washer in
            weak var weakWasher = washer
            let washerObserver = washer.observer { [weak self] state in
                switch state {
                    case .available:
                    self?.carsQueue.dequeue().apply(weakWasher?.doStaffWork)
                    case .waitProcessing:
                    weakWasher.do { self?.accountant.doStaffWork(object: $0) }
                    case .busy: return
                    }
            }
            
            self.observers.append(washerObserver)
        }
        
        let accountantObserver = self.accountant.observer { [weak self] in
            switch $0 {
                case .available: return
                case .waitProcessing:
                (self?.accountant).apply(self?.director.doStaffWork)
                case .busy: return
            }
        }
        
        self.observers.append(accountantObserver)
    }
}



