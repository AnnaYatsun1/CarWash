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
//    let washersQueue: Queue<Washer>


    
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
//        self.washersQueue = washersQueue
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
    
    @discardableResult
    func doStaffWork(object: Processing, completion: F.Completion? = nil) -> Processing? {
        var result: Processing?

        self.synchronize {
            if self.state == .available {
                self.state = .busy
                self.queue.asyncAfter(deadline: .randomDuration()) {
                    self.state = .waitProcessing
                    self.doStaffWork(object: object)
                    self.takeMoney(from: object)
                    self.performProcessing(object: object)
                    self.finishProcessing(object: object)
                    completion?()
                }
            } else {
                result = object
            }
        }
        
        return result
    }
    
  
    func forWashers() {

    }
    
    open func performProcessing(object: Processing) {
        
    }
    
    open func finishProcessing(object: Processing) {
        
    }
}
