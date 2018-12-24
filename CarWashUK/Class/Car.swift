//
//  Car.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Car: MoneyGiver {
    
    enum State: String {
        case clean
        case dirty
        
        var isDirty: Bool {
            return self == .dirty
        }
        
        var isClean: Bool {
            return self == .clean
        }
    }
    
    public let model: String
    public let owner: String
    
    public var state: State {
        get {
            return self.atomicState.value
        }
        set {
            self.atomicState.modify { $0 = newValue }
        }
    }
    
    private let atomicMoney: Atomic<Int>
    private let atomicState = Atomic(State.dirty)

    init(
        money: Int,
        model: String,
        owner: String
    ) {
        self.atomicMoney = Atomic(money)
        self.model = model
        self.owner = owner
    }
    
    func giveMoney() -> Int {
        return self.atomicMoney.modify { money in
            defer { money = 0 }
            
            return money
        }
    }
}
