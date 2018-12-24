//
//  Optional.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

extension Optional {

    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
    
    func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap { transform?($0) }
    }
}
