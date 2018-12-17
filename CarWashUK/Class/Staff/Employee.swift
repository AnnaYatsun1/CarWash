//
//  Employ.swift
//  CarWashUK
//
//  Created by Student on 11/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Employee: ObservableObject<Employee.State>, MoneyGiver, MoneyReceiver, Stateble {

    enum State {
        case busy
        case available
        case waitProcessing
    }
    
    public var state: State {
        get { return atomicState.value }
        set {
            self.atomicState.modify {
                let oldValue = $0
                if oldValue != newValue {
                    $0 = newValue
                    self.notify(state: newValue)
                }
            }
        }
    }
    
    public let name: String
    public let money = Atomic(0)
    public let atomicState = Atomic(State.available)
    
    public init(name: String) {
        self.name = name
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
}

