//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Staff<Processed: MoneGiver >: MoneGiver, MoneyReceiver, Stateble, Synchronizable {
    
    
    
    private let id: UInt
    private let queue: DispatchQueue
    private let privateState = Atomic(State.available)
    
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
    
    open func performProcessing(object: Processed) {
        
    }
    
    open func finishProcessing(object: Processed) {
        
    }
    
    func doStaffWork(object: Processed, completion: F.Completion?) {
        self.synchronize {
            self.state = .busy
            self.queue.asyncAfter(deadline: .randomDuration()) {
                self.takeMoney(from: object)
                self.performProcessing(object: object)
                self.finishProcessing(object: object)
                completion?()
            }
        }
    }
}

extension Staff where Processed: Stateble {
    func anyFunc(_ object: Processed) -> Void {
        object.state = .available
    }
}
