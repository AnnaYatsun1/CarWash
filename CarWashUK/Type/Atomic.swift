//
//  Atomic.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Atomic<Value> {
    
    typealias PropertyObserver = ((old: Value, new: Value)) -> ()
    
    public var value: Value {
        get { return self.transform { $0 } }
        set { self.modify { $0 = newValue } }
    }
    
    private var mutableValue: Value
    private let lock: NSRecursiveLock
    private let willSet: PropertyObserver?
    private let didSet: PropertyObserver?
    
    init(
        _ value: Value,
        lock: NSRecursiveLock = NSRecursiveLock(),
        willSet: PropertyObserver? = nil,
        didSet: PropertyObserver? = nil
        ) {
        self.mutableValue = value
        self.lock = lock
        self.willSet = willSet
        self.didSet = didSet
    }
    
    func transform<Result>(_ action: (Value) -> Result) -> Result {
        return self.lock.do {
            action(self.mutableValue)
        }
    }
    
    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        return self.lock.do {
            var oldValue = self.mutableValue  
            var newValue = oldValue           
            let result = action(&newValue)
            
            self.willSet?((oldValue, newValue))
            self.mutableValue = newValue
            
            defer {
                self.didSet?((oldValue, self.mutableValue))
            }
            
            return result
        }
    }
}
