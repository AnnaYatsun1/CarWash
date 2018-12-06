//
//  CarWash.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class CarWash: Synchronizable, Observer {
    
    public var id: String
    public let accountant: Accountant
    public let director: Director
    
    private let carsQueue = Queue<Car>()
    private var washersQueue = Queue<Washer>()
    private let washers: [Washer]
    
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
        self.accountant.addObserver(observer: self)
        washers.forEach {
            $0.addObserver(observer: self)
        }
    }
    
    func wash(car: Car) {
        self.process(car: car)
    }
    
    func process(car: Car) {
        if let washer = self.washersQueue.dequeue(){
            washer.doStaffWork(object: car)
        } else {
            self.carsQueue.enqueue(car)
        }
    }
    
    func countMoney(washer: Washer) {
        self.accountant.doStaffWork(object: washer)
    }
    
    func listen<T>(sender: Staff<T>, info: F.Event) where T : MoneGiver {
        self.synchronize {
            if info.newValue == .available {
                if !sender.chekingForEmpty {
                    sender.processingQueue()
                } else {
                    let washer = sender as? Washer
                    if let washer = washer {
                        self.washersQueue.enqueue(washer)
                        self.carsQueue.dequeue().do { car in
                            self.process(car: car)
                        }
                    }
                }
            }
            
            if info.newValue == .waitProcessing {
                switch sender {
                case is Washer:
                    let washer = sender as? Washer
                    if let washer = washer {
                        print("  washer case \(info.oldValue) -> \(info.newValue)")
                        self.accountant.doStaffWork(object: washer)
                    }
                case is Accountant:
                    let accountant = sender as? Accountant
                    if let accountant = accountant {
                        print(" accountant  case \(info.oldValue) -> \(info.newValue)")
                        self.director.doStaffWork(object: accountant)
                    }
                case is Director:
                    print("  director  case \(info.oldValue) -> \(info.newValue)")
                    break
                default:
                    break
                }
            }
        }
    }
}

