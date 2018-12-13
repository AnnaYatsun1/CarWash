//
//  Atomic.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Atomic<Value> {
    
    public var value: Value {
        get { return self.transform { $0 } }
        set { self.modify { $0 = newValue } }
    }
    
    private var mutableValue: Value
    private let lock: NSRecursiveLock
    
    init(
        _ value: Value,
        lock: NSRecursiveLock = NSRecursiveLock()
    ) {
        self.mutableValue = value
        self.lock = lock
    }
  
    func transform<Result>(_ action: (Value) -> Result) -> Result {
        return self.lock.do {
            return action(self.mutableValue)
        }
    }
    
    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        return self.lock.do {
            
            return action(&self.mutableValue)
        }
    }
}



