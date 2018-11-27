//
//  Car.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class  Car: MoneGiver {
    
    private let privateState = Atomic(Status.dirty)

    var state: Status {
        get {
            return self.privateState.value
        }
        set {
            self.privateState.modify { $0 = newValue }
        }
    }

    enum Status: String {
        case clean
        case dirty
        
        var isDirty: Bool {
            return self == .dirty
        }
        
        var isClean: Bool {
            return self == .clean
        }
    }

    let money: Atomic<Int>
    let model: String
    let owner: String
    
    init(
        money: Int,
        model: String,
        owner: String
    ) {
        self.money = Atomic(money)
        self.model = model
        self.owner = owner
    }
    
    func giveMoney() -> Int {
        return self.money.modify { money in
            defer { money = 0 }
            
            return money
        }
    }
}
