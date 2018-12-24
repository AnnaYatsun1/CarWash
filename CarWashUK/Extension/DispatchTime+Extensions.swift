//
//  DispatchTime.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension DispatchTime {
    
    static func after(interval: TimeInterval) -> DispatchTime {
        return .now() + interval
    }
    
    static func randomDuration() -> DispatchTime {
        return .after(interval: .random(in: 0.0...1.0))
    }
}

