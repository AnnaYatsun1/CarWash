//
//  RangeReplace.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 05/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection {
    
    mutating func safeRemoveFirst() -> Element? {
        return self.isEmpty ? nil : self.removeFirst()
    }
}
