//
//  Weak.swift
//  CarWashUK
//
//  Created by Student on 17/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

public struct Weak<Wrapped: AnyObject> {
    
    private(set) weak var value: Wrapped?
    
    public init(_ value: Wrapped) {
        self.value = value
    }
    
    @discardableResult
    public func strongify<Result>(transform: (Wrapped) -> Result?) -> Result? {
        return self.value.flatMap(transform)
    }
}

extension Weak {
    
    public func weakify<Wrapped: AnyObject>(_ value: Wrapped) -> Weak<Wrapped> {
        return weakify(value) { _ in }
    }	
    
    @discardableResult
    public func weakify<Wrapped: AnyObject>(_ value: Wrapped, execute: (Weak<Wrapped>) -> ()) -> Weak<Wrapped> {
        let weak = Weak<Wrapped>(value)
        execute(weak)
        
        return weak
    }
    
    //  ?? for two diff types
    @discardableResult
    public func weakify<Wrapped: AnyObject, Result>(
        value1: Wrapped, 
        value2: Wrapped, 
        execute: @escaping(Wrapped, Wrapped, Result) -> ()
    ) 
        -> (Result) -> () 
    {
        let weakValue1 = Weak<Wrapped>(value1)
        let weakValue2 = Weak<Wrapped>(value2)
        
        return { [weak value1, weak value2] object in 
            weakValue1.value.do { value1 in
                weakValue2.value.do { value2 in
                    execute(value1, value2, object)
                }
            }
            
        }
    }
}

//  work
@discardableResult
public func weakify<Wrapped1: AnyObject, Wrapped2: AnyObject, Result>(
    value1: Wrapped1, 
    value2: Wrapped2, 
    execute: @escaping(Wrapped1, Wrapped2, Result) -> ()
    ) 
    -> (Result) -> () 
{
    
    return { [weak value1, weak value2] object in 
        value1.do { value1 in
            value2.do { value2 in
                execute(value1, value2, object)
            }
        }
    }
}
