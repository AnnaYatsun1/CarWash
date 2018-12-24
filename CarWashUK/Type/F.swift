
//
//  T.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

enum F {
    
    typealias VoidCompletion = () -> ()
    typealias VoidExecute = () -> ()
    typealias Completion<Value> = (Value) -> ()
    typealias Event = (oldValue: Employee.State, newValue: Employee.State)
}
