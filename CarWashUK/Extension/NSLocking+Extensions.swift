//
//  NSLocking.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension NSLocking {
    
    func `do`<Result>(_ action: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return action()
    }
}
