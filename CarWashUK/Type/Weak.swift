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
}
