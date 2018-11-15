//
//  Atomic.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

//
//  Atomic.swift
//  Atomic
//
//  Created by Yevhen Triukhan on 10/31/18.
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
    
    //  MARK: - Initialization
    init(
        _ value: Value,
        lock: NSRecursiveLock = NSRecursiveLock()
        ) {
        self.mutableValue = value
        self.lock = lock
    }
    
    //  MARK: - Public
    func transform<Result>(_ action: (Value) -> Result) -> Result {
        return self.lock.do {
            action(self.mutableValue)
        }
    }
    
    func modify<Result>(_ action: (inout Value) -> Result) -> Result {
        return self.lock.do {
            return action(&self.mutableValue)
        }
    }
}



class Atomic_<Value> {
    
    private let lock: NSLocking
    public typealias ValueType = Value
    private var mutableValue: Value
    public typealias PropertyObserver = ((old: Value, new: Value)) -> ()
    private let didSet: PropertyObserver?
    
    public var value: Value {
        get { return self.transform { $0 } }
        set { self.modify { $0 = newValue } }
    }
    
    init(
        _ value: ValueType,
        lock: NSRecursiveLock = NSRecursiveLock(),
        didSet: PropertyObserver? = nil
    ) {
        self.mutableValue = value
        self.lock = lock
        self.didSet = didSet
    }
    
    @discardableResult
    public func modify<Result>(_ action: (inout ValueType) -> Result) -> Result {
        return self.lock.do {
            let oldValue = self.mutableValue
            
            defer {
                self.didSet?((oldValue, self.mutableValue))
            }
            
            return action(&self.mutableValue)
        }
    }
    
    public func transform<Result>(_ action: (ValueType) -> Result) -> Result {
        return self.lock.do {
            let value = self.mutableValue
            return action(value)
        }
    }
    
    /*
     //  MARK: - Public
     func transform<Result>(_ action: (Value) -> Result) -> Result {
     return self.lock.do {
     action(self.mutableValue)
     }
     }
     
     func modify<Result>(_ action: (inout Value) -> Result) -> Result {
     return self.lock.do {
     return action(&self.mutableValue)
     }
     }
 */
}
