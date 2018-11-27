//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Staff<Processing: MoneGiver>: MoneGiver, MoneyReceiver, Stateble, Synchronizable {
    
    private let id: UInt
    private let queue: DispatchQueue
    private let privateState = Atomic(State.available)
    private let dispatchQueue = DispatchQueue.background
    public var objectCount = 0
    var completion: F.Completion?
    private lazy var processedObjects_ = Queue(elements: [(object: Processing?, completion: F.Completion?)]())
    
    let money = Atomic(0)
    let name: String
    
    var state: State {
        get {
            return self.privateState.value
        }
        set {
            self.privateState.modify { $0 = newValue }
        }
    }
    
    init(id: UInt, name: String, queue: DispatchQueue) {
        self.id = id
        self.name = name
        self.queue = queue
    }
    
    func giveMoney() -> Int {
        return self.money.modify { money in
            defer { money = 0 }
            
            return money
        }
    }
    
    func takeMoney(_ money: Int) {
        self.money.modify { $0 += money }
    }
    
    func doStaffWork(object: Processing?, completion: F.Completion? = nil) {
        self.synchronize {
            
            if self.state != .busy  {
                print("in staff busy \(self)")
                self.state = .busy
                self.asyncWork(object: object, completion: completion)
                } else {
                    let objectWithCimpletion = (object: object, completion: completion)
                    self.processedObjects_.enqueue(objectWithCimpletion)
                }
            }
        }
    
    private func asyncWork(object: Processing?, completion: F.Completion? = nil) {
        object.do { objects in
            self.queue.asyncAfter(deadline: .randomDuration()) {
                self.takeMoney(from: objects)
                self.performProcessing(object: objects)
                self.completeProcessing(object: objects)
                self.finishProcessing(object: objects)
                completion?()
            }
        }
    }
    
    open func performProcessing(object: Processing) {
        
    }
    
    open func completeProcessing(object: Processing) {
        
    }
    
    open func finishProcessing(object: Processing) {
        self.synchronize {
            print("finishProcessing \(object)")
            self.doCheking()
        }
    }
    
    func doCheking() {
        if let object = self.processedObjects_.dequeue() {
            self.dispatchQueue.async {
                self.asyncWork(
                    object: object.object,
                    completion: object.completion
                )
            }
        } else {
            self.state = .waitProcessing
        }
    }
}

