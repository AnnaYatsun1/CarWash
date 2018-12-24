//
//  Int+Extensions.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension Strideable where Stride : SignedInteger, Self: ExpressibleByIntegerLiteral {
    
    func times(_ transform: () -> ()) {
        (0..<self).forEach {_ in
            transform()
        }
    }
}

